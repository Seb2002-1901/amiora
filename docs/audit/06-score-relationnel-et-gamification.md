# Chapitre 6 — Score relationnel et gamification

Le score relationnel 0–100 est la promesse centrale d'AMIORA. C'est lui qui transforme un carnet de contacts enrichi en « compagnon relationnel » : il apparaît sur l'accueil (Emma 94 %, Papa 67 %, Thomas 38 %, Grand-maman 58 % sur la maquette), sur la liste des relations, sur la fiche relation (barre « Relation 92 % »), dans les statistiques (graphique « Évolution de la relation », axe 0–100 %), dans le « cercle » global (81 %) et jusque dans les widgets. Il alimente les alertes « Relations en danger », les notifications et la hiérarchie visuelle de tout le produit. La gamification (niveaux, XP, badges, défis, séries) en est le prolongement motivationnel.

Or ce cœur du produit **n'est pas spécifié**. Les deux prompts se contentent d'énumérer des variables d'entrée — « fréquence des contacts, temps passé ensemble, activités réalisées, promesses tenues, souvenirs créés » (prompt 1, § Score relationnel) ; « temps sans contact, activités ensemble, promesses tenues, sorties, souvenirs, appels, messages » (prompt 2, § 19) — sans formule, sans pondération, sans règle de décroissance, sans comportement initial, sans plancher ni plafond. Les valeurs affichées d'une source à l'autre sont incompatibles entre elles (Papa vaut selon l'endroit 67, 71, 78 ou 79), preuve qu'aucun calcul ne les a jamais produites. Ce chapitre instruit ce vide, propose une spécification complète et implémentable du score et de la gamification, et traite frontalement la question éthique — quantifier des relations humaines n'est pas un choix neutre.

## Constats — ce que la spécification fait bien

Malgré l'absence de définition, plusieurs fondations sont saines et méritent d'être conservées telles quelles :

- **L'échelle est stable et bien choisie.** Les trois sources convergent sur un score 0–100 par relation. C'est lisible, universellement compris, et compatible avec une barre de progression — le langage visuel des maquettes.
- **Les variables d'entrée sont les bonnes.** L'union des deux listes (appels, messages, rencontres/sorties, activités/voyages, souvenirs créés, promesses tenues, temps sans contact) couvre exactement les signaux qu'une application de ce type peut réellement observer. Il ne manque aucune variable ; il manque uniquement la fonction qui les combine.
- **La séparation implicite entre « santé » et « progression » existe déjà.** La fiche Emma (maquette 3) montre côte à côte une barre de santé (« Relation 92 % ») et une progression cumulative (« Niveau 47 — 4 620 XP »). Cette dualité — un indicateur qui peut baisser, un capital qui ne baisse jamais — est exactement la bonne architecture ; elle est montrée mais jamais énoncée.
- **La boucle score → action est présente.** L'écran « Relations en danger » (maquette 12, prompt 2 § 17) ne se contente pas d'alarmer : il propose des actions correctives concrètes (appeler, organiser un repas, envoyer un cadeau, prévoir une activité). C'est la bonne philosophie : le score n'est pas une note, c'est un déclencheur d'attention.
- **Les badges sont concrets et chiffrés.** Le prompt 2 (§ 20) fournit des seuils précis — Communicateur (100 appels), Aventurier (50 sorties), Voyageur (10 voyages), Fidèle (1 an entretenu), Souvenir Keeper (200 photos) — et la maquette 11 montre une distinction obtenus/à venir. C'est plus abouti que la plupart des specs à ce stade.
- **La conscience éthique est embryonnaire mais réelle.** Le prompt 1 pose deux principes justes : « l'application ne doit pas être addictive de manière nocive » (§ Système addictif) et « les rappels ne doivent pas être intrusifs » (§ Risques). Le ton des maquettes est cohérent avec ces principes : « Ton cercle est en bonne santé », « Relation à entretenir » en orange (et non en rouge alarmiste), citation « Les relations fleurissent dans l'attention ».

## Faiblesses et manques

