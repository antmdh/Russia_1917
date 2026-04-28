https://excalidraw.com/#room=44dc19f319c08c2c59e6,h1ZXSZQWEENms35iYvHj3g

Les nations
"ALLEMANDS" INACTIF puis DEFAITE
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
8.Mariage_civil_egalite_hf
9.Nationalisation_banques_dettes
10.Dissolution_assemblee_constituante
11.Creation_armee_rouge
12.Calendrier_gregorien
13.Accord_brest_litovsk_1
14.Accord_brest_litovsk_2
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

Stavaza 29.04.2026
J'ai bien avancé sur la validation des décisions mais deux bugs
- IL y a un décalage des réponses (ON indique réponse 7 validé alors que c'est la 6 dans situation du pays)
- L'icone STATUT_APPROUVE_REFUSE ne reste pas active durant tout le jeu mais seulemnt quelques instant, je ne comprend pas pourquoi ? Rectificarion cela à l'air d'aller mais par contre plus les mois passe, plus la mise en page de liste debat bug complètement

stavaza 25.04.26
mettre DBU1 2 3 sur calque de base

STAVAZA 21.04.2026
LE NOM DU DEBAT EST SAUVER DANS LE BOUTON QU'ON CLIQUE POUR ACCEDER AU DEBAT
IL FAUT MAINTENANT METTRE EN PLACE LE MENU DEBAT A VALIDER ET REPRENDRE L'INFORMATION DU BOUTON POUR AFFICHE RLE BON TEXTE

20.04.2026
Essais d'une partie, aucune interaction sauf defense de Moscou et Petrograd
Bug
- Le mois d'octobre dure trop longtemsp et rien ne se passe
- Je dois configurer que si on clique sur une des banners avant que le chronomètre se termine, alors on a accès à la conversation sinon on a la réponse
- Les notifications doivent apparaitre
Visuel
- La carte doit avoir un peu plus de motif

IA
- Au niveua de l'IA, Si je ne bouge pas, les blancs n'attaque pas idem pour laes anglos americains (seul les allemands attaque Moscou)
- Des troupes blanches (généraux blancs) apparaissent et disparaissent à Tbilissi alors qu'il y a aucun ennemi
- Les généraux blancs ne prennent pas de villes (je veux dire la ville ne devient pas blanche alors qu'ils sont dessus) ex Tbilissi en sep 1918
- Les baltes aussi ont le meme probleme pour prendre RIGA octobre 1918
- Il y a plein de morts sur la carte artisitique alors que je vois aucun combat
- La ville de Rostov n'a plus de troupes mais je ne sais pas qui les a crée
- les vertpaysant ne prennent pas de villes 
- Pas de conflit entre nationaliste ukrainens et anarchiste ukrainiens


Fonctionnalité suplémentaire
- Rajouter un message quand une ville est prise ou perdue pour le joueur 
- Page les débats, il y a trop de page vide 
- Le bouton "plus d'information" de "situation du pays" provoque un retour au début et un affichage inccorect
- Boucle de gameplay = Mettre une série de scénario réussite (petite victoire en conservant moscou et petrograd, grande victoire en gardant tout le monde)
- Game desing = personne n'attaque avant mars 1918
- Puis personne n'attaque meme pas les finlandais 
- Game desing il faut qu'on puisse identifier les troupes de chaque pays ainsi que les villes et qui les possède
- Rajouter un fichier LOG de chaque opération fait par l'IA
- Rajotuer un tableau qui indique situation de chaque IA 
- Rajouter un tableau qui indique le nombre de mort par camps et pays
- Game design, UNe partie de 62 minutes, c'est trop long sans sauvegarde mais peut etre tricher avec les minutes qui dure pas le meme temps, en tout cas en developpement, on doit rester à 15 ou 30 secondes 
- Rajouter un bouton (retour menu et sauvegarde)


09.04.2026
reflexion IA
Ce que je veux arriver à faire

Definir un but en fonction du world count

Definir action, chaque actiona un pre requis un effet et un cout

definir un planner qui parcours chaque action
- parcours les prerequis
- choisis le moins cher


Resumer de ce que j'ai appris en GOAP

Le goap c'est l'idée que l'IA génère un plan d'action et puis choisis de le réaliser
On travail avec plusieurs logiques

1. Wordlcount - Je regarde la situation du monde en temps réél (dans mon exemple est ce ue Robinson a de la nourriture sur lui, si il voit de la nourriture, a combien de pourcent sa maison est construire etc)

2. ENsuite je détermine son besoin du moment, cela peut etre de satisfaire sa faim, cela peut etre d'assurer sa sécurité, d'explorter son environnement ou simplement allumer un feu pour etre vu du bateau
Ce but est changé en focntion du worldcount

3. On determine une serie d'action simple que peut realiser l'iA. Cela peut etre manger une noix de coco ou un poisson, aller chercher une noix de coco, aller cherche un poisson. partir explorer au hasard, etc
l'idée c'est qu'une action puisse etre utilisé dans plusieurs plan : par exemple chercher une arbre dans le cade de repondre a sa faim ou bien chercher un arbre pour avoir du bois de construction
l'idée est aussi qu'un plan puisse etre realisé de plusieurs manière
par exemple satifaire sa faim peut etre : trouver un poisson, manger le poisson ou trouver une noix de coco et manger la noix de coco

4. On fait le plan
Soit on code tout les plans possibles et on prend le moins cher ("trouver un poisson, manger le poisson" = 3 ou "trouver une noix de coco et manger la noix de coco" =2), soit on prend toute les actions possible et on les combine pour voir ce que coute chaque plan 
La premiere demarche est determinisite (chaque plan a été pensé par le developpeur), la deuxième est emergente (elle realise des plans que le developpeur n'a pas pensé).

Le problème pour faire cela en gdevelop, c'est compliqué sauf si on passe apr un bloc javascript
En effet, il faut créer un tableau qui prevoit pour chaque action ses conditions, ses effets et ses consequences puis un deuxième tableau qui etablis les plans possible en fonction de letat du monde du but recherché et des conditions et effet de chaque action.
C'est possible mais complexe surtout en pseudocode gdevelop

5. Validation
L'idée est de voir si avec ette ia, on va avoir une ia qui se comporte toujours d ela meem facon ou bien si fasse a des inputs differents, elle sera reactive. Pour tester cela en mode robinson, il faut que les ressources et le bateau apparaissent de manière aleatoire et voir si l'IA survit oun pas en faisant tourner un grand nombre de fois le jeu

6. A quoi bon
dans le acdre de mon jeu, je dois voir en quoi l'IA des russses blancs peut appporter une grande divetrsité avec le goap, si un arbre de cision ou une famille de comprtement n'est pas plus simple



27 Mars 2021
Jai mis le fichier liste debat ok sauf que le niveau 2 reste systématiquement caché
A encore creuser, aussi la navitation avec les fleches

16 Mars 2026


5 MODE+1
MODE STRATEGIQUE (la carte)
MODE DEBAT - LISTE
MODE DEBAT - UNIQUE
MODE SITUATION DU PAYS
MODE MENU ACCEUIL
MODE EXTRA - UX (nous suit partout mais peut varier selon le mode)


18.03.2026
je dois supprimer la valeur mode strategique et remplacer par. ouvelle valeur

15.03.2026
Zoom par pincement ok (5h de travail)

08.03.2026
Bon
Qu’est ce que je dois résoudre en UI

- Dans tout les cas, je dois faire un zoom avec le glisser déposer. 
Je dois tester l’option que cela conduise par défaut sur deux ou trois niveau de zoom

- Je dois enlever l’oeuvre artistique, les affiches et la mini map
A la place je met trois boutons et un système de notification 

=> Menu scénario pour accéder ensuite à chaque scénario
	=> Les scénario peuvent arriver à partir d’un certains moments dans l’histoire, ils ne DOIVENT pas être décidé à ce moment la
	=> Un menu (situation du pays) qui remet l’oeuvre d’art ainsi que quelques chiffres et le point pour les différentes missions 
        => Un menu préférence, musique, sauvegarde




- La mini map avec les troupes se trouve dans le cadre scénario (faire des essais pour voir ce que cela donne)

- Le code artistique



08.03.2026
Bilan de la journée ou j'ai eu 4h

- Je n'arrive pas à tester le format pincer et zoomer mais en principe c'est possible
- La minicarte ne donne rien de bien sur un mobile, il faut que je crée un menu pour la consulter, c'est mieux
- Par contre une grande carte avec 99% de l'écran visible ,cela donne vraiment mieux 
- Je dois travailler ainsi
a) Finir le mode pincement à la place du zoom
B) Déplacer mini map/ oeuvre d'art et affiche dans des nouveaux menus





01.03.2026
Le premier scenario (faire a révolution) fonctionne
Je dois maintenant
Ajouter un cadre pour cacher l'oeuvre d'art
Refaire u. Décompte qui affiche les questions et refaire les questions du scénario qui s'affiche pas bien


27.02.2026
Liste des choses à faire
Je dois recommencer le menu
En 191710 on a le premier scénario, faire la révolution, puis on arrive sur le tutoriel et on passe à 191711

Tutoriel centré sur la bataille de Moscou

Puis chaque partie, on passe de avec l'option de participer au débat


Problème des villes
Possession ville à comme valeur
proprietaire = V2_proprietaire

Souscampville = Souscampville

V2_proprietaire =V2_proprietaire

V2_proprietaire est soit "inactif"

Stavaza avancement 
TITRE 6. La prise d'une ville


Je dois réduire à une valeur ET ne pas faire que l'animation soit une cause qui déclenche

J'ai finalisé la victoire si toute les villes sont prises


17.02.2026
en testant le jeu pour voir si la victoire "possede toutes les villes avant dec 1922", je me rend compte que j'ai des situations possessions villes qui sont bizarre

Déja j'ai v2 proprietaire et sous camp
Mais j'ai aussi des situations ou v2 proprietzires et sous camp sont rouge mais animations en blanc, 
il faut que je change tout cela


stavaza,14 02 2026
j'ai corrigé une partie du bug du scenario
mais le resultat n'est pas le meme entre undialogue qui va au bout et un dailogue qui ne va pas au bout, la premiere ligne est effacé


Stavaza
stavaza 20260208
je rajoute le texte "decret de la terre"
bug je n'arrive pas a faire redemarer les dialogues du debut

20260207
mise en place des 43 questions
Mise en place du textre pour 2e questions


20260128
bug 1 = je dois viter cliquer sur la croix, il faudrait que cela lance la vitesse
bug 2 = quand je clique sur documment scenario - le PV ne s'affiche pas, il faut aussi cliquer sur PV OK
Bug 3 = Par mauvaise manip; je peux valider deux politique, l'une après l'autre (je pourrais mettre un petit décompte, style 3,2,1___
Bug 4 : le passage d'une mission à une autre fonctionne mais il semble que les autres points ne fonctionne pas bien. Le dialogue ne se met pas a jour
Bug 5 après les 6 premières questions, le mois ne dure pas 30 secondes

20260127
j'ai corrigé le phylactere qui apparaissait au mauvais endroit durant une seconde
Mais par contre le passage aux questions suivantes et mois suivantne fon ctionne pas bien

20260125
scenario 
BUG : deux bugs les phylacteres sont decalé le premiers mois - les phylacteres ne se relance pas après etre revenu une premiere fois sur le cham strategique - le loepsum s'affiche dans le rapport du 2e mois


20260124
Le bouton pour appliquer une nouvelle question ne fonctionne pas
Le mois d'octobre 1917 ne devrait durer qu'une seconde OK
L'image IMAGE_DOCUMENT_SCENARIO_278_214 apparait alors qu'elle ne devrait pas quand on l'a affiché et qu'on efface le rapport OK
Mettre une limite au zoom OK


Stavaza 4.1.2026
Bug : les blancs nationalistes n'attaque pas ou très très peu faut vérifier si cela marche
Les troupes bolcheviks suivent le chemin de fer dans leur premier trajet






Stavaza 2.1.2026
Creation de troupes OK avec une limite de taille





dejuin 1919 a octobre 1920 apparitions de 1 "BLANCS_MAKHNOVCHTCHINA" à l'est de l'urkain par mois


Basmatchi trouve ses troupes en 191712, en 191801 mais pas en 191805


1er commentaire


Stavaza 
22.12.2025
Je reecris le code 4 en plus simple, pas le choix et je supprime l'enregistrement des soldats qui plante

17.12.2025
l'IA ne créé qu'une seule nouvelle unité pour tous les camps (pas une pour chaque camp)
Quand 5 unités en contact avec un seul unité, toutes disparaissent
Bug durant une partie out tout le monde n'arrivent pas a prendre une ville rouge
Enfin blanc ne bougent pas si rouges ne bougent pas

stavaza 08.06.2025
Faire des textes et images pour les fiches titre 22 caracetere espace compris
txtes 75 caracteres espace compris
Image 120x100
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
