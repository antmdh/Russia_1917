bug : quand je reste trop longtemps sur "lancer la partie après avoir accepté la revolution, je retourne au menu(a mon avis la pause ne s'est pas arreté)e

bug rajouter nom du pays russie

bug la carte avant garde ne match pas visuellement avec la version gimp, il y a un petit decalage avec les nouvelles frontieres, je devrais changer le calque newfrontiere de -1 ou -2 en Y  quand il est en mode avant garde. j'ai essayer de changer le pourcentage, reimporter la carte en tuile, je ne comprend pas ce qui se passe

https://excalidraw.com/#room=44dc19f319c08c2c59e6,h1ZXSZQWEENms35iYvHj3g

https://excalidraw.com/#json=3PS6WiyBerwySZkdpfVtI,BzPQI-BFf8N-8BKSKr6iHw

le niveau d'adhesion des blanc et des rouges devrait baisser de maniere simultané et augmenter de manière simultané

bug : les finlandaid n'arrrete pas leur ouvement avec pause. pourquoi ?

verifier les villes

12.07.2026
PLAN
Il y a les fonctionnalité pour améliorer le jeu
Il y a les fonctionnalité pour terminer une premiere version du jeu

- Construction de la base du jeu

Reflexion
- 1 debat par mois : je dois garder quitte à changer la nature des dabts à regrouper certains
- 1 message par mois, qui ne bloque par le jeu mais qui propose d'aller débatre 
- 1 message par mois qui invite à consulter la pravda pour connaitre des informations particulières directement dans le jeu (genre fin de la guerre)

Par ordre

- Finir la présentation de la situation de chaque ville dans le menu situation du pays (des carrés ou l'on voit la situation pour chaque ville) et sur la carte, un truc lisible qui montre évolution des deux niveaux (avec par exemple un graphique qui augmente artificiellement)


Ensuite projet politique

a)Mettre en place une ia qui va cloturer chaque débat si on ne choisis rien. IA valide un debat ou pas mais ne fait pas rien
b) Faire le tunnel des décisions
- clique sur menu débat / Liste débat / Pravda / Situation du pays / Debat / Economie et allocation des ressources / Pravda / menu Stratégique
b) Faire un menu notifications qui affiche tout ce qui est possible pour ce mois
(un peu plus travaillé) le but est d'aller cliquer sur débat 
c) Retravailler menu pravda et menu situation du pays et menu économie

Voir ce que cela donne

d)  je dois reussisr a mettre un indcateur sur chaque ville puisque la creation depend du niveau 50/50 

e) Rendre les boutons volants dans pravda

f) Rajouter situation de chaque ville dans situation du pays

g)  rendre accessible situation du pays en cas de perte

h) Faire un bilan au niveau du congrès (chaque année)


Faire le menu économie mais demande d'abord de calculer l'economie des troupes





- Amélioration annexe
a) Résoudre le probleme qu'un soldat en contact avec plusieurs ennemis peut en tuer plusieurs
b) Resoudre le probleme que lorsquu'on bouge un soldat, on a le zoom qui se déclenche, il faut que lorsqu'on tire la fleche, le zoom ne puisse pas s'activer durant une seconde
c) Avoir une layout gaucher/ droitier
d) Améliorer l'IA des blancs, pourquoi souvent ils ne bougent pas, surtout les blancs qui apparaissent sur les pays bales 
e) Il faut que la barre des notifications ne s'affiche que si il y a des débats à valider




Liste des evenements qui influence
armee_securite


Les consequences de chaque decisions sont
- soit territoriale (nouvelles frontieres apparaissent)
- soit politique : l'attitude des ennemis change
- soit allocations ressourcs  créé des besoins
- Soit militaire : crée des troupes
- soit economique : augmente production
- soit idéologique : augmente adhesion

LES COMMISSARIAT
COM_AFF_ETR
COM_AGR_ALIM
COM_GUERRE
COM_COMMERCE_INDUSTRIE
COM_EDUCATION
COM_BIEN_ETRE
COM_INTERIEUR
COM_JUSTICE
COM_TRAVAIL
COM_NATIONALITE
COM_POSTE_TELEGR
COM_FINANCE



