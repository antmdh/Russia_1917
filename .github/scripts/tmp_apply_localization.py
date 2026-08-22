from __future__ import annotations

import copy
import hashlib
import json
import re
import shutil
import subprocess
from pathlib import Path

from argostranslate import package as argos_package
from argostranslate import translate as argos_translate

PROJECT = Path("Russia 1917 .json")
FICHE_ORIGINAL = Path("Fiche_info/fiche_info_blancs_rempli.json")
PRAVDA_FR = Path("Fiche_info/pravda_titre_et_article_DECISION_FR.json")
README = Path("README_historique.txt")
LANGS = ["FR", "NL", "ES", "EN", "DE", "IT"]
TARGETS = {
    "database.dialogue_petites_phrases",
    "texte_rapport_PV",
    "texte_rapport_RESUME",
    "texte_rapport_EFFET",
    "database.Question_secondaire",
}


def run(*args: str) -> None:
    subprocess.run(args, check=True)


def read_project() -> tuple[dict, str]:
    raw = PROJECT.read_text(encoding="utf-8")
    data = json.loads(raw)
    return data, raw


def dump_project(data: dict) -> None:
    PROJECT.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    json.loads(PROJECT.read_text(encoding="utf-8"))


def validate_roundtrip() -> None:
    data, raw = read_project()
    rebuilt = json.dumps(data, ensure_ascii=False, indent=2) + "\n"
    if rebuilt != raw:
        raise RuntimeError("Le format JSON du projet ne fait pas un aller-retour exact; arrêt par sécurité.")


def commit(message: str, paths: list[str]) -> None:
    run("git", "add", "--", *paths)
    run("git", "diff", "--cached", "--check")
    result = subprocess.run(["git", "diff", "--cached", "--quiet"])
    if result.returncode == 0:
        raise RuntimeError(f"Aucun changement à committer pour: {message}")
    run("git", "commit", "-m", message)


def mode_condition(lang: str) -> dict:
    return {
        "type": {"value": "StringVariable"},
        "parameters": ["MODE_LANGUE", "=", f'"{lang}"'],
    }


def event_lang(event: dict) -> str | None:
    for c in event.get("conditions", []):
        if not isinstance(c, dict):
            continue
        p = c.get("parameters", [])
        if len(p) >= 3 and p[0] == "MODE_LANGUE" and p[1] == "=" and p[2] in {f'"{x}"' for x in LANGS}:
            return p[2].strip('"')
    return None


def target_action(action: dict) -> tuple[str, int] | None:
    if not isinstance(action, dict):
        return None
    p = action.get("parameters", [])
    if len(p) >= 3 and p[0] in TARGETS and p[1] == "=":
        return p[0], 2
    if len(p) >= 4 and p[1] in TARGETS and p[2] == "=":
        return p[1], 3
    return None


def unquote_expr(expr: str) -> str | None:
    s = expr.strip()
    if len(s) < 2 or s[0] != '"' or s[-1] != '"':
        return None
    body = s[1:-1]
    out: list[str] = []
    i = 0
    while i < len(body):
        ch = body[i]
        if ch == "\\" and i + 1 < len(body) and body[i + 1] in {'"', "\\"}:
            out.append(body[i + 1])
            i += 2
        else:
            out.append(ch)
            i += 1
    return "".join(out)


def quote_expr(text: str) -> str:
    return '"' + text.replace("\\", "\\\\").replace('"', '\\"') + '"'


def proofread_fr(text: str) -> str:
    replacements = [
        ("insurection", "insurrection"),
        ("Insurection", "Insurrection"),
        ("reconnaitre", "reconnaître"),
        ("Reconnaitre", "Reconnaître"),
        ("Que votons nous", "Que votons-nous"),
        ("contre révolutionnaires", "contre-révolutionnaires"),
        ("contre révolutionnaire", "contre-révolutionnaire"),
        ("Contre révolutionnaires", "Contre-révolutionnaires"),
        ("Contre révolutionnaire", "Contre-révolutionnaire"),
        ("la classes des travailleurs", "la classe des travailleurs"),
        ("la classes des capitalistes", "la classe des capitalistes"),
        ("Les grandes entreprises dirigés", "Les grandes entreprises dirigées"),
        ("Votons camarade", "Votons, camarade"),
    ]
    for old, new in replacements:
        text = text.replace(old, new)
    return text


