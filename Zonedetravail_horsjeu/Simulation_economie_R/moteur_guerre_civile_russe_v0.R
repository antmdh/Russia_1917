###############################################################################
# MOTEUR DE SIMULATION - GUERRE CIVILE RUSSE 1917-1922
# Version 0.1 de travail
#
# Objectif :
# - Simuler 62 tours mensuels, de novembre 1917 à décembre 1922.
# - Garder un code LONG, LISIBLE et MODIFIABLE.
# - Les règles politiques importantes sont codées en dur, avec commentaires.
# - Les données de comportement des camps peuvent être importées depuis Excel.
# - Les fonctions internes utilisent surtout des vecteurs, matrices et listes R de base
#   pour rester rapides lorsque l'on testera de nombreux scénarios.
#
# Convention importante :
# - Le tour 0 = 191711 = novembre 1917.
# - Le tour 1 = 191712 = décembre 1917.
# - Le tour 61 = 192212 = décembre 1922.
###############################################################################

###############################################################################
# 1. VALEURS FIXES DU JEU - A MODIFIER ICI EN PRIORITE
###############################################################################

PARAM <- list(
  # Dates de la simulation
  date_debut = 191711,
  date_fin   = 192212,

  # Production des villes
  production_stock_initial_par_ville = 10L,
  production_max_unite_par_ville_par_mois = 1L,
  seuil_adhesion_pour_produire = 50L,
  seuil_economie_pour_produire = 50L,
  score_base_adhesion = 50L,
  score_base_economie = 50L,

  # Famine
  # Une ville industrielle compte -1, une ville agricole compte +1.
  # Si une composante connectée bolchevique a un total <= 0 pendant plus de 3 mois,
  # alors cette composante est en famine.
  famine_seuil_nourriture = 0L,
  famine_declenchement_apres_mois = 3L,
  famine_penalite_adhesion = -10L,
  famine_penalite_economie = -10L,

  # Expansion bolchevique automatique pour le premier comportement stratégique.
  # "cercle_progressiste" : à partir de Petrograd puis Moscou, conquiert tous les 2 mois
  # une ville voisine d'une ville déjà bolchevique, en choisissant la plus proche
  # selon les coordonnées x/y fournies.
  expansion_tour_petrograd = 0L,
  expansion_tour_moscou = 1L,
  expansion_chaque_n_mois = 2L,

  # Exhaustivité des scénarios politiques.
  # ATTENTION : toutes les permutations de 43-50 décisions sont astronomiques.
  # Par défaut on plafonne le nombre de scénarios générés. Tu peux augmenter cette
  # valeur si tu veux lancer un calcul lourd.
  max_scenarios_a_generer = 10000L,
  max_politiques_par_scenario = 12L,

  # Import Excel : si tu déplaces les fichiers, change seulement ces chemins.
  fichier_comportement_camps = "/Users/antoineetholly/Documents/GitHub/Russia_1917/Zonedetravail_horsjeu/Simulation_economie_R/database_comportement_blanc.xlsx",
  

  # Package d'import Excel.
  # Le moteur fonctionne si readxl est installé. Sinon, tu peux remplacer la fonction
  # importer_comportement_camps() par un read.csv ou coller le tableau en dur.
  utiliser_readxl = TRUE
)

###############################################################################
# 2. OUTILS DE DATES - format AAAAMM en entier
###############################################################################

mois_suivant <- function(date_aaaamm) {
  annee <- date_aaaamm %/% 100L
  mois  <- date_aaaamm %% 100L
  if (mois == 12L) {
    return((annee + 1L) * 100L + 1L)
  }
  annee * 100L + mois + 1L
}

sequence_mois <- function(date_debut, date_fin) {
  out <- integer(0)
  d <- date_debut
  while (d <= date_fin) {
    out <- c(out, d)
    d <- mois_suivant(d)
  }
  out
}

DATES_JEU <- sequence_mois(PARAM$date_debut, PARAM$date_fin)
N_TOURS <- length(DATES_JEU)
# Normalement : 62 mois, de 191711 à 192212 inclus.

###############################################################################
# 3. VILLES - données codées en dur pour la vitesse et la lisibilité
###############################################################################

stations <- data.frame(
  name = c("Varsovie","Vladivostok","Khabarovsk","Irkustk","Novosibirsk",
           "Sebastopol","Bakou","Erevan","Tbilissi","Tashkent","Omsk",
           "Yekaterin...","Perm","Kazan","Samara","Tsaritsyn","Rostov",
           "Kharkov","Kiev","Minsk","Br.Litovsk","Riga","Tallin",
           "Helsinski","Moscou","Petrograd","Archangel","Murmansk"),
  x = c(645,4727,4788,3663,2883,1114,1595,1417,1389,2360,2561,2127,1999,
        1666,1715,1506,1343,1172,1021,909,767,775,833,774,1244,979,1378,1098),
  y = c(1970,2414,2106,1975,1794,2332,2480,2474,2324,2534,1819,1690,1642,
        1733,1888,2130,2219,2083,2044,1849,1936,1675,1513,1401,1713,1493,
        1198,920),
  stringsAsFactors = FALSE
)

edges <- data.frame(
  from = c("Murmansk","Archangel","Helsinski","Tallin","Tallin","Riga","Riga",
           "Riga","Br.Litovsk","Minsk","Minsk","Kiev","Kiev","Kharkov","Kharkov",
           "Kharkov","Rostov","Rostov","Rostov","Tsaritsyn","Tsaritsyn",
           "Tsaritsyn","Tbilissi","Tbilissi","Samara","Kazan","Kazan",
           "Petrograd","Samara","Kazan","Perm","Yekaterin...","Samara","Omsk",
           "Novosibirsk","Irkustk","Vladivostok","Khabarovsk","Khabarovsk"),
  to   = c("Moscou","Moscou","Petrograd","Petrograd","Riga","Petrograd",
           "Minsk","Br.Litovsk","Minsk","Moscou","Kiev","Moscou","Kharkov",
           "Sebastopol","Moscou","Rostov","Moscou","Tbilissi","Tsaritsyn",
           "Moscou","Samara","Tbilissi","Bakou","Erevan","Moscou","Moscou",
           "Rostov","Moscou","Tashkent","Perm","Yekaterin...","Omsk","Omsk",
           "Novosibirsk","Irkustk","Khabarovsk","Khabarovsk","Irkustk",
           "Novosibirsk"),
  stringsAsFactors = FALSE
)