### 1. Le score n'a pas de formule — c'est le manque n° 1 de toute la spécification

Aucune des trois sources ne dit comment les variables se combinent. Conséquences directes :

- **Impossible à développer.** Un développeur ne peut rien implémenter à partir de « Calcul : fréquence des contacts, temps passé ensemble… ». Toute implémentation serait une invention non validée du prestataire, sur la fonctionnalité la plus visible du produit.
- **Impossible à tester.** Sans valeurs attendues pour des cas donnés, aucun test d'acceptation n'est possible. Les valeurs des maquettes ne peuvent pas servir d'oracle puisqu'elles se contredisent (Emma affiche 94 % sur l'accueil et 92 % sur sa fiche, sur la même planche).
- **Impossible à expliquer à l'utilisateur.** Un score qui juge la relation avec son père doit être justifiable (« pourquoi 67 ? »). Un score opaque sera perçu comme arbitraire, donc ignoré — ou pire, anxiogène.

### 2. Aucune pondération par catégorie de relation

Les catégories existent (Partenaire, Famille, Amis, Enfants, Mentors/Professionnel — elles-mêmes incohérentes entre sources, voir chapitre 2), mais le score les ignore. Or on n'entretient pas un mentor comme son partenaire : un message quotidien est normal avec Emma, absurde avec un mentor vu deux fois par an. Un score unique à pondération fixe rendrait toutes les relations non conjugales structurellement « mauvaises », ce qui détruirait la crédibilité du produit dès la première semaine d'usage.

### 3. Aucune notion de cadence attendue, donc aucune décroissance définie

Le produit repose entièrement sur le temps qui passe (« Dernier appel : 21 jours », « 76 jours sans rencontre »), mais rien ne dit à partir de quand un délai devient un problème. Les seuils de « relation en danger » n'existent que sous forme d'exemples contradictoires : 48 et 87 jours (prompt 1), 34 / 72 / 119 jours (prompt 2), 32 / 96 / 61 jours (maquette 12). La même planche de maquettes se contredit d'ailleurs elle-même : Papa est à « 21 jours sans appel » sur l'accueil et à « 32 jours » sur l'écran danger ; Thomas à « 76 jours sans rencontre » sur l'accueil et « 96 jours sans sortie » sur l'écran danger. Sans cadence de référence, aucune décroissance ne peut être calibrée.

### 4. Comportement à froid non défini

Que vaut le score d'une relation ajoutée il y a une heure ? Le parcours du prompt 1 promet que le score est généré « immédiatement » après l'ajout de 3 personnes ; si l'implémentation naïve donne 0 ou une valeur basse (aucune interaction enregistrée), le premier écran que verra l'utilisateur affichera que ses trois personnes les plus chères sont des relations sinistrées. C'est l'inverse de la promesse « en moins de cinq minutes, l'utilisateur obtient de la valeur ».

### 5. La sous-saisie n'est pas traitée

Le score ne mesure pas la relation : il mesure **ce que l'utilisateur a saisi**. Quelqu'un qui voit son père tous les jours mais ne le consigne pas verra le score s'effondrer. Aucune source n'aborde ce biais fondamental, ni les mécanismes pour l'atténuer (saisie en un geste, confirmations rétroactives, plafond de chute).

### 6. Niveaux et XP : des chiffres décoratifs, incohérents entre eux

La maquette 11 affiche « Niveau 47 — 4 620 / 5 000 XP » ; le prompt 2 (§ 10) donne pour la même Emma « Niveau 43, XP 4 920 » ; le cercle global (prompt 2, § 20) affiche « niveau 18, XP 8 240 » pour 8 relations. Aucune courbe de niveaux ne peut réconcilier ces trois affichages :

- Si 4 620 est un total cumulé et 5 000 le seuil du niveau 48, alors 47 niveaux pour 4 620 XP impliquent un coût moyen d'environ **98 XP par niveau** — une courbe quasiment plate, où le niveau n'est qu'un compteur déguisé, sans aucune sensation de progression.
- Si « 4 620 / 5 000 » est la progression **à l'intérieur** du niveau 47, alors ce seul niveau coûte 5 000 XP et le total cumulé se chiffre en dizaines de milliers — inatteignable en un an d'usage réaliste.
- Le cercle global à 8 240 XP pour le niveau 18 implique un coût moyen de ~458 XP par niveau — une troisième courbe implicite, incompatible avec les deux précédentes. Et Emma seule (4 620 à 4 920 XP) représenterait plus de la moitié de l'XP d'un cercle de 8 relations, ce qui est invraisemblable.

Par ailleurs, aucun barème n'attribue d'XP aux actions : combien vaut un appel ? une sortie ? une promesse tenue ? Sans barème, ni le niveau ni les défis n'ont de substance.

### 7. Le cercle global est incohérent avec ses propres composantes

Le « cercle » affiche 81 % (maquette) ou 82 % (prompt 2). Or les quatre relations affichées sur le même écran d'accueil (94, 67, 38, 58 sur la maquette) ont une moyenne de **64,3** ; celles du prompt 2 (94, 71, 44, 59) une moyenne de **67**. Pour qu'une moyenne sur 8 relations atteigne 81 %, les quatre relations non montrées devraient dépasser 97 % chacune. Le cercle n'est donc relié par aucune arithmétique aux scores qu'il est censé agréger — nouvelle preuve que ces valeurs sont décoratives.

### 8. Badges : nomenclature non unifiée, seuils aveugles à la catégorie

Trois divergences (déjà relevées, observation n° 7 du relevé de maquettes) : « Voyageur » (prompt 2) vs « Explorateur » (maquette) pour 10 voyages ; « Fidèle (1 an entretenu) » vs « Fidélité (1 an ensemble) » — deux sémantiques différentes, l'une mesurable par l'application (un an d'entretien régulier), l'autre non (la durée « ensemble » relève de la vie privée, pas du journal) ; badge « Amoureux (2 ans ensemble) » présent uniquement sur la maquette et dénué de sens hors catégorie Partenaire. De plus, « Souvenir Keeper » est un anglicisme isolé dans une interface entièrement francophone. Enfin, les seuils uniques ignorent la catégorie : « 100 appels » est atteignable avec un partenaire en trois mois, avec un mentor en dix ans.

### 9. Séries et défis : la mécanique la plus risquée est la moins spécifiée

Le prompt 1 annonce des séries de « 7 jours, 30 jours, 100 jours » sans dire ce qui entretient la série (ouvrir l'app ? enregistrer une interaction ? avec n'importe qui ?), ni ce qui se passe quand elle casse. Une série **quotidienne** est en contradiction directe avec le principe du même document (« pas addictive de manière nocive ») : aucune relation saine n'exige d'ouvrir une application 100 jours d'affilée ; c'est une mécanique d'engagement applicatif, pas d'attention relationnelle. Les défis mensuels du prompt 2 (§ 21) posent un problème d'accessibilité : « organiser un voyage » est un défi d'argent et de temps libre, pas d'attention — il exclut une partie de la cible.

### 10. L'éthique de la quantification n'est pas instruite

Au-delà des deux phrases de principe du prompt 1, rien n'est dit sur : la comparaison implicite entre proches (l'accueil affiche les êtres aimés triés avec leurs notes — c'est structurellement un classement de personnes) ; l'anxiété et la culpabilisation (un score qui baisse est un reproche permanent) ; la manipulation du système (enregistrer de fausses interactions pour l'XP et les badges) ; le caractère **unilatéral et privé** du score (rien ne précise que l'autre personne ne le voit jamais — point critique dès que la roadmap parle de « partage famille » et de « mode couple ») ; et les cas sensibles (décès, rupture : l'application enverra « Cela fait 30 jours sans voir X » après un enterrement si rien n'est prévu).

## Points à trancher

| # | Contradiction | Sources et valeurs exactes | Décision recommandée |
|---|---|---|---|
| S-01 | Score de Papa | 79 (prompt 1) ; 71 puis 78 (prompt 2) ; 67 (maquette) | Aucune valeur n'a autorité : figer un **jeu de données de démonstration daté du 5 mars 2026** (date de référence des maquettes) et recalculer toutes les valeurs avec la formule normative (§ Recommandations). Idem pour Thomas (44/43/38) et Grand-maman (59/58). |
| S-02 | Score d'Emma : 94 % (accueil) vs 92 % (fiche), sur la même planche | Maquette 2 vs maquette 3 ; prompt 2 donne 94 et 95 | **Un seul score par relation, calculé en un seul endroit**, affiché identique partout. La divergence 94/92 sur une même planche doit être traitée comme un bug de spécification, pas comme deux métriques. |
| S-03 | Niveau/XP d'Emma : 47 / 4 620 XP (maquettes 3 et 11) vs 43 / 4 920 XP (prompt 2 § 10) | Voir faiblesse n° 6 | Abandonner ces valeurs, indéfendables sous toute courbe. Adopter la courbe proposée plus bas et recalibrer la démo (Emma ≈ niveau 12–15 après plusieurs mois d'usage intensif). |
| S-04 | Cercle global : 81 % (maquette) vs 82 % (prompt 2), et « niveau 18, XP 8 240 » incompatible avec les XP par relation | Prompt 2 § 7 et § 20 ; maquette 2 | Définir le cercle comme **moyenne pondérée des scores des relations actives** (pondération par priorité déclarée). Supprimer le niveau/XP « global » distinct en V1 : deux systèmes de niveaux (par relation et global) doublent la complexité pour un bénéfice nul. |
| S-05 | Badges : Voyageur vs Explorateur ; Fidèle (1 an entretenu) vs Fidélité (1 an ensemble) ; Amoureux (2 ans ensemble) présent seulement sur maquette | Prompt 2 § 20 vs maquette 11 | Nomenclature unifiée (table plus bas) : **Voyageur** (plus explicite) ; **Fidèle — 1 an d'attention régulière** (mesurable par l'app et valable pour toutes les catégories, contrairement à « ensemble ») ; **Amoureux** réservé à la catégorie Partenaire ou supprimé ; « Souvenir Keeper » francisé en **Gardien des souvenirs**. |
| S-06 | Variables du score : « fréquence des contacts » (prompt 1) vs « temps sans contact » (prompt 2) et deux listes différentes | Prompt 1 § Score ; prompt 2 § 19 | Prendre l'**union normalisée** : six canaux d'interaction (appels, messages, rencontres/sorties, activités marquantes/voyages, souvenirs, cadeaux) + une composante promesses. « Fréquence » et « temps sans contact » sont les deux faces de la même variable de récence. |
| S-07 | Disponibilité du score : « généré immédiatement » à l'onboarding (prompt 1, parcours) vs score en Phase 2 de la roadmap (prompt 2 § 30) | Contradiction frontale | Distinguer deux questions que les sources confondent. **La spécification de la formule est P0** : elle doit être figée avant tout développement (c'est l'objet de R1, qui reste entièrement valide). **La livraison de l'affichage du score, elle, est v1.1**, après calibrage sur les données réelles de la bêta ; au lancement, les alertes reposent sur la fréquence cible définie par relation, sans note chiffrée. Ce séquencement est celui retenu par l'audit — voir chapitres 03 (matrice MoSCoW : score affiché hors périmètre de lancement) et 12 (recommandation 8 : geler tout développement score/gamification jusqu'aux données de bêta). Le mode « à froid » (voir spec) reste nécessaire à la livraison pour afficher un score sans mentir sur un journal vide. |
| S-08 | Seuils « relations en danger » : 48/87 j (prompt 1), 34/72/119 j (prompt 2), 32/96/61 j (maquette) | Observation n° 9 du relevé | Aucun seuil absolu : des seuils **relatifs à la cadence attendue de chaque relation** (voir spec : « à entretenir » au-delà de 2× la cadence, « à reconnecter » au-delà de 3×). Un seuil fixe en jours est indéfendable dès que les catégories ont des rythmes différents. |
| S-09 | Délais incohérents sur la même planche : Papa 21 j (accueil) vs 32 j (danger) ; Thomas 76 j (accueil) vs 96 j (danger) | Maquettes 2 et 12 | Conséquence de S-01 : un jeu de démo unique et daté, dont toutes les maquettes dérivent. |