def iter_event_lists(node):
    if isinstance(node, dict):
        for k, v in list(node.items()):
            if k == "events" and isinstance(v, list):
                yield v
                for ev in list(v):
                    yield from iter_event_lists(ev)
            elif k != "events":
                yield from iter_event_lists(v)
    elif isinstance(node, list):
        for v in list(node):
            yield from iter_event_lists(v)


def stage1_secure_french(data: dict) -> int:
    moved = 0
    proofread_changes = 0
    for events in list(iter_event_lists(data)):
        # Snapshot: do not revisit language children added in this pass.
        for ev in list(events):
            if not isinstance(ev, dict) or not isinstance(ev.get("actions"), list):
                continue
            current_lang = event_lang(ev)
            matches = []
            keep = []
            for action in ev.get("actions", []):
                hit = target_action(action)
                if hit:
                    target, rhs_i = hit
                    p = action.get("parameters", [])
                    text = unquote_expr(p[rhs_i]) if rhs_i < len(p) else None
                    if text is not None:
                        fixed = proofread_fr(text)
                        if fixed != text:
                            action = copy.deepcopy(action)
                            action["parameters"][rhs_i] = quote_expr(fixed)
                            proofread_changes += 1
                        matches.append(action)
                        continue
                keep.append(action)
            if not matches:
                continue
            if current_lang == "FR":
                ev["actions"] = keep + matches
                moved += len(matches)
                continue
            if current_lang is not None:
                # Existing non-FR branch should never contain the French literals at this stage.
                continue
            ev["actions"] = keep
            fr_event = {
                "type": "BuiltinCommonInstructions::Standard",
                "conditions": [mode_condition("FR")],
                "actions": matches,
            }
            ev.setdefault("events", []).insert(0, fr_event)
            moved += len(matches)
    if moved < 1000:
        raise RuntimeError(f"Seulement {moved} textes français sécurisés; attendu > 1000.")
    print("STAGE1 secured", moved, "actions; proofreading edits", proofread_changes)
    return moved


def validate_target_languages(data: dict, expected_langs: set[str]) -> dict[str, int]:
    counts = {lang: 0 for lang in expected_langs}
    outside = 0

    def walk(node, inherited: tuple[str, ...] = ()): 
        nonlocal outside
        if isinstance(node, dict):
            langs = inherited
            lang = event_lang(node)
            if lang:
                langs = inherited + (lang,)
            for a in node.get("actions", []) if isinstance(node.get("actions"), list) else []:
                hit = target_action(a)
                if not hit:
                    continue
                _, rhs_i = hit
                p = a.get("parameters", [])
                if rhs_i >= len(p) or unquote_expr(p[rhs_i]) is None:
                    continue
                active = next((x for x in reversed(langs) if x in expected_langs), None)
                if active:
                    counts[active] += 1
                else:
                    outside += 1
            for v in node.values():
                walk(v, langs)
        elif isinstance(node, list):
            for v in node:
                walk(v, inherited)
    walk(data)
    if outside:
        raise RuntimeError(f"{outside} affectations textuelles ciblées restent hors condition MODE_LANGUE.")
    vals = [counts[x] for x in expected_langs]
    if vals and (min(vals) == 0 or len(set(vals)) != 1):
        raise RuntimeError(f"Comptages de langues incohérents: {counts}")
    return counts