# Caractéristiques importées depuis ton fichier Characteristique_villes.xlsx,
# recopiées ici en dur pour éviter un import à chaque simulation.
# Modifier ces lignes suffit pour changer toute la logique de nourriture/adhésion.
caracteristiques_villes <- data.frame(
  Ville_NOM = c("Irkustk","Kazan","Khabarovsk","Murmansk","Omsk","Samara",
                "Vladivostok","Archangel","Moscou","Novosibirsk","Perm",
                "Petrograd","Rostov","Tsaritsyn","Yekaterin...","Br.Litovsk",
                "Erevan","Helsinski","Kiev","Minsk","Sebastopol","Tashkent",
                "Tbilissi","Varsovie","Bakou","Kharkov","Tallin", "Riga"),
  type_prod = c("agricole","agricole","agricole","agricole","agricole","agricole",
                "agricole","industriel","industriel","industriel","industriel",
                "industriel","industriel","industriel","industriel","agricole",
                "agricole","agricole","agricole","agricole","agricole","agricole",
                "agricole","agricole","industriel","industriel","industriel","industriel"),
  nationalite = c("grandrusse","grandrusse","grandrusse","grandrusse","grandrusse",
                  "grandrusse","grandrusse","grandrusse","grandrusse","grandrusse",
                  "grandrusse","grandrusse","grandrusse","grandrusse","grandrusse",
                  "nationalite","nationalite","nationalite","nationalite","nationalite",
                  "nationalite","nationalite","nationalite","nationalite","nationalite",
                  "nationalite","nationalite","nationalite"),
  nourriture = c(1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1),
  stringsAsFactors = FALSE
)



VILLES <- stations$name
N_VILLES <- length(VILLES)
idx_ville <- setNames(seq_along(VILLES), VILLES)

# Mise dans le même ordre que stations.
caracteristiques_villes <- caracteristiques_villes[match(VILLES, caracteristiques_villes$Ville_NOM), ]
stopifnot(all(caracteristiques_villes$Ville_NOM == VILLES))

###############################################################################
# 4. MATRICE D'ADJACENCE - rapide pour composantes et conquêtes
###############################################################################

creer_adjacence <- function(villes, edges) {
  n <- length(villes)
  id <- setNames(seq_len(n), villes)
  A <- matrix(FALSE, nrow=n, ncol=n, dimnames=list(villes, villes))
  for (i in seq_len(nrow(edges))) {
    a <- edges$from[i]
    b <- edges$to[i]
    if (!is.na(id[a]) && !is.na(id[b])) {
      A[id[a], id[b]] <- TRUE
      A[id[b], id[a]] <- TRUE
    }
  }
  A
}

ADJ <- creer_adjacence(VILLES, edges)

###############################################################################
# 5. IMPORT DU TABLEAU DE COMPORTEMENT DES CAMPS
###############################################################################

importer_comportement_camps <- function(fichier = PARAM$fichier_comportement_camps) {
  if (!PARAM$utiliser_readxl) {
    stop("PARAM$utiliser_readxl est FALSE : colle le tableau comportement en dur ou remplace par read.csv.")
  }
  if (!requireNamespace("readxl", quietly = TRUE)) {
    stop("Le package readxl n'est pas installé. Installe-le avec install.packages('readxl') ou colle le tableau en dur.")
  }
  x <- readxl::read_excel(fichier)
  names(x) <- c("DATE_NBR","CAMP_TXT","STATUT_TXT","VILLES_ACQUISES_TXT",
                "UNITE_A_CONSTRUIRE_NBR","VILLE_CREATION_REF")
  x <- as.data.frame(x, stringsAsFactors = FALSE)
  x$DATE_NBR <- as.integer(x$DATE_NBR)
  x$UNITE_A_CONSTRUIRE_NBR <- as.integer(ifelse(is.na(x$UNITE_A_CONSTRUIRE_NBR), 0L, x$UNITE_A_CONSTRUIRE_NBR))
  x
}

###############################################################################
# 6. POLITIQUES - règles codées en dur, modifiables une par une
###############################################################################

# Structure choisie : une data.frame pour les métadonnées rapides + une fonction
# apply_decision_effect() qui contient les effets commentés.
# Pourquoi pas tout dans un tableau ? Parce que les effets sont très hétérogènes :
# villes, camps, ressources à allouer, effets conditionnels, refus, etc.