Les nations
"ALLEMANDS_GENERAL" INACTIF puis DEFAITE
"ALLEMANDS_EN_FINLANDE"
"AMERICAINS_DU_NORD" = ACTIF_LIMITE
"BLANCS_BIELORUSSES"= ACTIF_LIMITE
"BLANCS_FINLANDAIS" = ACTIF_LIMITE
"BLANCS_UKRAINIENS" = ACTIF_LIMITE
"BOLCHEVIKS" JOUEUR
"BRITANNIQUES_DU_CAUCASE"= ACTIF_LIMITE
"BRITANNIQUES_DU_NORD"= ACTIF_LIMITE
"FRANCAIS_DU_SUD"= ACTIF_LIMITE
"JAPONAIS" = ACTIF_LIMITE
"KERENSKI" INACTIF
"LEGION_TCHEQUE" = ACTIF_LIMITE
"POLONAIS" = ACTIF_LIMITE
"BLANCS_DENIKINE" = ACTIF
"BLANCS_KOLTCHACK"= ACTIF
"BLANCS_IOUDENITCH" = ACTIF
"BLANCS_BASMATCHI"= Actif limite 
"ANARCHISTES_KRONSTAD" = actif limite Moscou et Petrograd
"BLANCS_MAKHNOVCHTCHINA"= ACTIF limite
"BLANCS_PAYSANS_VERT" =INACTF
"BLANCS_BALTES" = ACTIF_limite "Riga"


TYPEDECAMP
"ALLIANCE" : 
"ALLEMANDS",
"ENTENTE" : "AMERICAINS_DU_NORD","BRITANNIQUES_DU_CAUCASE","BRITANNIQUES_DU_NORD","FRANCAIS_DU_SUD","JAPONAIS","LEGION_TCHEQUE"
"BLANCS_REGIONALISTES" : 
"BLANCS_BIELORUSSES","BLANCS_FINLANDAIS","BLANCS_UKRAINIENS","POLONAIS","BLANCS_BALTES"
"BOLCHEVIKS":
"BOLCHEVIKS"
"EXTREMEGAUCHE": "BLANCS_PAYSANS_VERT","BLANCS_MAKHNOVCHTCHINA","ANARCHISTES_KRONSTAD" 
"BLANCS_NATIONALISTE" : "BLANCS_DENIKINE" , "BLANCS_KOLTCHACK","BLANCS_IOUDENITCH","KERENSKI"

PERSONNAGE HISTORIQUE
LENINE
TROTSKY
BOUKHARINE



TABLE_COMPORTEMENT_IA.Centrenationaliste_X_NBR
TABLE_COMPORTEMENT_IA.Centrenationaliste_Y_NBR
TABLE_COMPORTEMENT_IA.Centrenationaliste_TAILLE_LONGEUR
TABLE_COMPORTEMENT_IA.Centrenationaliste_TAILLE_HAUTEUR

FCT2_troupes_ennemis_proximite1
FCT2_troupes_aliies_proximite_1
campdedepart_Blancs_IA_unique.FCT2_Position_villes_ennemiouneutre.X[0]
campdedepart_Blancs_IA_unique.FCT2_Position_villes_ennemiouneutre.Y[0]
campdedepart_Blancs_IA_unique.FCT2_Position_troupes_ennemis.X[0]
campdedepart_Blancs_IA_unique.FCT2_Position_troupes_ennemis.Y[0]


Pour export
Effacer les données
Exporter android depuis gdevelop
cd ~/Documents/export/RUssia_1917/ANDROID
npm install
cordova platform add android
cordova build android