class Translator:
    def __init__(self):
        self.direct: set[str] = set()
        self.cache: dict[tuple[str, str], str] = {}
        self._install_models()

    def _install_models(self):
        argos_package.update_package_index()
        available = argos_package.get_available_packages()
        installed_pairs = {(p.from_code, p.to_code) for p in argos_package.get_installed_packages()}

        def install_pair(src: str, dst: str) -> bool:
            nonlocal installed_pairs
            if (src, dst) in installed_pairs:
                return True
            pkg = next((p for p in available if p.from_code == src and p.to_code == dst), None)
            if not pkg:
                return False
            path = pkg.download()
            argos_package.install_from_path(path)
            installed_pairs.add((src, dst))
            return True

        # Prefer direct French models; fall back through English.
        for lang in ["en", "nl", "es", "de", "it"]:
            if install_pair("fr", lang):
                self.direct.add(lang)
        if any(lang not in self.direct for lang in ["nl", "es", "de", "it"]):
            if "en" not in self.direct and not install_pair("fr", "en"):
                raise RuntimeError("Modèle Argos fr->en introuvable")
            self.direct.add("en")
            for lang in ["nl", "es", "de", "it"]:
                if lang not in self.direct and not install_pair("en", lang):
                    raise RuntimeError(f"Aucun modèle de traduction disponible pour {lang}")
        print("ARGOS direct FR targets", sorted(self.direct))

    def raw(self, text: str, lang: str) -> str:
        target = lang.lower()
        if target == "fr" or not text.strip():
            return text
        key = (target, text)
        if key in self.cache:
            return self.cache[key]
        if target in self.direct:
            out = argos_translate.translate(text, "fr", target)
        else:
            mid = argos_translate.translate(text, "fr", "en")
            out = argos_translate.translate(mid, "en", target)
        self.cache[key] = out
        return out

    @staticmethod
    def technical(text: str) -> bool:
        parts = [p.strip() for p in text.split(";") if p.strip()]
        if not parts:
            return True
        if len(parts) >= 3 and len(set(parts)) <= 2 and all(re.fullmatch(r"[0-9A-Za-z_.]+", p) for p in parts):
            return True
        if len(text) < 80 and all(re.fullmatch(r"[0-9A-Za-z_.]+", p) for p in parts):
            return True
        return False

    def semicolons(self, text: str, lang: str) -> str:
        if self.technical(text):
            return text
        # Translate chunks that end on semicolon boundaries; normally Argos preserves punctuation.
        parts = text.split(";")
        result: list[str] = []
        block: list[str] = []
        size = 0

        def flush():
            nonlocal block, size
            if not block:
                return
            source = ";".join(block)
            translated = self.raw(source, lang)
            if translated.count(";") != source.count(";"):
                translated_parts = [self.raw(x, lang) if x.strip() else x for x in block]
                translated = ";".join(translated_parts)
            result.append(translated)
            block = []
            size = 0

        for part in parts:
            extra = len(part) + (1 if block else 0)
            if block and size + extra > 2400:
                flush()
            block.append(part)
            size += extra
        flush()
        out = ";".join(result)
        # Joining chunk outputs introduced one separator between chunks, which is desired.
        if out.count(";") != text.count(";"):
            raise RuntimeError(f"Le nombre de séparateurs ';' a changé pour {lang}")
        return out

    def paragraphs(self, text: str, lang: str) -> str:
        if self.technical(text):
            return text
        pieces = re.split(r"(\n+)", text)
        out = []
        for piece in pieces:
            if not piece or piece.startswith("\n"):
                out.append(piece)
            elif len(piece) <= 2600:
                out.append(self.raw(piece, lang))
            else:
                # Long single paragraph: split conservatively at sentence boundaries.
                sentences = re.split(r"(?<=[.!?])\s+", piece)
                buf = ""
                chunks = []
                for s in sentences:
                    if buf and len(buf) + len(s) + 1 > 2400:
                        chunks.append(buf)
                        buf = s
                    else:
                        buf = s if not buf else buf + " " + s
                if buf:
                    chunks.append(buf)
                out.append(" ".join(self.raw(c, lang) for c in chunks))
        return "".join(out)

    def for_target(self, text: str, lang: str, target: str) -> str:
        if lang == "FR" or self.technical(text):
            return text
        if target == "database.dialogue_petites_phrases":
            return self.semicolons(text, lang)
        if target == "database.Question_secondaire":
            return self.raw(text, lang)
        return self.paragraphs(text, lang)

    def json_value(self, text: str, lang: str) -> str:
        if self.technical(text):
            return text
        return self.paragraphs(text, lang)