creer_table_politiques <- function() {
  data.frame(
    ref = c(
      "1.Faire_la_revolution",
      "3.Decret_sur_la_terre",
      "2.Decret_sur_la_paix",
      "4.Droit_autodetermination_peuples",
      "5.Decret_controle_ouvrier",
      "6.Creation_tcheka",
      "7.Independance_finlande",
      "7.independance_ukraine",
      "7.Independance_turkmenistan",
      "7.Independance_bielorusse",
      "7.independance_caucase",
      "7.independance_baltes",
      "8.Mariage_civil_egalite_hf",
      "9.Nationalisation_banques_dettes",
      "10.Dissolution_assemblee_constituante",
      "11.Creation_armee_rouge",
      "12.Calendrier_gregorien",
      "13.Accord_brest_litovsk",
      "14.Congres_education",
      "15.Monopole_commerce_exterieur",
      "16.Dictature_alimentaire",
      "17.Nationalisation_grande_industrie",
      "18.Comites_paysans_pauvres",
      "19.Constitution_RSFSR",
      "20.Execution_tsar",
      "21.Terreur_rouge",
      "22.Code_famille",
      "23.Journee_8_heures",
      "24.Prodrazviorstka",
      "25.Creation_komintern",
      "26.Creation_politburo",
      "27.Creation_jenotdel",
      "28.Lutte_analphabetisme_likbez",
      "29.Traite_tartu_estonie",
      "30.Plan_goelro",
      "31.Militarisation_travail",
      "32.21_conditions_komintern",
      "33.Congres_peuples_orient",
      "34.Legalisation_avortement",
      "35.Debat_syndicats",
      "36.Adoption_NEP",
      "37.Interdiction_fractions",
      "38.Front_unique_komintern",
      "39.Accord_ARA_famine",
      "40.Congres_extreme_orient",
      "41.Conference_genes",
      "42.Traite_rapallo",
      "43.Creation_URSS"
    ),
    bloc = c(
      "pouvoir_revolutionnaire","economie","diplomatie","diplomatie","economie",
      "armee_securite","diplomatie","diplomatie","diplomatie","diplomatie","diplomatie",
      "diplomatie","culture","economie","pouvoir_revolutionnaire","armee_securite",
      "culture","armee_securite","armee_securite","economie","economie","economie",
      "economie","pouvoir_revolutionnaire","pouvoir_revolutionnaire","pouvoir_revolutionnaire",
      "culture","economie","economie","diplomatie","pouvoir_revolutionnaire","culture",
      "culture","diplomatie","economie","armee_securite","diplomatie","culture",
      "culture","pouvoir_revolutionnaire","economie","pouvoir_revolutionnaire","diplomatie",
      "diplomatie","culture","diplomatie","diplomatie","pouvoir_revolutionnaire"
    ),
    date_min = c(191711,191711,191711,191711,191711,191711,191801,191801,191801,191801,191801,191801,
                 191711,191711,191801,191801,191802,191802,191711,191711,191711,191711,191711,191711,
                 191807,191711,191711,191711,191711,191711,191711,191711,191711,191711,191711,191711,
                 191711,191711,191711,191711,191711,191711,191711,191711,191711,191711,191711,191711),
    date_max = c(191711,192212,192212,192212,192212,192212,192212,192212,192212,192212,192212,192212,
                 192212,192212,191802,192212,192212,191811,192212,192212,192212,192212,192212,192212,
                 192212,192212,192212,192212,192212,192212,192212,192212,192212,192212,192212,192212,
                 192212,192212,192212,192212,192212,192212,192212,192212,192212,192212,192212,192212),
    prereq = c("NA","1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution",
               "1.Faire_la_revolution","1.Faire_la_revolution","4.Droit_autodetermination_peuples",
               "4.Droit_autodetermination_peuples","4.Droit_autodetermination_peuples",
               "4.Droit_autodetermination_peuples","4.Droit_autodetermination_peuples",
               "4.Droit_autodetermination_peuples","1.Faire_la_revolution","5.Decret_controle_ouvrier",
               "1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution",
               "1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution","5.Decret_controle_ouvrier",
               "3.Decret_sur_la_terre","1.Faire_la_revolution","1.Faire_la_revolution",NA,
               "1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution",
               "1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution",
               "1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution",
               "1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution",
               "1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution","1.Faire_la_revolution",
               "1.Faire_la_revolution","1.Faire_la_revolution"),
    stringsAsFactors = FALSE
  )
}

POLITIQUES <- creer_table_politiques()
idx_politique <- setNames(seq_len(nrow(POLITIQUES)), POLITIQUES$ref)

politique_disponible <- function(ref, date_aaaamm, politiques_actives) {
  p <- POLITIQUES[idx_politique[[ref]], ]
  if (is.na(p$ref)) return(FALSE)
  if (date_aaaamm < p$date_min || date_aaaamm > p$date_max) return(FALSE)
  if (is.na(p$prereq) || p$prereq == "NA" || p$prereq == "") return(TRUE)
  p$prereq %in% names(politiques_actives)[politiques_actives]
}

###############################################################################
# 7. ETAT DU JEU
###############################################################################

nouvel_etat <- function() {
  list(
    tour = 0L,
    date = PARAM$date_debut,

    # Propriétaire de chaque ville.
    # Valeurs typiques : BOLCHEVIKS, KERENSKI, ALLEMANDS, BLANCS_..., NEUTRE.
    owner = setNames(rep("NEUTRE", N_VILLES), VILLES),

    # Stock de production restant : 10 au départ, -1 à chaque unité produite.
    production_stock = setNames(rep(PARAM$production_stock_initial_par_ville, N_VILLES), VILLES),

    # Unités présentes par camp et ville. On utilise une matrice numérique rapide.
    # Les camps seront ajoutés dynamiquement si besoin.
    unites = matrix(0L, nrow=0, ncol=N_VILLES, dimnames=list(NULL, VILLES)),

    # Politiques activées.
    politiques_actives = setNames(rep(FALSE, nrow(POLITIQUES)), POLITIQUES$ref),

    # Champs de ressources créés par certaines décisions.
    # Exemple : une indépendance crée un besoin de garde-frontière maximum 1.
    allocations = data.frame(champ=character(0), max=integer(0), valeur=integer(0),
                             decision_source=character(0), stringsAsFactors=FALSE),

    # Compteur de famine par ville : nombre de mois consécutifs dans une composante déficitaire.
    famine_mois_consecutifs = setNames(rep(0L, N_VILLES), VILLES),
    famine_active = setNames(rep(FALSE, N_VILLES), VILLES),

    # Modificateurs d'adhésion et économie par ville, produits par les politiques.
    mod_adhesion_ville = setNames(rep(0L, N_VILLES), VILLES),
    mod_economie_ville = setNames(rep(0L, N_VILLES), VILLES),

    # Modificateurs de comportement des camps, exemple : +apparition makhnoviste.
    # Pour rester simple et rapide, on stocke des lignes d'événements additionnels.
    evenements_camps_additionnels = data.frame(
      DATE_NBR=integer(0), CAMP_TXT=character(0), STATUT_TXT=character(0),
      VILLES_ACQUISES_TXT=character(0), UNITE_A_CONSTRUIRE_NBR=integer(0),
      VILLE_CREATION_REF=character(0), stringsAsFactors=FALSE
    ),

    # Journal compact pour analyse future.
    journal = data.frame(tour=integer(0), date=integer(0), type=character(0), message=character(0),
                         stringsAsFactors=FALSE)
  )
}