1.Faire_la_revolution
2.Decret_sur_la_paix
3.Decret_sur_la_terre
4.Droit_autodetermination_peuples
5.Decret_controle_ouvrier
6.Creation_tcheka
7.Independance_finlande
7bis.independance_ukraine
7ter.Independance_turkmenistan
7quater.Independance_bielorusse
7quinter.independance_caucase
7sixter.independance_baltes
8.Mariage_civil_egalite_hf
9.Nationalisation_banques_dettes
10.Dissolution_assemblee_constituante
11.Creation_armee_rouge
12.Calendrier_gregorien
13.Accord_brest_litovsk_1
14.Accord_brest_litovsk_2
14bis.Congres_education
15.Monopole_commerce_exterieur
16.Dictature_alimentaire
17.Nationalisation_grande_industrie
18.Comites_paysans_pauvres
19.Constitution_RSFSR
20.Execution_tsar
21.Terreur_rouge
22.Code_famille
23.Journee_8_heures
24.Prodrazviorstka
25.Creation_komintern
26.Creation_politburo
27.Creation_jenotdel
28.Lutte_analphabetisme_likbez
29.Traite_tartu_estonie
30.Plan_goelro
31.Militarisation_travail
32.21_conditions_komintern
33.Congres_peuples_orient
34.Legalisation_avortement
35.Debat_syndicats
36.Adoption_NEP
37.Interdiction_fractions
38.Front_unique_komintern
39.Accord_ARA_famine
40.Congres_extreme_orient
41.Conference_genes
42.Traite_rapallo
43.Creation_URSS
44.Creation_republique_extreme_orient


"Murmansk"
"Petrograd"
"Helsinski"
"Archangel"
"Moscou"
"Minsk"
"Br.Litovsk"
"Kiev"
"Kazan"
"Samara"
"Tashkent"
"Perm"
"Yekaterin..."
"Omsk"
"Novosibirsk"
"Irkustk"
"Vladivostok"
"Tsaritsyn"
"Rostov"
"Kharkov"
"Sebastopol"
"Tallin"
"Riga"
"Varsovie"
"Bakou"
"Erevan"
"Tbilissi"
"Khabarovsk"
Minsk
Kiev
Kharkov
Rostov
Tsaritsyn
Samara
Kazan
Perm
Yekaterin...
Omsk
Tashkent
Tbilissi
Erevan
Bakou
Sebastopol
Novosibirsk
Irkustk
Khabarovsk
Vladivostok
Varsovie

Liste des situations :

1) Conflits (7) :
- ENTENTE vs EXTREME GAUCHE
- ALLIANCE vs EXTREME GAUCHE
- ALLIANCE vs BLANCS_NATIONALISTE
- ENTENTE vs ALLIANCE
- EXTREME GAUCHE vs BLANCS_REGIONALISTES
- BLANCS_NATIONALISTE vs BLANCS_REGIONALISTES
- BLANCS_NATIONALISTE vs EXTREME GAUCHE

2) Non-conflits (même camp) :
- ENTENTE vs ENTENTE
- ALLIANCE vs ALLIANCE
- EXTREME GAUCHE vs EXTREME GAUCHE
- BLANCS_NATIONALISTE vs BLANCS_NATIONALISTE
- BLANCS_REGIONALISTES vs BLANCS_REGIONALISTES

3) Non-conflits (non listés dans les 7 conflits) :
- ENTENTE vs BLANCS_NATIONALISTE
- ENTENTE vs BLANCS_REGIONALISTES
- ALLIANCE vs BLANCS_REGIONALISTES

BUG-----
Le bouton pause et le bouton paramètre est moche




Des soldats rouge que je dirige pres de moscou fonce directement vers Murmansk 
A un moment, les troupes du nord et du sud cesse de bouger


Les soldats blanc du nord du sud et les allemands n'attaque plus
Soldat qui vont sur le mer
L'impact des montages dans la zone de Bakou est trop important
Le zoom (+) libere des troupes en mouvement
Une troupe pres de iekatrinaburg mais sur l'axe samara omsk va prefere iekatrinaburg au lieu de samara ou omst
Passer un certain momnet, le bouton (créer troupes) ne fonctionne plus
Soldat reste en triange alors qu'il ne bouge plus
Y a encore des troupes vers Murmansk qui partent vers zero zero
Pas de Menu VICTOIRE

Menu lenine trotsky
- Le texte apparait une micro seconde après le phylactère
- Le bouton "accepter refuser" doit apparaitre après le texte
- Le mouvement respiration est ridicule
- Compte rendu discussion le texte dépasse
- On peut pas annuler le texte discussion sauf en cliquant sur accepter refuser ce qui n'est pas ok
- On ne peut pas sortir du menu

