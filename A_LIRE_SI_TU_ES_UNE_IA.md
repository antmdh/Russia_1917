# À LIRE SI TU ES UNE IA

Ce fichier est destiné à toute IA qui intervient sur le dépôt **Russia_1917**.

L'objectif principal est simple : **aider à modifier le jeu sans casser la logique GDevelop existante, sans renommer des variables techniques et sans supprimer des ressources qui servent encore ailleurs.**

---

## 1. Le projet

**Russia 1917** est un jeu mobile développé avec **GDevelop**, centré sur la Révolution russe et la guerre civile russe.

Le fichier principal du projet est :

`Russia 1917 .json`

Attention : il y a bien un espace avant `.json` dans le nom du fichier.

La scène stratégique principale utilisée pour la démo est notamment :

`Carte_strat_V9_DEMO`

Le dépôt contient également de nombreuses ressources JSON, images, sons et fichiers historiques utilisés par le projet.

---

## 2. Règle fondamentale : modifier le moins possible

Quand une modification est demandée :

1. identifier précisément le bloc concerné ;
2. modifier uniquement ce bloc ;
3. conserver les noms des variables, objets, groupes, fonctions et ressources existants ;
4. ne pas « nettoyer » ou réorganiser le reste du fichier par initiative personnelle ;
5. ne pas modifier une logique de jeu qui n'est pas directement concernée par la demande ;
6. vérifier le diff avant de valider le changement.

Le fichier `Russia 1917 .json` est très volumineux. Une réécriture globale, un reformatage inutile ou une sérialisation différente peut produire des milliers de changements parasites.

**Il faut donc éviter les modifications massives non nécessaires.**

---

## 3. Ne jamais renommer une variable technique sans demande explicite

Dans GDevelop, les noms de variables sont utilisés dans de nombreux événements et sous-événements.

Exemples importants :

- `MODE_LANGUE`
- `TABLE_MOIS_QUESTION`
- `MOISetSemaine_encours`
- `database.dialogue_petites_phrases`
- `database.Question_secondaire`
- `texte_rapport_PV`
- `texte_rapport_RESUME`
- `texte_rapport_EFFET`

Même si un nom contient une faute, une majuscule étrange ou une syntaxe peu élégante, **ne pas le corriger spontanément**.

Une variable mal renommée peut casser silencieusement plusieurs dizaines d'événements.

---

## 4. Gestion des langues

Le projet utilise six langues :

- `FR` = français
- `NL` = néerlandais
- `EN` = anglais
- `ES` = espagnol
- `IT` = italien
- `DE` = allemand

La variable de projet utilisée est :

`MODE_LANGUE`

Quand un texte dépend de la langue, la logique attendue est généralement :

- `MODE_LANGUE = "FR"`
- `MODE_LANGUE = "NL"`
- `MODE_LANGUE = "EN"`
- `MODE_LANGUE = "ES"`
- `MODE_LANGUE = "IT"`
- `MODE_LANGUE = "DE"`

Les blocs linguistiques doivent rester au **même niveau logique** afin que seule la langue active soit exécutée.

### Textes déjà internationalisés dans le menu 9 / rapports

Les cinq cibles suivantes ont été internationalisées pour les six langues :

- `database.dialogue_petites_phrases`
- `texte_rapport_PV`
- `texte_rapport_RESUME`
- `texte_rapport_EFFET`
- `database.Question_secondaire`

Ne pas remettre ces textes hors condition `MODE_LANGUE`.

---

## 5. Retours à la ligne dans les textes GDevelop

Point très important : dans les chaînes multilignes de GDevelop, conserver de **vrais retours à la ligne**.

Ne pas remplacer les retours à la ligne par :

- `\\n`
- `/n`
- une autre séquence littérale

Une traduction doit conserver la structure du texte original autant que possible.

Si un texte contient plusieurs lignes, la traduction doit également utiliser de vrais retours à la ligne.

---

## 6. Ne pas traduire les identifiants techniques

Certaines chaînes ressemblent à du texte mais sont en réalité des identifiants de décisions, événements ou références internes.

Exemples :

- `6.Creation_tcheka`
- `8.Mariage_civil_egalite_hf`

Par défaut : **ne pas traduire ce type de chaîne**.

Avant de traduire une valeur, vérifier si elle est réellement visible par le joueur ou si elle sert de clé technique.

---

## 7. Fichiers JSON de fiches d'information

Le fichier source historique existe toujours :

`Fiche_info/fiche_info_blancs_rempli.json`

**Ne pas supprimer ce fichier original.**

Il existe également des variantes linguistiques :

- `Fiche_info/fiche_info_blancs_rempli_FR.json`
- `Fiche_info/fiche_info_blancs_rempli_NL.json`
- `Fiche_info/fiche_info_blancs_rempli_EN.json`
- `Fiche_info/fiche_info_blancs_rempli_ES.json`
- `Fiche_info/fiche_info_blancs_rempli_IT.json`
- `Fiche_info/fiche_info_blancs_rempli_DE.json`

Lorsqu'un import de ces fiches est localisé, le chemin doit être choisi selon `MODE_LANGUE`.

Exemple de principe :