def stage2_translate_inline(data: dict, tr: Translator) -> int:
    created_actions = 0
    for events in list(iter_event_lists(data)):
        original_events = list(events)
        additions = []
        for idx, ev in enumerate(original_events):
            if not isinstance(ev, dict) or event_lang(ev) != "FR":
                continue
            fr_actions = []
            for a in ev.get("actions", []) if isinstance(ev.get("actions"), list) else []:
                hit = target_action(a)
                if hit:
                    target, rhs_i = hit
                    p = a.get("parameters", [])
                    text = unquote_expr(p[rhs_i]) if rhs_i < len(p) else None
                    if text is not None:
                        fr_actions.append((target, rhs_i, text))
            if not fr_actions:
                continue
            siblings = []
            for lang in ["NL", "ES", "EN", "DE", "IT"]:
                clone = copy.deepcopy(ev)
                for c in clone.get("conditions", []):
                    p = c.get("parameters", [])
                    if len(p) >= 3 and p[0] == "MODE_LANGUE" and p[1] == "=" and p[2] == '"FR"':
                        p[2] = f'"{lang}"'
                for a in clone.get("actions", []):
                    hit = target_action(a)
                    if not hit:
                        continue
                    target, rhs_i = hit
                    text = unquote_expr(a["parameters"][rhs_i])
                    if text is None:
                        continue
                    translated = tr.for_target(text, lang, target)
                    a["parameters"][rhs_i] = quote_expr(translated)
                    created_actions += 1
                siblings.append(clone)
            additions.append((idx, siblings))
        # Insert from right to left so indices remain stable.
        for idx, siblings in reversed(additions):
            pos = idx + 1
            events[pos:pos] = siblings
    if created_actions < 5000:
        raise RuntimeError(f"Seulement {created_actions} actions traduites; attendu > 5000")
    print("STAGE2 translated actions", created_actions)
    return created_actions


def translate_json_tree(value, tr: Translator, lang: str):
    if isinstance(value, str):
        return tr.json_value(value, lang)
    if isinstance(value, list):
        return [translate_json_tree(v, tr, lang) for v in value]
    if isinstance(value, dict):
        return {k: translate_json_tree(v, tr, lang) for k, v in value.items()}
    return value