Stavaza 05.07.2025
- J'ai rajouté les allemands
- J'ai corrigé un bug qui faisait transformer tout les soldats blancs dans un seul camp
- J'ai adapté l'iA allemande pour qu'elle attaque les 7 villes sous brest litovsk si on signe pas l'accord et si on signe l'accord, elle reste dans les zones qu'elle occupe
- Il y a aussi la desertinn



bug repere
Les soldats ne sont plus créé 
Les. lancs du sud sont très inactifs
montagnes bouge quand on les touches
la mini ville ne change pas de couleur blanc quan elle est prise


Stavaza 07.06.20205
Code chemin de fer semble fonctionner mais donne des resultats bizarres, déja il rejoint une gare au lieu d'aller vers le chemin de fer et semble pas bien suivre, bref encore creuser des cas concret de déplacement mais y a de l'idée





Voici ce que je dois encore faire pour finir l'alpha


Par ordre


IA



- rendre le chemin par la mer, très complexe voir impossible

- Il faudrait aussi que je modifie la stratégie de chacune et mettre plus d'aléatoire. Pour obtenir des résultats différents, des recherches doivent être fait pour voir l'efficacité de chacun. J'ai un projet d'article de blog à ce sujet d'ailleurs. Je voudrais aussi une IA qui attaque en masse dans certains cas.



- Rajouter que l’IA qui décide de donner une cible ne commence à chercher de cible que si elle a des soldats disponibles à combattre pour éviter les calculs inutiles.

- Rajouter une IA tendance nationaliste qui se bat uniquement dans une zone
- Rajouter que les bolcheviks aussi utilise le train

- QUand je créé un nouveau camp
- crée IA décision
- créé IA creation de troupes + regles creation de troupes
- Bloquer prise de ville pour certaines troupes

UX


- La mini map ne change pas de taille quand le zoom grandit OK
- Rajouter les troupes sur la minimap




Visuel



- Refaire le visuel des soldats blancs et rouges. Voir ici

- Refaire visuels de chaque sous camp

- Vérifier si les montages nouveau format sont bien situé géographiquement



Trouver le chemin  
-          Refaire des lignes droites pour suivre les routes au lieu de ligne courbes et faire une animation de rail

- Rajouter quelques gares si je laisse des courbes et refaire tout les précalcul pour trouver le chemin le plus court. 

- Il semble manquer des routes dans le Caucase dans le fichier R qui calcul les chemins les plus courts



Ennemis
- Rajouter IA de chaque sous camp de blanc avec explication de son apparition et qui explique son moteur

- Allemand

1917.11 Allemands occupe etats balte, pologne, ukraine, bielorussie
1918.03 si on signe l'accord de Brest Litovsk, les frontières sont créé mais l'allemagne cesse d'attaquer sinon elle continue à attaquer
1918.11 Les allemands retire leur troupes qui reste



- Armes du Tsar

1917.11 Lancement de la révolution et guerre avec armées tsariste à Moscou et saint Petersbourg

- Blancs du nord

1919.07 Création armée du Nord de Ioudenitch en Estonie

- Blancs du Don

1918.12 Création des blancs du sud (Rostov) général Kornilov

- Blancs du Caucase

- Blancs de Sibérie Koltchak

- Britanniques du Nord

1918.03 Debarquement à Mourmansk
1918.08 Débarquement à Arkhangelsk

- Japonais

- Français du Nord

1918.08 Débarquement à Arkhangelsk

- Americain du Nord

1918.08 Débarquement à Arkhangelsk

- Americain de l'est

1918.04 Débarquement à Vladivostok

- Tchecoslovaque

1918.05 Revolte de Iekatrin à Vladivostok 

- Français du sud

1918.07 Débarquement à Odessa 

- Blanc des pays baltes

1919.11 Estonie Nikolaï Ioudenitch

- Polonais

1918.11 Fondation de la Pologne (Varsovie, Minsk, Brest Litovsk)

- Vert

- Anarchiste ukrainiens

- Nationalistes de Transcaucasie

- Basmatchis

- Nationaliste de Transbaïkalie (Grigory Semenov)

 -  Grigory Semenov