- FR → `Fiche_info/fiche_info_blancs_rempli_FR.json`
- NL → `Fiche_info/fiche_info_blancs_rempli_NL.json`
- EN → `Fiche_info/fiche_info_blancs_rempli_EN.json`
- ES → `Fiche_info/fiche_info_blancs_rempli_ES.json`
- IT → `Fiche_info/fiche_info_blancs_rempli_IT.json`
- DE → `Fiche_info/fiche_info_blancs_rempli_DE.json`

Mais **l'original `fiche_info_blancs_rempli.json` doit rester dans le dépôt**, car d'autres versions ou parties du projet peuvent encore en dépendre.

Cette règle vaut également pour les autres ressources historiques : ne jamais supprimer le fichier source simplement parce qu'une variante linguistique existe.

---

## 8. Calendrier : mois et semaines

Le jeu fonctionne historiquement principalement par mois, mais les premiers mois de la Révolution contiennent beaucoup plus d'événements.

Une logique hebdomadaire a été ajoutée pour mieux répartir les décisions politiques au début du jeu.

La valeur :

`TABLE_MOIS_QUESTION.MOISetSemaine_encours`

utilise une représentation qui combine le mois et la semaine.

Exemple de logique utilisée :

`19171101`

Il faut être extrêmement prudent quand on modifie les comparaisons de dates : certaines parties du jeu utilisent encore une logique mensuelle tandis que d'autres utilisent la semaine.

Ne pas convertir globalement toutes les dates sans analyser le bloc concerné.

---

## 9. Pause et déplacement des troupes blanches

Une correction importante a été faite sur la pause des unités blanches.

Principe actuel :

1. avant la pause, la vitesse du soldat blanc est sauvegardée ;
2. pendant la pause, sa vitesse passe à `0` ;
3. à la reprise, sa vitesse précédente est restaurée.

La variable utilisée sur l'objet est notamment :

`soldatblanc.vitesse_avant_pause`

Ne pas remplacer cette logique par une valeur de vitesse fixe à la reprise : toutes les troupes n'ont pas nécessairement la même vitesse.

---

## 10. Problèmes connus / éléments à vérifier

Le fichier `README_historique.txt` contient le journal de développement et doit être consulté avant une modification importante.

Parmi les éléments déjà identifiés :

- la logique semaine/mois des premières décisions politiques a été retravaillée ;
- l'internationalisation en six langues est en cours dans différentes parties du projet ;
- un problème concernant des troupes japonaises qui peuvent quitter leur zone d'action a été relié au statut `JAPONAIS` configuré en `ACTIF` au lieu de `ACTIF_LIMITE` ; ne pas appliquer cette correction sans vérifier l'état actuel du code et la demande de l'utilisateur.

Un problème mentionné dans l'historique peut avoir été corrigé depuis : **toujours vérifier le code actuel avant d'agir.**

---

## 11. Méthode de travail recommandée pour une IA

Avant toute modification :

1. lire ce fichier ;
2. lire les dernières lignes de `README_historique.txt` ;
3. vérifier la branche et le commit actuels ;
4. rechercher toutes les occurrences du nom de variable, objet ou ressource concerné ;
5. comprendre la structure parent/enfant des événements GDevelop ;
6. identifier ce qui est du texte joueur et ce qui est un identifiant technique.

Après modification :

1. vérifier que le JSON est valide ;
2. vérifier que les fichiers JSON externes modifiés sont valides ;
3. vérifier qu'aucun fichier source requis n'a été supprimé ;
4. vérifier qu'aucune variable technique n'a été renommée ;
5. inspecter le diff ;
6. vérifier qu'il n'y a pas de gros changements parasites ;
7. créer un commit au message clair et limité à la tâche demandée.

---

## 12. Git et commits

Éviter de travailler directement sur `main` pour une modification réalisée par une IA.

Préférer une branche dédiée, puis un commit limité aux fichiers réellement concernés.

Ne jamais inclure dans un commit final :

- scripts temporaires d'audit ;
- workflows GitHub temporaires ;
- fichiers de test ;
- `.DS_Store` ajouté accidentellement ;
- `.Rhistory` ajouté accidentellement ;
- fichiers autosave modifiés sans rapport avec la tâche.

Si un script ou un workflow temporaire est nécessaire pour manipuler le très gros fichier GDevelop, il doit être retiré du résultat final sauf demande contraire explicite.

---

## 13. Ne pas supprimer l'original lorsque l'on crée des variantes

C'est une règle générale de ce projet.

Quand l'utilisateur demande :

> créer plusieurs versions d'un fichier selon la langue

il faut généralement :

1. conserver l'original ;
2. créer les variantes demandées ;
3. ajouter les ressources au projet si nécessaire ;
4. conditionner le chemin d'import selon `MODE_LANGUE` ;
5. vérifier que les autres scènes ou versions du jeu utilisant encore l'original ne sont pas cassées.

**Créer une nouvelle version ne signifie jamais supprimer automatiquement l'ancienne.**

---

## 14. Priorité absolue : la demande de l'utilisateur

Ce document donne des règles de sécurité et de continuité, mais la demande explicite de l'utilisateur reste la référence pour la tâche en cours.

Si une demande semble entrer en conflit avec une ancienne règle ou un ancien commentaire :

- vérifier le code actuel ;
- expliquer le conflit si nécessaire ;
- ne pas inventer une nouvelle logique sans validation.

Le but n'est pas de rendre le projet « plus propre » selon les préférences de l'IA.

Le but est de **modifier précisément Russia 1917 sans casser ce qui fonctionne déjà.**