log_event <- function(state, type, message) {
  state$journal <- rbind(state$journal, data.frame(
    tour=state$tour, date=state$date, type=type, message=message, stringsAsFactors=FALSE
  ))
  state
}

ajouter_camp_si_absent <- function(state, camp) {
  if (!(camp %in% rownames(state$unites))) {
    nouvelle <- matrix(0L, nrow=1, ncol=N_VILLES, dimnames=list(camp, VILLES))
    state$unites <- rbind(state$unites, nouvelle)
  }
  state
}

ajouter_unites <- function(state, camp, ville, n) {
  if (is.na(ville) || is.null(ville) || ville == "" || !(ville %in% VILLES)) return(state)
  if (is.na(n) || n <= 0L) return(state)
  state <- ajouter_camp_si_absent(state, camp)
  state$unites[camp, ville] <- state$unites[camp, ville] + as.integer(n)
  state
}

changer_owner <- function(state, ville, camp) {
  if (!is.na(ville) && ville %in% VILLES && !is.na(camp) && camp != "") {
    state$owner[ville] <- camp
  }
  state
}

###############################################################################
# 8. APPLICATION DES EVENEMENTS DE COMPORTEMENT DES CAMPS
###############################################################################

appliquer_evenements_camps_du_mois <- function(state, comportement_base) {
  ev <- rbind(comportement_base, state$evenements_camps_additionnels)
  ev <- ev[ev$DATE_NBR == state$date, , drop=FALSE]
  if (nrow(ev) == 0L) return(state)

  for (i in seq_len(nrow(ev))) {
    camp <- ev$CAMP_TXT[i]
    ville_creation <- ev$VILLE_CREATION_REF[i]
    ville_acquise <- ev$VILLES_ACQUISES_TXT[i]
    n_unites <- ev$UNITE_A_CONSTRUIRE_NBR[i]

    state <- ajouter_unites(state, camp, ville_creation, n_unites)

    if (!is.na(ville_acquise) && ville_acquise != "") {
      state <- changer_owner(state, ville_acquise, camp)
    }
  }
  state <- log_event(state, "evenements_camps", paste0(nrow(ev), " ligne(s) appliquée(s)."))
  state
}

###############################################################################
# 9. EFFETS DES DECISIONS POLITIQUES
###############################################################################

ajouter_allocation <- function(state, champ, max, decision_source) {
  if (!(champ %in% state$allocations$champ)) {
    state$allocations <- rbind(state$allocations, data.frame(
      champ=champ, max=as.integer(max), valeur=0L,
      decision_source=decision_source, stringsAsFactors=FALSE
    ))
  }
  state
}

modifier_adhesion <- function(state, villes, delta) {
  villes <- intersect(villes, VILLES)
  state$mod_adhesion_ville[villes] <- state$mod_adhesion_ville[villes] + as.integer(delta)
  state
}

modifier_economie <- function(state, villes, delta) {
  villes <- intersect(villes, VILLES)
  state$mod_economie_ville[villes] <- state$mod_economie_ville[villes] + as.integer(delta)
  state
}

villes_par_type <- function(type_prod=NULL, nationalite=NULL) {
  ok <- rep(TRUE, nrow(caracteristiques_villes))
  if (!is.null(type_prod)) ok <- ok & caracteristiques_villes$type_prod == type_prod
  if (!is.null(nationalite)) ok <- ok & caracteristiques_villes$nationalite == nationalite
  caracteristiques_villes$Ville_NOM[ok]
}