-Bouriates, les Iakoutes et les Touvains

 l'ataman Roman von Ungern-Sternberg

 


Contenu

- Rajouter des affiches soviétiques en cas de conquête de Moscou ou Petrograd 

- Rajouter un début (vous dirigez la révolution)

- Etablir des fins (dont une c'est la fondation de l'URSS si tu as atteint une serie d'étape)


- l'idée est d'encore établir un scénario idéal et puis une serie de déviation si le joueur bolchevik arrive à réaliser tel étape ou pas. A encore réfléchir mais on peut imaginer 

- Combat contre kronstad ou pas

- Alliance mencheviks ou pas

- Action politique paix terre pain ou pas

- Prise de varsovie ou pas

- Perte de petrograd et ou perte de moscou



L'idée c'est de faire un chemin et dès qu'on s'écarte de l'un ou des étapes, on a une fin alternative.

Faire un schema





Réflexion générale sur la stratégie
Quand deux unités sont en contact l'une avec l'autre, on a un aspect aléatoire dans la victoire.
Celui qui conquière les villes les plus vite aura automatiquement plus de force et va gagner.
Mais la réalité, c'est que plus la guerre dure, plus les ressources faiblisse
A l'inverse des troupes blanches qui sont financé par l'extérieur
Comment introduire l'idée d'épuissement des ressources


- archives

Stavaza liste des bugs

SOUSCAMPOFFICIEL
"ALLEMANDS" INACTIF
"BOLCHEVIKS" JOUEUR
"KERENSKI" INACTIF
"BLANCS_FINLANDAIS" = ACTIF_LIMITE
"BLANCS_UKRAINIENS" = ACTIF_LIMITE
"BLANCS_BIELORUSSES"= ACTIF_LIMITE
"JAPONAIS" = ACTIF_LIMITE
"LEGION_TCHEQUE" = ACTIF_LIMITE
"AMERICAINS_DU_NORD" = ACTIF_LIMITE
"BRITANNIQUES_DU_NORD"= ACTIF_LIMITE
"POLONAIS" = ACTIF_LIMITE
"FRANCAIS_DU_SUD"= ACTIF_LIMITE
"BRITANNIQUES_DU_CAUCASE"= ACTIF_LIMITE

"BLANCS_DENIKINE" = ACTIF
"BLANCS_KOLTCHACK"= ACTIF
"BLANCS_IOUDENITCH" = ACTIF
"BLANCS_BASMATCHI"= Actif limite
"ANARCHISTES_KRONSTAD" = actif limite Moscou et Petrograd
"BLANCS_MAKHNOVCHTCHINA"= ACTIF limite
"BLANCS_PAYSANS_VERT" =INACTF
STAVAZA 30.11.2025
il y a encore des actif limite qui vont vers d'autres destinations mais je ne comprend pas pourquoi,
La fct 4 ne fonctionne pas

stavaza 08.06.2025

il semble qu'il y ait un bug pour lres troupes limites quinvont chercher des cibles villes hors de leur zone
J'ai rajoute deux indicateurs (nombre de mort par minutes et pourcebtage de troupes disponibles par minutes pour caler la musique dessus
quand on clique sur un bouton creation soldat certaines fonction ne se font pas, j'avais rajoutn un boutonn de controle mais le resultat provoque des bugs
j'ai supprimé le controle mais le probleme continue na exister
stavaza 24.11.2025
rajouter un systeme qui fait disparaitre les fleches
rajouter un systeme qui reinitialise une ville qui n'a pas été capturé finalement
rajouter tableau de fin 

Stavaza 23.11.2025
bug au niveau de la fonction 2 les basmatchi ne depasse pas la fonctoin 0.3, ne calcul pas le nobre de soldat par exemple
Cela arrive  a partir de 191804 

Stavaza 22.11.2025


j'ai cree les images statique et combat OK
je dois crer les soldat dans le tableau en fonction des dates
je dois changer le code pour rajouter chaque nationalite OK
bug : une fois qu'on a fini le jeu, si on le relance, bug les postions ne tiennent plus

Stavaza 18.11.2025
Ce que je dois encore faire
- corriger bug des images "cretions soldat" qui sont animation rouge mais blanc a l'interieur OK
- comprendre pourquoi kharkov ne peut pas etre pris par les ukrainiens OK
- faire en sorte que les villes ne puissent pas etre capturé par les forces etrangeres mais deviennent inactif OK (redvienne inactif au bout de 10 secondes)
- c'est seulement les blancs et les nationalistes qui peuvent les capturer les villes ok voir au dessus
- permettre aux blancs de construire des soldats (gros morceaux)
- rajouter la musique en identifiant les moments calme des moments forts
- retravailler la vitesse des fonctions 1 2 et 3 : La 1 doit avoir lieu un ertain nombre de fois au deBut de chaque mois, la deux ok, la droit ne doit avoir lieu chaque seconde qu'en fonction d'evenement de la partie sinon plus calme (mais bon faut encore trouver le bon equilibre
- chnager le random en un decompte pour le choix des nations
- enfin rajouter le choix politique (gros morceaux)
- faire une video de promotion

Le mode defaite n'est pas fini


Retour Thomas 22.11.2025
- Les nouveaux soldats doivent poper plus vite
- Parfois je dois utiliser 10 soldats pour tuer un seul ennemi
- Je dois supprimer le bouton choix politique
- Les trains c'est bien
- Il y a trop d'ennemi
- Une bonne idée de moi
- Quand il y a les ennemis, il y a pas trop de ville envhais par les ennemis mais ils sont enormes
- Ce serait bien de faire poper deux soldats à la fois et pas un seul
Le popage est très lent

Nouvelles fonctions -----
Si j'appuye sur l'affiche je devrais avoir des informations

BUG-----
Le bouton pause et le bouton paramètre est moche




Des soldats rouge que je dirige pres de moscou fonce directement vers Murmansk 
A un moment, les troupes du nord et du sud cesse de bouger


Les soldats blanc du nord du sud et les allemands n'attaque plus
Soldat qui vont sur le mer
L'impact des montages dans la zone de Bakou est trop important
Le zoom (+) libere des troupes en mouvement
Une troupe pres de iekatrinaburg mais sur l'axe samara omsk va prefere iekatrinaburg au lieu de samara ou omst
Passer un certain momnet, le bouton (créer troupes) ne fonctionne plus
Soldat reste en triange alors qu'il ne bouge plus
Y a encore des troupes vers Murmansk qui partent vers zero zero
Pas de Menu VICTOIRE

Menu lenine trotsky
- Le texte apparait une micro seconde après le phylactère
- Le bouton "accepter refuser" doit apparaitre après le texte
- Le mouvement respiration est ridicule
- Compte rendu discussion le texte dépasse
- On peut pas annuler le texte discussion sauf en cliquant sur accepter refuser ce qui n'est pas ok
- On ne peut pas sortir du menu

Stavaza 05.07.2025
- J'ai rajouté les allemands
- J'ai corrigé un bug qui faisait transformer tout les soldats blancs dans un seul camp
- J'ai adapté l'iA allemande pour qu'elle attaque les 7 villes sous brest litovsk si on signe pas l'accord et si on signe l'accord, elle reste dans les zones qu'elle occupe
- Il y a aussi la desertinn



bug repere
Les soldats ne sont plus créé 
Les. lancs du sud sont très inactifs
montagnes bouge quand on les touches
la mini ville ne change pas de couleur blanc quan elle est prise


Stavaza 07.06.20205
Code chemin de fer semble fonctionner mais donne des resultats bizarres, déja il rejoint une gare au lieu d'aller vers le chemin de fer et semble pas bien suivre, bref encore creuser des cas concret de déplacement mais y a de l'idée





Voici ce que je dois encore faire pour finir l'alpha


Par ordre


IA



- rendre le chemin par la mer, très complexe voir impossible

- Il faudrait aussi que je modifie la stratégie de chacune et mettre plus d'aléatoire. Pour obtenir des résultats différents, des recherches doivent être fait pour voir l'efficacité de chacun. J'ai un projet d'article de blog à ce sujet d'ailleurs. Je voudrais aussi une IA qui attaque en masse dans certains cas.



- Rajouter que l’IA qui décide de donner une cible ne commence à chercher de cible que si elle a des soldats disponibles à combattre pour éviter les calculs inutiles.

- Rajouter une IA tendance nationaliste qui se bat uniquement dans une zone
- Rajouter que les bolcheviks aussi utilise le train

- QUand je créé un nouveau camp
- crée IA décision
- créé IA creation de troupes + regles creation de troupes
- Bloquer prise de ville pour certaines troupes

UX


- La mini map ne change pas de taille quand le zoom grandit OK
- Rajouter les troupes sur la minimap




Visuel



- Refaire le visuel des soldats blancs et rouges. Voir ici

- Refaire visuels de chaque sous camp

- Vérifier si les montages nouveau format sont bien situé géographiquement



Trouver le chemin  
-          Refaire des lignes droites pour suivre les routes au lieu de ligne courbes et faire une animation de rail

- Rajouter quelques gares si je laisse des courbes et refaire tout les précalcul pour trouver le chemin le plus court. 

- Il semble manquer des routes dans le Caucase dans le fichier R qui calcul les chemins les plus courts



Ennemis
- Rajouter IA de chaque sous camp de blanc avec explication de son apparition et qui explique son moteur

- Allemand

1917.11 Allemands occupe etats balte, pologne, ukraine, bielorussie
1918.03 si on signe l'accord de Brest Litovsk, les frontières sont créé mais l'allemagne cesse d'attaquer sinon elle continue à attaquer
1918.11 Les allemands retire leur troupes qui reste



- Armes du Tsar

1917.11 Lancement de la révolution et guerre avec armées tsariste à Moscou et saint Petersbourg

- Blancs du nord

1919.07 Création armée du Nord de Ioudenitch en Estonie

- Blancs du Don

1918.12 Création des blancs du sud (Rostov) général Kornilov

- Blancs du Caucase

- Blancs de Sibérie Koltchak

- Britanniques du Nord

1918.03 Debarquement à Mourmansk
1918.08 Débarquement à Arkhangelsk

- Japonais

- Français du Nord

1918.08 Débarquement à Arkhangelsk

- Americain du Nord

1918.08 Débarquement à Arkhangelsk

- Americain de l'est

1918.04 Débarquement à Vladivostok

- Tchecoslovaque

1918.05 Revolte de Iekatrin à Vladivostok 

- Français du sud

1918.07 Débarquement à Odessa 

- Blanc des pays baltes

1919.11 Estonie Nikolaï Ioudenitch

- Polonais

1918.11 Fondation de la Pologne (Varsovie, Minsk, Brest Litovsk)

- Vert

- Anarchiste ukrainiens

- Nationalistes de Transcaucasie

- Basmatchis

- Nationaliste de Transbaïkalie (Grigory Semenov)

 -  Grigory Semenov

-Bouriates, les Iakoutes et les Touvains

 l'ataman Roman von Ungern-Sternberg

 


Contenu

- Rajouter des affiches soviétiques en cas de conquête de Moscou ou Petrograd 

- Rajouter un début (vous dirigez la révolution)

- Etablir des fins (dont une c'est la fondation de l'URSS si tu as atteint une serie d'étape)


- l'idée est d'encore établir un scénario idéal et puis une serie de déviation si le joueur bolchevik arrive à réaliser tel étape ou pas. A encore réfléchir mais on peut imaginer 

- Combat contre kronstad ou pas

- Alliance mencheviks ou pas

- Action politique paix terre pain ou pas

- Prise de varsovie ou pas

- Perte de petrograd et ou perte de moscou



L'idée c'est de faire un chemin et dès qu'on s'écarte de l'un ou des étapes, on a une fin alternative.

Faire un schema





Réflexion générale sur la stratégie
Quand deux unités sont en contact l'une avec l'autre, on a un aspect aléatoire dans la victoire.
Celui qui conquière les villes les plus vite aura automatiquement plus de force et va gagner.
Mais la réalité, c'est que plus la guerre dure, plus les ressources faiblisse
A l'inverse des troupes blanches qui sont financé par l'extérieur
Comment introduire l'idée d'épuissement des ressources