def file_hash(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def add_json_resources(data: dict, paths: list[str], template_path: str) -> None:
    resources = data["resources"]["resources"]
    existing = {r.get("name") for r in resources if isinstance(r, dict)}
    template = next((r for r in resources if isinstance(r, dict) and r.get("name") == template_path), None)
    if not template:
        raise RuntimeError(f"Ressource modèle introuvable: {template_path}")
    template_index = resources.index(template)
    to_insert = []
    for p in paths:
        if p in existing:
            continue
        r = copy.deepcopy(template)
        r["file"] = p
        r["name"] = p
        to_insert.append(r)
        existing.add(p)
    resources[template_index + 1:template_index + 1] = to_insert


def replace_loader_path(action: dict, original: str, replacement: str) -> dict:
    a = copy.deepcopy(action)
    p = a.get("parameters", [])
    for i, val in enumerate(p):
        if val == original:
            p[i] = replacement
        elif isinstance(val, str):
            decoded = unquote_expr(val)
            if decoded and decoded.endswith(original):
                new = decoded[: -len(original)] + replacement
                p[i] = quote_expr(new)
    return a


def localize_loaders(data: dict, original_resource: str, mapping: dict[str, str]) -> int:
    changed = 0
    for events in list(iter_event_lists(data)):
        for ev in list(events):
            if not isinstance(ev, dict) or not isinstance(ev.get("actions"), list):
                continue
            current_lang = event_lang(ev)
            matching = []
            keep = []
            for a in ev.get("actions", []):
                params = a.get("parameters", []) if isinstance(a, dict) else []
                has = original_resource in params
                if not has:
                    for val in params:
                        dec = unquote_expr(val) if isinstance(val, str) else None
                        if dec and dec.endswith(original_resource):
                            has = True
                            break
                if has and a.get("type", {}).get("value") in {
                    "JSONResourceLoader::LoadJSONToScene",
                    "FileSystem::LoadVariableFromJSONFileSync",
                }:
                    matching.append(a)
                else:
                    keep.append(a)
            if not matching:
                continue
            if current_lang:
                # If already localized, only swap the path for that language.
                ev["actions"] = keep + [replace_loader_path(a, original_resource, mapping[current_lang]) for a in matching]
                changed += len(matching)
                continue
            ev["actions"] = keep
            children = []
            for lang in LANGS:
                children.append({
                    "type": "BuiltinCommonInstructions::Standard",
                    "conditions": [mode_condition(lang)],
                    "actions": [replace_loader_path(a, original_resource, mapping[lang]) for a in matching],
                })
                changed += len(matching)
            ev.setdefault("events", [])[0:0] = children
    if changed == 0:
        raise RuntimeError(f"Aucun import localisé pour {original_resource}")
    return changed


def validate_json_files(paths: list[Path]) -> None:
    for p in paths:
        json.loads(p.read_text(encoding="utf-8"))


def stage3_fiche_info(data: dict, tr: Translator) -> list[Path]:
    original_hash = file_hash(FICHE_ORIGINAL)
    source = json.loads(FICHE_ORIGINAL.read_text(encoding="utf-8"))
    stem = FICHE_ORIGINAL.with_suffix("")
    out_paths: dict[str, Path] = {}
    fr_path = Path(str(stem) + "_FR.json")
    shutil.copyfile(FICHE_ORIGINAL, fr_path)
    out_paths["FR"] = fr_path
    for lang in ["NL", "ES", "EN", "DE", "IT"]:
        p = Path(str(stem) + f"_{lang}.json")
        translated = translate_json_tree(source, tr, lang)
        p.write_text(json.dumps(translated, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        out_paths[lang] = p
    validate_json_files(list(out_paths.values()))
    if file_hash(FICHE_ORIGINAL) != original_hash:
        raise RuntimeError("Le fichier fiche_info_blancs_rempli.json original a été modifié")
    mapping = {lang: str(path).replace("\\", "/") for lang, path in out_paths.items()}
    add_json_resources(data, list(mapping.values()), "Fiche_info/fiche_info_blancs_rempli.json")
    n = localize_loaders(data, "Fiche_info/fiche_info_blancs_rempli.json", mapping)
    print("STAGE3 localized loader actions", n)
    return list(out_paths.values())


def stage4_pravda(data: dict, tr: Translator) -> list[Path]:
    original_hash = file_hash(PRAVDA_FR)
    source = json.loads(PRAVDA_FR.read_text(encoding="utf-8"))
    mapping: dict[str, str] = {"FR": str(PRAVDA_FR).replace("\\", "/")}
    out_paths = []
    for lang in ["NL", "ES", "EN", "DE", "IT"]:
        p = PRAVDA_FR.with_name(PRAVDA_FR.name.replace("_FR.json", f"_{lang}.json"))
        translated = translate_json_tree(source, tr, lang)
        p.write_text(json.dumps(translated, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        mapping[lang] = str(p).replace("\\", "/")
        out_paths.append(p)
    validate_json_files(out_paths + [PRAVDA_FR])
    if file_hash(PRAVDA_FR) != original_hash:
        raise RuntimeError("Le fichier Pravda FR original a été modifié")
    add_json_resources(data, [mapping[x] for x in ["NL", "ES", "EN", "DE", "IT"]], mapping["FR"])
    n = localize_loaders(data, mapping["FR"], mapping)
    print("STAGE4 localized loader actions", n)
    return out_paths


def stage5_readme() -> None:
    old = README.read_text(encoding="utf-8")
    header = """22 août 2026\nLocalisation multilingue :\n- sécurisation des textes français de database.dialogue_petites_phrases, texte_rapport_PV, texte_rapport_RESUME, texte_rapport_EFFET et database.Question_secondaire avec la condition MODE_LANGUE = \"FR\" ;\n- ajout des traductions NL, ES, EN, DE et IT pour ces mêmes textes ;\n- création des six variantes linguistiques de Fiche_info/fiche_info_blancs_rempli.json (FR, NL, ES, EN, DE, IT) sans supprimer le fichier original, et chargement selon MODE_LANGUE ;\n- création des variantes NL, ES, EN, DE et IT de Fiche_info/pravda_titre_et_article_DECISION_FR.json, conservation de l'original FR, et chargement selon MODE_LANGUE.\n\n"""
    if old.startswith("22 août 2026\nLocalisation multilingue"):
        raise RuntimeError("L'historique de localisation est déjà présent")
    README.write_text(header + old, encoding="utf-8")


def main():
    validate_roundtrip()
    run("git", "config", "user.name", "Antoine Moens de Hase")
    run("git", "config", "user.email", "88080281+antmdh@users.noreply.github.com")

    # 1. French safeguarding.
    data, _ = read_project()
    stage1_secure_french(data)
    dump_project(data)
    counts = validate_target_languages(data, {"FR"})
    print("STAGE1 counts", counts)
    commit("securise les textes francais des rapports et dialogues", [str(PROJECT)])

    # Models are only needed from point 2 onward.
    tr = Translator()

    # 2. Inline translations.
    data, _ = read_project()
    stage2_translate_inline(data, tr)
    dump_project(data)
    counts = validate_target_languages(data, set(LANGS))
    print("STAGE2 counts", counts)
    # Guard against literal backslash+n in newly localized visible strings.
    def check_newlines(node):
        if isinstance(node, dict):
            for a in node.get("actions", []) if isinstance(node.get("actions"), list) else []:
                hit = target_action(a)
                if hit:
                    _, i = hit
                    p = a.get("parameters", [])
                    text = unquote_expr(p[i]) if i < len(p) else None
                    if text is not None and "\\n" in text:
                        raise RuntimeError("Séquence littérale \\n détectée dans un texte localisé")
            for v in node.values(): check_newlines(v)
        elif isinstance(node, list):
            for v in node: check_newlines(v)
    check_newlines(data)
    commit("traduit les rapports et dialogues en cinq langues", [str(PROJECT)])

    # 3. White-faction info files and loaders.
    data, _ = read_project()
    fiche_paths = stage3_fiche_info(data, tr)
    dump_project(data)
    commit("localise les fiches info des blancs", [str(PROJECT)] + [str(p) for p in fiche_paths])

    # 4. Pravda decision articles and loaders.
    data, _ = read_project()
    pravda_paths = stage4_pravda(data, tr)
    dump_project(data)
    commit("localise les articles Pravda de decision", [str(PROJECT)] + [str(p) for p in pravda_paths])

    # 5. Development history.
    stage5_readme()
    commit("documente la localisation multilingue", [str(README)])

    run("python", "-m", "json.tool", str(PROJECT), "/dev/null")
    for p in fiche_paths + pravda_paths + [FICHE_ORIGINAL, PRAVDA_FR]:
        run("python", "-m", "json.tool", str(p), "/dev/null")
    run("git", "diff", "--check", "HEAD~5", "HEAD")
    print("DONE")


if __name__ == "__main__":
    main()