apply_decision_effect <- function(state, ref, accepter=TRUE) {
  # Cette fonction est volontairement longue et explicite.
  # Chaque bloc peut être modifié indépendamment.

  if (!accepter) {
    # Effets de refus importants connus.
    if (ref == "6.Creation_tcheka") {
      # Refuser la Tcheka : Lénine est tué en août 1918 et les blancs deviennent très offensifs.
      # Ici on code un premier effet mécanique simple : des unités blanches bonus apparaissent.
      state$evenements_camps_additionnels <- rbind(
        state$evenements_camps_additionnels,
        data.frame(DATE_NBR=191808, CAMP_TXT="TOUS_BLANCS_BONUS", STATUT_TXT="ACTIF",
                   VILLES_ACQUISES_TXT=NA_character_, UNITE_A_CONSTRUIRE_NBR=10L,
                   VILLE_CREATION_REF="Omsk", stringsAsFactors=FALSE),
        data.frame(DATE_NBR=191808, CAMP_TXT="TOUS_BLANCS_BONUS", STATUT_TXT="ACTIF",
                   VILLES_ACQUISES_TXT=NA_character_, UNITE_A_CONSTRUIRE_NBR=10L,
                   VILLE_CREATION_REF="Rostov", stringsAsFactors=FALSE)
      )
      state <- log_event(state, "decision_refusee", "Refus Tcheka : bonus blanc août 1918 ajouté.")
    }
    if (ref == "20.Execution_tsar") {
      state$evenements_camps_additionnels <- rbind(
        state$evenements_camps_additionnels,
        data.frame(DATE_NBR=191808, CAMP_TXT="BLANCS_TSAR_EVASION", STATUT_TXT="ACTIF",
                   VILLES_ACQUISES_TXT=NA_character_, UNITE_A_CONSTRUIRE_NBR=12L,
                   VILLE_CREATION_REF="Yekaterin...", stringsAsFactors=FALSE)
      )
      state <- log_event(state, "decision_refusee", "Refus exécution du tsar : renfort blanc ajouté.")
    }
    return(state)
  }

  # A partir d'ici : effets d'acceptation.
  state$politiques_actives[ref] <- TRUE

  if (ref == "1.Faire_la_revolution") {
    # Démarrage normal : Petrograd est bolchevique dès le tour 0.
    state <- changer_owner(state, "Petrograd", "BOLCHEVIKS")
    state <- ajouter_unites(state, "BOLCHEVIKS", "Petrograd", 3L)
    state <- log_event(state, "decision", "Révolution lancée : Petrograd bolchevique.")
  }

  if (ref == "3.Decret_sur_la_terre") {
    # Redistribution de la terre : les campagnes et la Sibérie adhèrent davantage.
    # Effet actuel modifiable : +15 adhésion dans les villes agricoles grandrusses.
    villes <- villes_par_type(type_prod="agricole", nationalite="grandrusse")
    state <- modifier_adhesion(state, villes, +15L)
    state <- log_event(state, "decision", "Décret sur la terre : +15 adhésion villes agricoles grandrusses.")
  }

  if (ref == "2.Decret_sur_la_paix") {
    # Appel à la paix : améliore adhésion dans l'Europe occidentale du graphe.
    villes <- c("Varsovie","Br.Litovsk","Minsk","Riga","Tallin","Helsinski","Petrograd")
    state <- modifier_adhesion(state, villes, +10L)
    # Mais peut démobiliser légèrement l'économie militaire.
    state <- modifier_economie(state, villes, -5L)
    state <- log_event(state, "decision", "Décret sur la paix : +10 adhésion Europe, -5 économie locale.")
  }

  if (ref == "4.Droit_autodetermination_peuples") {
    # Les nationalités demandent l'indépendance.
    villes <- villes_par_type(nationalite="nationalite")
    state <- modifier_adhesion(state, villes, +10L)
    state <- modifier_economie(state, villes, -5L)
    state <- log_event(state, "decision", "Autodétermination : +10 adhésion nationalités, -5 économie nationalités.")
  }

  if (ref == "5.Decret_controle_ouvrier") {
    # Prise de contrôle de l'économie : boost économie des villes bolcheviques.
    villes_bol <- names(state$owner)[state$owner == "BOLCHEVIKS"]
    state <- modifier_economie(state, villes_bol, +20L)
    state <- log_event(state, "decision", "Contrôle ouvrier : +20 économie dans les villes déjà bolcheviques.")
  }

  if (ref == "6.Creation_tcheka") {
    # Police politique : sécurité augmente la production possible mais réduit adhésion nationale.
    state <- modifier_adhesion(state, VILLES, -5L)
    state <- modifier_economie(state, VILLES, +5L)
    state <- log_event(state, "decision", "Tcheka : -5 adhésion générale, +5 économie générale.")
  }

  if (ref == "7.Independance_finlande") {
    # Indépendance Finlande : crée une frontière à garder.
    state <- ajouter_allocation(state, "garde_frontiere_finlande", 1L, ref)
    state <- changer_owner(state, "Helsinski", "FINLANDE_INDEPENDANTE")
    state <- log_event(state, "decision", "Indépendance Finlande : champ garde_frontiere_finlande max 1 créé.")
  }

  if (ref == "7.independance_ukraine") {
    state <- ajouter_allocation(state, "garde_frontiere_ukraine", 2L, ref)
    for (v in c("Kiev","Kharkov","Sebastopol")) state <- changer_owner(state, v, "UKRAINE_INDEPENDANTE")
    state <- log_event(state, "decision", "Indépendance Ukraine : champ garde_frontiere_ukraine max 2 créé.")
  }

  if (ref == "7.Independance_turkmenistan") {
    state <- ajouter_allocation(state, "garde_frontiere_turkmenistan", 1L, ref)
    state <- changer_owner(state, "Tashkent", "TURKMENISTAN_INDEPENDANT")
    state <- log_event(state, "decision", "Indépendance Turkmenistan : champ garde_frontiere_turkmenistan max 1 créé.")
  }

  if (ref == "7.Independance_bielorusse") {
    state <- ajouter_allocation(state, "garde_frontiere_bielorussie", 1L, ref)
    state <- changer_owner(state, "Minsk", "BIELORUSSIE_INDEPENDANTE")
    state <- log_event(state, "decision", "Indépendance Bielorussie : champ garde_frontiere_bielorussie max 1 créé.")
  }

  if (ref == "7.independance_caucase") {
    state <- ajouter_allocation(state, "garde_frontiere_caucase", 2L, ref)
    for (v in c("Bakou","Erevan","Tbilissi")) state <- changer_owner(state, v, "CAUCASE_INDEPENDANT")
    state <- log_event(state, "decision", "Indépendance Caucase : champ garde_frontiere_caucase max 2 créé.")
  }

  if (ref == "7.independance_baltes") {
    state <- ajouter_allocation(state, "garde_frontiere_baltes", 2L, ref)
    for (v in c("Riga","Tallin")) state <- changer_owner(state, v, "BALTES_INDEPENDANTS")
    state <- log_event(state, "decision", "Indépendance Baltes : champ garde_frontiere_baltes max 2 créé.")
  }

  # Les décisions suivantes ont pour l'instant des effets numériques de départ.
  # Elles doivent être équilibrées progressivement.
  if (ref == "9.Nationalisation_banques_dettes") {
    state <- modifier_economie(state, VILLES, +10L)
    state <- modifier_adhesion(state, VILLES, -5L)
  }
  if (ref == "11.Creation_armee_rouge") {
    state <- ajouter_unites(state, "BOLCHEVIKS", "Moscou", 5L)
    state <- ajouter_unites(state, "BOLCHEVIKS", "Petrograd", 5L)
  }
  if (ref == "16.Dictature_alimentaire") {
    state <- modifier_economie(state, villes_par_type(type_prod="agricole"), +10L)
    state <- modifier_adhesion(state, villes_par_type(type_prod="agricole"), -10L)
  }
  if (ref == "17.Nationalisation_grande_industrie") {
    state <- modifier_economie(state, villes_par_type(type_prod="industriel"), +15L)
    state <- modifier_adhesion(state, villes_par_type(type_prod="industriel"), -5L)
  }
  if (ref == "18.Comites_paysans_pauvres") {
    state <- modifier_adhesion(state, villes_par_type(type_prod="agricole"), +10L)
    state <- modifier_economie(state, villes_par_type(type_prod="agricole"), +5L)
  }
  if (ref == "20.Execution_tsar") {
    state <- modifier_adhesion(state, villes_par_type(nationalite="grandrusse"), -5L)
  }
  if (ref == "21.Terreur_rouge") {
    state <- modifier_adhesion(state, VILLES, -15L)
    state <- modifier_economie(state, VILLES, +10L)
  }
  if (ref == "23.Journee_8_heures") {
    state <- modifier_adhesion(state, villes_par_type(type_prod="industriel"), +10L)
    state <- modifier_economie(state, villes_par_type(type_prod="industriel"), -5L)
  }
  if (ref == "24.Prodrazviorstka") {
    state <- modifier_economie(state, villes_par_type(type_prod="agricole"), +15L)
    state <- modifier_adhesion(state, villes_par_type(type_prod="agricole"), -15L)
  }
  if (ref == "30.Plan_goelro") {
    state <- modifier_economie(state, VILLES, +10L)
  }
  if (ref == "31.Militarisation_travail") {
    state <- modifier_economie(state, villes_par_type(type_prod="industriel"), +10L)
    state <- modifier_adhesion(state, villes_par_type(type_prod="industriel"), -10L)
  }
  if (ref == "36.Adoption_NEP") {
    state <- modifier_economie(state, VILLES, +20L)
    state <- modifier_adhesion(state, villes_par_type(type_prod="agricole"), +10L)
  }
  if (ref == "39.Accord_ARA_famine") {
    # Aide alimentaire : réduit immédiatement les compteurs de famine.
    state$famine_mois_consecutifs[] <- pmax(0L, state$famine_mois_consecutifs - 2L)
    state <- modifier_adhesion(state, VILLES, +5L)
  }

  state <- log_event(state, "decision", paste("Politique activée :", ref))
  state
}