## Recommandations

### R1 (P0) — Spécifier le score relationnel : formule normative proposée

La proposition suivante est complète, implémentable et calibrée pour reproduire l'ordre de grandeur des valeurs des maquettes. Elle peut être adoptée telle quelle ou servir de base d'arbitrage ; ce qui est P0, c'est qu'**une** formule de ce niveau de précision soit figée avant tout développement.

**Principe.** Le score mesure la *fraîcheur de l'attention* par canal d'interaction, rapportée à la *cadence attendue* de la relation. Chaque relation a, pour chaque canal, une période attendue P (en jours) issue de valeurs par défaut de sa catégorie, personnalisable par l'utilisateur (« je veux appeler papa chaque semaine » → P<sub>appel</sub> = 7). Tant que le délai depuis la dernière interaction du canal reste inférieur ou égal à P, la composante vaut son maximum (période de grâce) ; au-delà, elle décroît exponentiellement avec une **demi-vie de 2 P** :

> F<sub>c</sub> = 1 si d<sub>c</sub> ≤ P<sub>c</sub> ; sinon F<sub>c</sub> = 2^(−(d<sub>c</sub> − P<sub>c</sub>) / (2·P<sub>c</sub>))

où d<sub>c</sub> est le nombre de jours depuis la dernière interaction du canal c. Concrètement : à jour = 100 % de la composante ; à 3× la cadence attendue, elle vaut 50 % ; à 5×, 25 %. La décroissance est douce, jamais brutale, et proportionnée au rythme propre de chaque relation — un délai de 30 jours est anodin pour une amie vue mensuellement et alarmant pour un partenaire.