###############################################################################
# 10. PROFILS D'INDEPENDANCE
###############################################################################

politiques_independance_selon_profil <- function(profil) {
  if (profil == "autonomie_totale") {
    return(c("7.Independance_finlande", "7.independance_ukraine", "7.Independance_turkmenistan",
             "7.Independance_bielorusse", "7.independance_caucase", "7.independance_baltes"))
  }
  if (profil == "juste_le_nord") {
    return(c("7.Independance_finlande", "7.independance_baltes"))
    # Si tu ajoutes Pologne comme décision explicite plus tard, mets-la ici.
  }
  if (profil == "aucune_independance") {
    return(character(0))
  }
  stop("Profil d'indépendance inconnu : ", profil)
}

###############################################################################
# 11. CALCUL ADHESION / ECONOMIE / PRODUCTION
###############################################################################

score_villes_du_mois <- function(state) {
  adhesion <- PARAM$score_base_adhesion + state$mod_adhesion_ville
  economie <- PARAM$score_base_economie + state$mod_economie_ville

  # Pénalité famine active.
  adhesion[state$famine_active] <- adhesion[state$famine_active] + PARAM$famine_penalite_adhesion
  economie[state$famine_active] <- economie[state$famine_active] + PARAM$famine_penalite_economie

  data.frame(
    ville = VILLES,
    adhesion = as.integer(adhesion),
    economie = as.integer(economie),
    peut_produire = adhesion >= PARAM$seuil_adhesion_pour_produire &
                    economie >= PARAM$seuil_economie_pour_produire &
                    state$production_stock > 0L &
                    state$owner == "BOLCHEVIKS",
    stock = as.integer(state$production_stock),
    owner = as.character(state$owner),
    stringsAsFactors = FALSE
  )
}

produire_unites_bolcheviques <- function(state, plan_production="auto_toutes_villes_possibles") {
  scores <- score_villes_du_mois(state)

  if (plan_production == "aucune") return(state)

  if (plan_production == "auto_toutes_villes_possibles") {
    villes_prod <- scores$ville[scores$peut_produire]
    for (v in villes_prod) {
      state <- ajouter_unites(state, "BOLCHEVIKS", v, 1L)
      state$production_stock[v] <- state$production_stock[v] - 1L
    }
    if (length(villes_prod) > 0L) {
      state <- log_event(state, "production", paste("Production bolchevique :", paste(villes_prod, collapse=", ")))
    }
  }
  state
}

###############################################################################
# 12. FAMINE - composantes connectées bolcheviques
###############################################################################

composantes_bolcheviques <- function(owner) {
  villes_bol <- names(owner)[owner == "BOLCHEVIKS"]
  if (length(villes_bol) == 0L) return(list())

  restant <- villes_bol
  comps <- list()

  while (length(restant) > 0L) {
    depart <- restant[1]
    visite <- character(0)
    pile <- depart

    while (length(pile) > 0L) {
      v <- pile[length(pile)]
      pile <- pile[-length(pile)]
      if (v %in% visite) next
      visite <- c(visite, v)
      voisins <- names(which(ADJ[v, ]))
      voisins_bol <- intersect(voisins, villes_bol)
      pile <- unique(c(pile, setdiff(voisins_bol, visite)))
    }

    comps[[length(comps)+1L]] <- visite
    restant <- setdiff(restant, visite)
  }
  comps
}

mettre_a_jour_famine <- function(state) {
  comps <- composantes_bolcheviques(state$owner)

  # Par défaut, les villes non bolcheviques ne comptent pas dans la famine bolchevique.
  state$famine_active[] <- FALSE
  villes_deficitaires_ce_mois <- character(0)

  for (comp in comps) {
    nourriture_total <- sum(caracteristiques_villes$nourriture[match(comp, caracteristiques_villes$Ville_NOM)])
    if (nourriture_total <= PARAM$famine_seuil_nourriture) {
      villes_deficitaires_ce_mois <- c(villes_deficitaires_ce_mois, comp)
    }
  }

  # Mise à jour des compteurs.
  for (v in VILLES) {
    if (v %in% villes_deficitaires_ce_mois) {
      state$famine_mois_consecutifs[v] <- state$famine_mois_consecutifs[v] + 1L
    } else {
      state$famine_mois_consecutifs[v] <- 0L
    }
  }

  state$famine_active <- state$famine_mois_consecutifs > PARAM$famine_declenchement_apres_mois

  if (any(state$famine_active)) {
    state <- log_event(state, "famine", paste("Famine active :", paste(names(which(state$famine_active)), collapse=", ")))
  }
  state
}

###############################################################################
# 13. STRATEGIE DE CONQUETE BOLCHEVIQUE : cercle progressiste
###############################################################################

ville_voisine_la_plus_proche <- function(state) {
  villes_bol <- names(state$owner)[state$owner == "BOLCHEVIKS"]
  if (length(villes_bol) == 0L) return(NA_character_)

  candidats <- character(0)
  for (v in villes_bol) {
    voisins <- names(which(ADJ[v, ]))
    candidats <- c(candidats, voisins[state$owner[voisins] != "BOLCHEVIKS"])
  }
  candidats <- unique(candidats)
  if (length(candidats) == 0L) return(NA_character_)

  # Distance minimale à n'importe quelle ville bolchevique.
  dmin <- rep(Inf, length(candidats))
  names(dmin) <- candidats
  for (candidat in candidats) {
    cx <- stations$x[idx_ville[candidat]]
    cy <- stations$y[idx_ville[candidat]]
    for (v in villes_bol) {
      dx <- cx - stations$x[idx_ville[v]]
      dy <- cy - stations$y[idx_ville[v]]
      dmin[candidat] <- min(dmin[candidat], sqrt(dx*dx + dy*dy))
    }
  }
  names(which.min(dmin))[1]
}

appliquer_strategie_conquete <- function(state, strategie="cercle_progressiste") {
  if (strategie != "cercle_progressiste") stop("Strategie inconnue : ", strategie)

  # Règle imposée : Petrograd tour 0, Moscou tour 1.
  if (state$tour == PARAM$expansion_tour_petrograd) {
    state <- changer_owner(state, "Petrograd", "BOLCHEVIKS")
    return(log_event(state, "conquete", "Tour 0 : Petrograd bolchevique."))
  }
  if (state$tour == PARAM$expansion_tour_moscou) {
    state <- changer_owner(state, "Moscou", "BOLCHEVIKS")
    return(log_event(state, "conquete", "Tour 1 : Moscou bolchevique."))
  }

  # Puis tous les 2 mois : une ville voisine.
  if (state$tour > PARAM$expansion_tour_moscou &&
      state$tour %% PARAM$expansion_chaque_n_mois == 0L) {
    cible <- ville_voisine_la_plus_proche(state)
    if (!is.na(cible)) {
      state <- changer_owner(state, cible, "BOLCHEVIKS")
      state <- log_event(state, "conquete", paste("Cercle progressiste conquiert", cible))
    }
  }
  state
}

###############################################################################
# 14. CHOIX DES DECISIONS AU FIL DES TOURS
###############################################################################

choisir_decision_du_tour <- function(state, ordre_politique, profil_independance) {
  # ordre_politique = vecteur de références dans l'ordre voulu.
  # Le moteur prend la première décision de cette liste qui est disponible et pas encore active.
  # Les profils d'indépendance filtrent les décisions d'indépendance.

  indep_autorisees <- politiques_independance_selon_profil(profil_independance)
  decisions_indep <- POLITIQUES$ref[grepl("independance|Independance", POLITIQUES$ref)]

  for (ref in ordre_politique) {
    if (!(ref %in% POLITIQUES$ref)) next
    if (state$politiques_actives[ref]) next
    if (ref %in% decisions_indep && !(ref %in% indep_autorisees)) next
    if (politique_disponible(ref, state$date, state$politiques_actives)) return(ref)
  }
  NA_character_
}

###############################################################################
# 15. SIMULATION COMPLETE D'UN SCENARIO
###############################################################################

simuler_scenario <- function(ordre_politique,
                             profil_independance="aucune_independance",
                             strategie="cercle_progressiste",
                             plan_production="auto_toutes_villes_possibles",
                             comportement_base=NULL) {
  if (is.null(comportement_base)) comportement_base <- importer_comportement_camps()

  state <- nouvel_etat()

  # On force la révolution au départ si elle est dans le scénario ou si on veut une partie normale.
  if (!state$politiques_actives["1.Faire_la_revolution"]) {
    state <- apply_decision_effect(state, "1.Faire_la_revolution", accepter=TRUE)
  }

  resume <- data.frame(
    tour=integer(0), date=integer(0), villes_bolcheviques=integer(0),
    unites_bolcheviques=integer(0), famine_villes=integer(0),
    politiques_actives=integer(0), production_restante=integer(0),
    stringsAsFactors=FALSE
  )

  for (t in seq_len(N_TOURS)-1L) {
    state$tour <- t
    state$date <- DATES_JEU[t+1L]

    # 1) Evénements des camps ennemis prévus ce mois.
    state <- appliquer_evenements_camps_du_mois(state, comportement_base)

    # 2) Conquête bolchevique stratégique.
    state <- appliquer_strategie_conquete(state, strategie=strategie)

    # 3) Une décision politique maximum par mois, selon l'ordre du scénario.
    decision <- choisir_decision_du_tour(state, ordre_politique, profil_independance)
    if (!is.na(decision)) {
      state <- apply_decision_effect(state, decision, accepter=TRUE)
    }

    # 4) Famine après changements territoriaux et politiques.
    state <- mettre_a_jour_famine(state)

    # 5) Production du mois.
    state <- produire_unites_bolcheviques(state, plan_production=plan_production)

    # 6) Résumé numérique compact.
    unites_bol <- if ("BOLCHEVIKS" %in% rownames(state$unites)) sum(state$unites["BOLCHEVIKS", ]) else 0L
    resume <- rbind(resume, data.frame(
      tour=t, date=state$date,
      villes_bolcheviques=sum(state$owner == "BOLCHEVIKS"),
      unites_bolcheviques=as.integer(unites_bol),
      famine_villes=sum(state$famine_active),
      politiques_actives=sum(state$politiques_actives),
      production_restante=sum(state$production_stock),
      stringsAsFactors=FALSE
    ))
  }

  list(state_final=state, resume=resume, journal=state$journal)
}