**Score.** Somme pondérée des fraîcheurs par canal, plus une composante promesses :

> Score = 100 × [ Σ<sub>c</sub> w<sub>c</sub> · F<sub>c</sub> + w<sub>p</sub> · Q<sub>p</sub> ]

avec Q<sub>p</sub> = qualité de tenue des promesses actives de la relation (tenue à temps = 1 ; en cours dans les délais = 0,7 ; en retard = 0,2 ; rompue = 0 ; moyenne pondérée par récence ; **0,5 neutre** si aucune promesse — l'absence de promesse ne doit ni punir ni récompenser).

**Pondérations et cadences par défaut par catégorie** (Σ des poids = 1 par ligne ; les cadences P sont des valeurs par défaut modifiables relation par relation) :

| Catégorie | Rencontres/sorties | Messages | Appels | Activités/voyages | Souvenirs | Promesses |
|---|---|---|---|---|---|---|
| Partenaire | 0,35 (P = 7 j) | 0,20 (P = 1 j) | 0,15 (P = 2 j) | 0,10 (P = 90 j) | 0,10 (P = 14 j) | 0,10 |
| Famille | 0,30 (P = 30 j) | 0,15 (P = 7 j) | 0,35 (P = 7 j) | — | 0,10 (P = 30 j) | 0,10 |
| Amis | 0,40 (P = 21 j) | 0,25 (P = 7 j) | 0,10 (P = 14 j) | 0,10 (P = 60 j) | 0,10 (P = 45 j) | 0,05 |
| Enfants | 0,40 (P = 7 j) | 0,10 (P = 3 j) | 0,20 (P = 3 j) | 0,10 (P = 30 j) | 0,15 (P = 14 j) | 0,05 |
| Mentor/Professionnel | 0,30 (P = 90 j) | 0,30 (P = 30 j) | 0,20 (P = 45 j) | — | 0,05 (P = 90 j) | 0,15 |

**Plancher et plafond.** Score affiché borné à [15 ; 100]. Une relation présente dans l'application n'est jamais « à zéro » : sous 15, elle passe à l'état qualitatif « en veille » plutôt que d'afficher un chiffre humiliant. Le plafond est 100 sans mécanique de dépassement : au-delà d'un certain point, l'application n'a rien à vendre de plus — c'est un choix éthique autant que fonctionnel.

**Comportement à froid.** Une relation nouvellement créée n'affiche **pas de score chiffré** pendant 14 jours ou jusqu'à 3 interactions enregistrées (premier des deux atteint) : elle affiche une pastille « Nouvelle relation ». En interne, les composantes sont initialisées à 0,65 (score latent ≈ 65, neutre-positif), de sorte que la première valeur affichée soit encourageante et non accusatrice. Cela réconcilie la promesse du prompt 1 (« génère immédiatement… score relationnel ») avec la réalité d'un journal vide.

**Tolérance à la sous-saisie.** Trois garde-fous : (a) la chute du score affiché est plafonnée à **−8 points par semaine**, quel que soit le calcul brut — une quinzaine chargée sans saisie ne doit pas donner l'impression d'un effondrement relationnel ; (b) une « confirmation douce » périodique (« Avez-vous vu Thomas récemment ? Oui, la semaine dernière ») met à jour rétroactivement les dates de dernière interaction en un geste ; (c) chaque notification de relance embarque une saisie en un tap (« ✔ Je l'ai appelé·e »).

**Validation par les maquettes.** La formule reproduit plausiblement les valeurs de la planche avec des hypothèses de démo réalistes (date de référence : 5 mars 2026) :

| Relation | Hypothèses de démonstration | Détail du calcul | Score |
|---|---|---|---|
| **Emma** (Partenaire) | message aujourd'hui, appel hier, sortie il y a 5 j, voyage il y a 3 mois (données de la fiche maquette 3) ; promesses Q = 0,7 ; souvenirs F = 0,7 | 35×1 + 20×1 + 15×1 + 10×1 + 10×0,7 + 10×0,7 | **94** |
| **Papa** (Famille, cadence appel personnalisée : 7 j) | appel il y a 21 j (F = 0,50) ; rencontre 28 j (F = 1) ; message 11 j (F = 0,82) ; promesse « appeler chaque semaine » en retard (Q = 0,2) ; souvenir 90 j (F = 0,50) | 35×0,50 + 30×1 + 15×0,82 + 10×0,2 + 10×0,50 | **67** |
| **Thomas** (Ami) | rencontre il y a 76 j (F = 0,40) ; message 30 j (F = 0,32) ; appel 76 j (F = 0,22) ; activité 200 j (F = 0,45) ; aucune promesse (Q = 0,5) ; souvenir 150 j (F = 0,45) | 40×0,40 + 25×0,32 + 10×0,22 + 10×0,45 + 5×0,5 + 10×0,45 | **38** |

Les trois valeurs de l'accueil maquetté (94, 67, 38) sont retrouvées exactement, avec des délais cohérents avec ceux affichés (« dernière sortie : 5 jours », « dernier appel : 21 jours », « dernière rencontre : 76 jours »). La formule est donc compatible avec le matériel visuel existant — il suffit de figer les hypothèses ci-dessus comme jeu de démonstration officiel et d'aligner Grand-maman et le cercle global dessus.

**États dérivés (remplace les seuils absolus de « relations en danger »).** « À jour » : score ≥ 70 et aucun canal au-delà de 2× sa cadence. « À entretenir » (orange, comme sur la maquette) : score < 70 **ou** un canal principal au-delà de 2× sa cadence. « À reconnecter » : score < 40 **ou** canal principal au-delà de 3× sa cadence. Ces règles rendent les trois jeux de seuils contradictoires des sources (48/87, 34/72/119, 32/96/61 jours) caducs et adaptent l'alerte au rythme de chaque relation.

### R2 (P0) — Éthique : faire du score un outil privé, unilatéral et désactivable

Ces garde-fous doivent être écrits dans la spécification au même rang que la formule, car ils conditionnent des choix d'architecture (modèle de données, partage) impossibles à rattraper après coup :

1. **Le score est unilatéral et strictement privé.** Il reflète le journal tenu par l'utilisateur, pas la qualité réelle ni réciproque de la relation, et encore moins ce que l'autre pense. La personne concernée ne le voit **jamais** ; il n'existe aucune fonctionnalité « voir le score que X m'attribue », aucun partage, aucun classement public ni entre utilisateurs. Ce principe doit être gravé maintenant, car la roadmap prévoit « mode couple », « mode famille » et « partage familial » (prompt 1 V2, prompt 2 phase 4) : ces modes partagés devront **exclure structurellement scores, XP et alertes** — seuls souvenirs, événements et albums sont partageables.
2. **Pas de classement des proches.** L'accueil trié par score est, de fait, un palmarès des êtres aimés (Thomas 38 sous Emma 94 se lit comme un jugement). Trier par « prochaine action utile » (anniversaire imminent, relance suggérée) plutôt que par score décroissant ; ne jamais proposer de vue « classement ».
3. **Masquage.** Réglage global « masquer les scores » remplaçant les chiffres par les trois états qualitatifs (À jour / À entretenir / À reconnecter), et opt-out par relation. Certains utilisateurs voudront les rappels sans la note — ils ont raison.
4. **Formulation bienveillante, factuelle, jamais accusatrice.** « Aucune interaction enregistrée depuis 34 jours » plutôt que « Vous négligez Thomas ». Les maquettes ont déjà le ton juste ; il faut le normer dans un guide de rédaction. Renommer l'écran « Relations en danger » — vocabulaire de triage médical — en « Reprendre contact » ou « À reconnecter ».
5. **Cas sensibles.** Statuts « En pause » et « En mémoire » (décès) : score gelé, rappels et défis coupés, souvenirs conservés et mis en valeur. Sans cela, l'application enverra mécaniquement « Cela fait 30 jours sans voir X » après un décès — un dommage éthique et réputationnel majeur pour un produit qui se veut « album de vie émotionnel ».
6. **Anti-manipulation.** Le gaming (saisir de fausses interactions pour l'XP) est surtout auto-destructeur puisque l'utilisateur se ment à lui-même, mais les mécaniques ne doivent pas l'encourager : plafonds d'XP quotidiens (voir R3), récompenses pondérées vers les interactions réelles (rencontres, promesses tenues) plutôt que vers les saisies pures (notes, photos), et aucune récompense liée au simple fait d'ouvrir l'application.

### R3 (P1) — XP et niveaux : barème et courbe

**Séparation stricte des deux systèmes** : le score est la *santé* (il monte et descend) ; l'XP est l'*histoire* (elle ne descend jamais). Ne jamais faire décroître l'XP : la perte de progression est la mécanique la plus anxiogène de la gamification.

**Barème d'XP par action** (par relation) :

| Action enregistrée | XP | Plafond anti-farming |
|---|---|---|
| Message | 2 | 10 XP/jour |
| Appel | 10 | 20 XP/jour |
| Rencontre / sortie | 25 | 1/jour |
| Activité marquante / voyage | 60 | — |
| Souvenir (photo, note, audio) | 5 | 25 XP/jour |
| Cadeau offert | 20 | — |
| Promesse tenue | 40 | — |
| Capsule temporelle / lettre | 30 | — |
| Défi hebdomadaire complété | 50 | 1/semaine |
| **Plafond global** | | **120 XP/jour/relation** |

**Courbe de niveaux** : coût du passage du niveau n au niveau n+1 = **50 × n XP** (niveau 2 : 50 XP ; niveau 10 : 450 XP ; cumul ≈ 25 n²). L'affichage montre la progression **dans le niveau courant** (« 320 / 500 XP »), pas le total brut. Avec ce barème, une relation très entretenue (~60 XP/jour en moyenne) atteint le niveau ~20 en six mois et ~29 en un an ; une relation normale le niveau 8–12 la première année. Le « Niveau 47 » de la maquette est inatteignable et doit être recalibré dans la démo (Emma ≈ niveau 14, « 320 / 700 XP ») — un niveau élevé dès la démo dévalorise d'ailleurs la progression réelle des futurs utilisateurs. Le cercle global, lui, n'a **pas** de niveau propre en V1 (voir S-04) : c'est la moyenne pondérée des scores, point.

### R4 (P1) — Badges : nomenclature unifiée et sensible à la catégorie

| Badge (nom unifié) | Condition | Notes |
|---|---|---|
| Communicateur | 100 appels | Identique dans prompt 2 et maquette — conserver. |
| Aventurier | 50 sorties | Identique — conserver. |
| Voyageur | 10 voyages | Trancher contre « Explorateur » (maquette), plus vague. |
| Fidèle | 1 an d'attention régulière (relation maintenue « À jour » ≥ 40 semaines sur 52) | Remplace « 1 an entretenu » / « 1 an ensemble » : mesurable par l'app, valable pour toutes les catégories. |
| Gardien des souvenirs | 200 photos | Francise « Souvenir Keeper », anglicisme isolé. |
| Amoureux | 2 ans d'attention régulière, catégorie Partenaire uniquement | Sinon supprimer ; « 2 ans ensemble » n'est pas mesurable par l'app. |

Deux compléments : décliner les seuils quantitatifs par paliers (bronze/argent/or : 25/100/500 appels) plutôt que multiplier les badges ; et adapter les seuils à la catégorie (100 appels est un an de Partenaire et dix ans de Mentor — un badge inatteignable est pire qu'un badge absent).

### R5 (P2) — Défis et séries : hebdomadaires, avec jokers, accessibles

- **Séries hebdomadaires, pas quotidiennes.** Remplacer « 7 / 30 / 100 jours » (prompt 1) par des semaines d'attention : une semaine est validée si au moins une interaction réelle est enregistrée. Paliers : 4, 12, 52 semaines. Une série quotidienne mesure l'assiduité envers l'application ; une série hebdomadaire mesure l'attention aux personnes — c'est la seconde que le produit promet.
- **Jokers.** 1 joker par mois préserve la série en cas de semaine vide. La casse sèche d'une longue série est le premier motif de désinstallation rageuse des apps à streaks.
- **Défis opt-in et accessibles.** Les défis hebdomadaires du prompt 2 (voir un proche, appeler un parent, créer un souvenir…) sont bons car gratuits. Retirer ou reléguer les défis coûteux (« organiser un voyage ») : un défi qui exige argent et congés exclut une partie de la cible 25–45 ans et transforme l'attention en performance de consommation.

### R6 (P2) — Explicabilité du score

Ajouter sur la fiche relation un panneau « Pourquoi ce score ? » listant les composantes (« Appels : à jour · Rencontres : il y a 28 jours · Promesse en retard : −8 pts »). Coût de développement faible une fois la formule R1 en place, bénéfice majeur : un score explicable est un score accepté, et le panneau devient lui-même un déclencheur d'action.

## Verdict

**Pas prêt.** Le score relationnel — la fonctionnalité qui définit AMIORA — n'existe aujourd'hui que comme une liste de variables et une collection de valeurs d'exemple mutuellement incompatibles (quatre scores pour Papa, deux pour Emma sur la même planche, trois courbes d'XP implicites irréconciliables) ; en l'état, rien n'est développable ni testable. Le chemin de sortie est néanmoins court et balisé : adopter une formule normative du type proposé ici (fraîcheur par canal, demi-vie de 2× la cadence attendue, pondérations par catégorie, plancher 15, démarrage neutre), qui reproduit exactement les valeurs des maquettes (Emma 94, Papa 67, Thomas 38), figer le barème XP et la courbe de niveaux, unifier les badges, et graver les garde-fous éthiques — score unilatéral, privé, masquable, jamais partagé, statuts « en pause / en mémoire » — au rang d'exigences P0. Sans ce travail, le produit livrera au mieux un gadget arbitraire, au pire une machine à culpabiliser ; avec lui, la mécanique centrale devient spécifiée, implémentable et défendable.