###############################################################################
# 16. GENERATION DE SCENARIOS POLITIQUES
###############################################################################

# Remarque mathématique cruciale :
# Tester "tous les ordres possibles" de 43 décisions veut dire une quantité énorme.
# Même si on ne garde qu'une fois chaque décision, le nombre complet d'ordres partiels est :
# somme_{k=0..43} P(43,k), soit beaucoup trop grand.
# Cette fonction génère donc des scénarios par branches, mais s'arrête à un plafond.
# Pour une vraie exhaustivité, il faudra ajouter des équivalences, des profils, ou une recherche
# intelligente qui élimine les ordres qui mènent au même état.

generer_ordres_politiques_bornes <- function(refs_possibles,
                                             max_scenarios=PARAM$max_scenarios_a_generer,
                                             max_politiques=PARAM$max_politiques_par_scenario) {
  scenarios <- list(character(0))

  ajouter_extensions <- function(prefix, restants) {
    if (length(scenarios) >= max_scenarios) return(invisible(NULL))
    if (length(prefix) >= max_politiques) return(invisible(NULL))
    if (length(restants) == 0L) return(invisible(NULL))

    for (ref in restants) {
      if (length(scenarios) >= max_scenarios) break
      nouveau <- c(prefix, ref)
      scenarios[[length(scenarios)+1L]] <<- nouveau
      ajouter_extensions(nouveau, setdiff(restants, ref))
    }
    invisible(NULL)
  }

  ajouter_extensions(character(0), refs_possibles)
  scenarios
}

###############################################################################
# 17. LANCER PLUSIEURS SIMULATIONS ET COMPARER
###############################################################################

simuler_plusieurs_scenarios <- function(liste_ordres,
                                        profil_independance="aucune_independance",
                                        strategie="cercle_progressiste",
                                        plan_production="auto_toutes_villes_possibles",
                                        comportement_base=NULL) {
  if (is.null(comportement_base)) comportement_base <- importer_comportement_camps()

  resultats <- vector("list", length(liste_ordres))
  comparaison <- data.frame(
    scenario_id=integer(0), nb_decisions=integer(0),
    villes_bolcheviques_final=integer(0), unites_bolcheviques_final=integer(0),
    famine_villes_final=integer(0), production_restante_final=integer(0),
    ordre=character(0), stringsAsFactors=FALSE
  )

  for (i in seq_along(liste_ordres)) {
    res <- simuler_scenario(
      ordre_politique=liste_ordres[[i]],
      profil_independance=profil_independance,
      strategie=strategie,
      plan_production=plan_production,
      comportement_base=comportement_base
    )
    resultats[[i]] <- res
    last <- res$resume[nrow(res$resume), ]
    comparaison <- rbind(comparaison, data.frame(
      scenario_id=i,
      nb_decisions=length(liste_ordres[[i]]),
      villes_bolcheviques_final=last$villes_bolcheviques,
      unites_bolcheviques_final=last$unites_bolcheviques,
      famine_villes_final=last$famine_villes,
      production_restante_final=last$production_restante,
      ordre=paste(liste_ordres[[i]], collapse=" > "),
      stringsAsFactors=FALSE
    ))
  }

  list(resultats=resultats, comparaison=comparaison)
}

###############################################################################
# 18. EXEMPLES D'UTILISATION
###############################################################################

# Exemple 1 : un scénario politique simple.
# Décommente pour tester dans R.
# comportement <- importer_comportement_camps()
# ordre_test <- c(
#   "3.Decret_sur_la_terre",
#   "2.Decret_sur_la_paix",
#   "4.Droit_autodetermination_peuples",
#   "5.Decret_controle_ouvrier",
#   "11.Creation_armee_rouge",
#   "16.Dictature_alimentaire",
#   "17.Nationalisation_grande_industrie",
#   "36.Adoption_NEP"
# )
# res <- simuler_scenario(
#   ordre_politique=ordre_test,
#   profil_independance="juste_le_nord",
#   strategie="cercle_progressiste",
#   plan_production="auto_toutes_villes_possibles",
#   comportement_base=comportement
# )
# print(tail(res$resume, 10))
# print(tail(res$journal, 20))

# Exemple 2 : générer un petit ensemble borné de scénarios.
# refs_a_tester <- setdiff(POLITIQUES$ref, "1.Faire_la_revolution")
# ordres <- generer_ordres_politiques_bornes(refs_a_tester, max_scenarios=100, max_politiques=4)
# multi <- simuler_plusieurs_scenarios(ordres, profil_independance="aucune_independance")
# multi$comparaison[order(-multi$comparaison$villes_bolcheviques_final,
#                        -multi$comparaison$unites_bolcheviques_final), ][1:10, ]

###############################################################################
# 19. PROCHAINES EXTENSIONS PREVUES
###############################################################################

# A. Combat réel entre unités : actuellement les événements ajoutent des unités et changent
#    parfois le propriétaire, mais il n'y a pas encore résolution militaire détaillée.
# B. Allocation des ressources : les champs existent, mais il faut coder comment le joueur
#    choisit de les remplir et quelles pénalités apparaissent si un champ reste à 0.
# C. Effets politiques complets : beaucoup de décisions ont un effet provisoire ou nul.
#    Chaque décision doit recevoir :
#    - effet adhésion par ville/type,
#    - effet économie par ville/type,
#    - effet comportement des camps,
#    - effet ressources/allocation,
#    - effet de refus, si pertinent.
# D. Equivalence d'états : pour vraiment explorer presque tout, il faudra éviter de recalculer
#    deux ordres politiques différents qui créent exactement le même état stratégique.
# E. Analyse finale : écrire des agrégats, classement de scénarios, trajectoires de famine,
#    trajectoires de conquête, coût politique, etc.
###############################################################################
