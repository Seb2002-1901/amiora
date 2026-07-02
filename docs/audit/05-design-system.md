# Design et système visuel

Ce chapitre audite la direction artistique d'AMIORA et la planche de 12 maquettes, seul livrable visuel existant. Les trois sources convergent sur une intention claire : « noir premium, or élégant, cartes gris anthracite, grandes photos, coins arrondis » (prompt n° 1, section Design), « fond noir profond ; cartes anthracite ; accent or premium ; succès vert doux ; alertes orange ; erreurs rouge discret » (prompt n° 2, § 5), et des maquettes qui appliquent fidèlement cette direction. C'est un vrai point fort — et il ne faut pas s'y tromper : une direction artistique n'est pas un système de design. Aucune valeur n'est figée (pas un seul code couleur, pas une taille de police, pas une règle d'espacement), l'iconographie repose exclusivement sur des émojis, aucun état système (vide, chargement, erreur, hors-ligne) n'est dessiné, et les 12 écrans maquettés couvrent au mieux un tiers de la surface réelle du produit. Le prompt n° 1 pose lui-même l'exigence — « le design doit être extrêmement premium » — et la roadmap alloue un mois entier au « design complet » : ce chapitre établit ce que ce mois doit produire, y compris un embryon de design system prêt à être figé.

## Constats

**Une direction artistique cohérente entre les trois sources — fait rare à ce stade.** Le prompt n° 1, le prompt n° 2 (§ 5) et le relevé des maquettes décrivent la même chose : fond noir profond, cartes anthracite très arrondies, accent or, typographie blanche, photographie émotionnelle. Sur les 12 écrans, aucune rupture stylistique n'est constatée : même fond, même traitement des cartes, même or, même famille d'illustrations au trait doré (double cœur du logo, « pinky promise » de l'écran Promesses, coffre au trésor de la Capsule temporelle, grand cœur de « Relations en danger »). Cette homogénéité de planche est un actif réel : le langage visuel existe, il est reconnaissable, et il pourra être systématisé sans être réinventé.

**Le positionnement chromatique est juste.** Le noir/or sert le positionnement « album de vie émotionnel » premium et différencie immédiatement AMIORA des applications de productivité (généralement claires et bleues) comme des réseaux sociaux. La palette fonctionnelle annoncée par le prompt n° 2 — vert doux pour le succès, orange pour l'alerte, rouge discret pour l'erreur — est sobre et complète sur le papier : trois couleurs sémantiques suffisent à un produit de cette nature. Le choix d'un rouge « discret » est cohérent avec la volonté affichée de ne pas culpabiliser (« les rappels ne doivent pas être intrusifs », prompt n° 1).

**Un vocabulaire de composants émerge déjà des maquettes.** Sans avoir été formalisé, un inventaire de composants récurrents se lit sur les 12 écrans, et il est réutilisé de façon plutôt disciplinée :

| Composant | Écrans où il apparaît | Observation |
|---|---|---|
| Carte relation (avatar rond, nom, score %, méta « dernière interaction », chevron) | 2 (Accueil), 12 (variante alerte) | Le composant central du produit ; la variante « danger » (triangle, compteur de jours) en dérive |
| Barre de progression or | 2 (cercle 81 %), 3 (relation 92 %), 11 (XP 4 620 / 5 000) | Trois usages sémantiquement différents d'un même composant — à unifier |
| Bouton « + » central de la barre d'onglets (FAB or) | 2, 5, 6, 8, 9 | Action de création jamais spécifiée (que crée-t-il ?) |
| Tuile statistique (grand chiffre + libellé) | 9 (six tuiles : 214, 43, 8, 317, 63, 284 h) | — |
| Timeline verticale à puces or | 7 (Ligne de vie) | Avec vignettes photo optionnelles |
| Checklist à cases | 8 (Promesses) ; annoncée pour les Défis (prompt n° 2, § 21) | — |
| Badge / écusson | 11 (obtenus vs grisés) | Deux états déjà visibles, c'est bien |
| Segmented control | 8 (« À faire / Terminées ») | Deux segments seulement, alors que les prompts annoncent trois statuts |
| Puces de filtre | 6 (Photos, Voyages, Moments, Notes) ; annoncées écran Relations (prompt n° 2, § 8) | État actif = or |
| Bouton principal or pleine largeur | 4 (« Enregistrer »), 10 (« Écrire le message ») | — |
| Ligne de formulaire | 4 (Ajouter une personne) | Sept champs dessinés sur ~30 spécifiés |
| Encart éditorial / citation | 2, 8, 12 | Ton « bienveillant » cohérent |
| Grille photos groupée par mois | 6 | — |
| Ligne d'interaction (icône, type, ancienneté) | 3 | — |
| En-tête d'écran (retour, titre, action droite) | 3, 4, 5, 7, 8, 9, 10, 11 | — |
| Barre d'onglets 5 items | 2, 5, 6, 8, 9 | Incohérente entre écrans (voir Points à trancher) |
| Illustration au trait doré | 1, 8, 10, 12 | Signature graphique propre, à conserver |

Dix-sept composants identifiables sur 12 écrans : c'est la matière première d'un design system. Elle existe ; il reste à la nommer, la spécifier et la figer.

**La discipline de présentation est correcte.** Gabarit iOS standard (heure « 9:41 »), interface intégralement en français, données de démonstration globalement cohérentes entre écrans (la date de référence « mercredi 5 mars 2026 » du calendrier concorde avec le « 5 mars 2027 » de la capsule). La planche est présentable telle quelle à un investisseur ou à un développeur — c'est son rôle, et elle le remplit.

## Faiblesses et manques

### Aucune valeur n'est figée : « or premium » n'est pas une spécification

Nulle part dans les trois sources ne figure un code couleur, une famille de polices, un corps de texte, un rayon d'angle ou une unité d'espacement. « Titres épais ; texte simple et moderne » (prompt n° 2, § 5) est une intention, pas une donnée exploitable : deux développeurs produiront deux applications différentes à partir de cette phrase. De même, « animations très fluides ; effet verre ; transitions lentes ; petites vibrations » (§ 5) n'est traduit nulle part en durées, courbes d'interpolation ou motifs haptiques — et « transitions lentes » est même une prescription risquée telle quelle : une transition perçue comme lente sur une action fréquente (ouvrir une fiche) dégrade l'usage quotidien. Tant que ces valeurs ne sont pas figées dans des tokens, chaque écran développé sera une interprétation, et l'homogénéité constatée sur la planche se dissoudra dans le code.

### Contraste et accessibilité : le risque est réel et n'est traité nulle part

Aucune des trois sources ne mentionne l'accessibilité. Or le parti pris sombre est précisément celui qui exige le plus de rigueur :

- **L'or sur noir fonctionne pour les titres, mais tout dépend de la valeur choisie.** Un or franc (type #D9B45B) atteint un contraste d'environ 8:1 sur noir profond et passe WCAG AA même en petit corps ; un or plus sourd ou désaturé peut tomber sous 4,5:1 et échouer pour les petits textes — et les maquettes utilisent justement l'or en petit corps (« Anniversaire : dans 18 jours » sur l'Accueil). La valeur doit être figée puis vérifiée, pas « environ dorée ».
- **Les petits textes gris sur anthracite sont le point de rupture le plus probable.** Les méta-informations (« Dernière sortie : il y a 5 jours », « Dernier appel : il y a 21 jours ») sont, d'après le relevé, en gris atténué sur cartes anthracite. Sur un fond de carte autour de #1C1C21, tout gris plus sombre qu'environ #8A8886 échoue au seuil AA de 4,5:1 pour du texte courant. C'est exactement la zone où les designers « premium sombre » aiment descendre pour l'élégance. Un audit de contraste systématique de toutes les paires texte/fond est indispensable, en outillage (pas à l'œil).
- **La couleur porte seule du sens.** Les scores sont colorés (94 % en vert, 38 % en orange sur l'Accueil) : pour environ un homme sur douze (daltonisme), cette distinction disparaît. La maquette contient déjà le bon réflexe — le libellé texte « Relation à entretenir » double la couleur pour Thomas — mais ce doublage doit devenir une règle systématique (couleur + libellé ou icône, jamais couleur seule).
- **Rien n'est dit** des tailles de zones tactiles (44 pt minimum), du support de l'agrandissement de police système (Dynamic Type / font scaling — critique pour une cible qui inclut les 45 ans et des grands-parents dans les contenus), ni des libellés pour lecteurs d'écran. Sur ce dernier point, l'iconographie émoji aggrave tout : VoiceOver lira « homme adulte » pour 👨 Papa.

### L'iconographie 100 % émoji est une dette visuelle à rembourser avant le lancement

Les 12 maquettes et le prompt n° 2 utilisent l'émoji comme unique système iconographique : catégories de personnes (❤️ 👨 👦 👵), actions (📞 ✉️ 📅 🎁), types d'événements (🎂 🍝), navigation (🏠 ❤️ ➕ 📖 👤, § 5). C'est acceptable pour une maquette, pas pour un produit « extrêmement premium » :

1. **Rendu non maîtrisé** : les émojis sont dessinés par la plateforme. Le même écran aura des icônes différentes sur iOS, sur Android, et entre versions d'un même OS — l'antithèse d'un design system.
2. **Dissonance esthétique** : des émojis multicolores, brillants et cartoon sur une interface noir/or au trait fin contredisent la direction artistique. Le logo (double cœur entrelacé au trait fin doré) donne pourtant la bonne référence stylistique.
3. **Sémantique fragile et datée** : l'écran 3 utilise ❤️ pour « Sortie » et 🧡 pour « Voyage », alors que ❤️ désigne ailleurs la catégorie « Partenaire » et l'onglet « Relations » — trois sens pour un même glyphe. Les émojis de personnes (👨 = Papa, 👵 = Grand-maman) figent en outre des stéréotypes d'âge et de genre que l'utilisateur ne contrôle pas.
4. **Vieillissement** : une interface construite sur les émojis de 2026 aura l'air d'un prototype en 2028.

La recommandation est sans ambiguïté : une bibliothèque d'icônes dédiée, au trait fin, dans la lignée du logo, avec la touche émotionnelle en accent (remplissage or ou détail cœur sur quelques icônes clés). Les émojis restent légitimes à un seul endroit : le contenu saisi par l'utilisateur (titres de souvenirs, notes).

### Les maquettes montrent un produit rempli — jamais le produit réel du premier jour

Deux problèmes distincts se cachent derrière les belles photos :

- **Droits d'image.** Les maquettes contiennent des photographies réalistes (groupe familial au coucher de soleil, vignettes de la Ligne de vie, photo de chien). Leur provenance n'est documentée nulle part. Avant tout usage public — site, stores, dossier investisseur —, chaque image doit être remplacée par un visuel dont la licence est établie (banque d'images sous licence, shooting propre, ou génération avec droits clairs), et le jeu de données de démonstration (Emma, Papa, Thomas, Grand-maman, dates de mars 2026) doit être figé dans un document unique — le chapitre cohérence a montré que même la planche actuelle se contredit (Emma à 92 % sur sa fiche et 94 % sur l'Accueil de la même planche).
- **L'écran vide n'est dessiné nulle part, et c'est pourtant lui que verra chaque nouvel utilisateur.** Les 12 écrans montrent un compte après des mois d'usage : 81 % de santé de cercle, 4 620 XP, des grilles de photos pleines. L'utilisateur réel du jour 1 aura zéro souvenir, zéro statistique, une ligne de vie vide et un score incalculable. Le prompt n° 1 exige « de la valeur en moins de cinq minutes » : cette promesse se joue précisément dans les états vides, qui sont absents de la planche.

### Les états système sont totalement absents

Aucun écran de chargement, aucun squelette, aucun message d'erreur, aucun mode hors-ligne, aucune demande de permission (notifications, photothèque), aucune confirmation de suppression n'est maquetté. Les 12 écrans sont douze chemins heureux. Or pour une application dont la valeur repose sur des photos (upload, quota des 100 photos gratuites), des notifications (permission refusable) et une consultation en mobilité (réseau instable), ces états ne sont pas des détails : ils sont une part importante des écrans réellement développés, et les laisser à l'improvisation du développeur garantit une expérience incohérente.

### La « santé du cercle » et les « Relations en danger » frôlent le dark pattern

La carte « Ton cercle est en bonne santé : 81 % » (écran 2) et l'écran « Relations en danger » (triangles d'alerte, compteurs « Dernier appel : 32 jours » en rouge/orange) construisent visuellement une mécanique de culpabilisation : un pourcentage global qui baisse, des proches en rouge. Le prompt n° 1 affirme pourtant que « l'application ne doit pas être addictive de manière nocive » et que « les rappels ne doivent pas être intrusifs ». La tension est réelle, et elle a trois coûts : un coût éthique (jouer sur la culpabilité vis-à-vis de sa propre grand-mère), un coût de rétention (l'utilisateur qui se sent jugé supprime l'application — l'exact inverse de la « définition du succès »), et un coût de cas limites douloureux (que devient le score d'une personne décédée, d'une relation en brouille volontaire, d'un proche hospitalisé ?). Le traitement visuel doit être retourné vers le positif : formulation « à raviver » plutôt que « en danger », iconographie non anxiogène, et possibilité de mettre une relation « en pause » sans pénalité visuelle.

### Un seul gabarit iOS, aucune déclinaison Android

Toute la planche est au gabarit iOS (heure 9:41). La roadmap promet pourtant une publication simultanée iOS et Android. Rien n'est dit des adaptations Android : geste retour, tailles et densités d'écran, conventions de la plateforme. Il ne s'agit pas de tout redessiner en Material, mais de décider explicitement ce qui est commun (l'identité) et ce qui suit la plateforme (navigation système, feuilles de partage, dialogues de permission).

### Douze maquettes pour un produit qui en exige trente à quarante

C'est le manque le plus massif. En croisant les écrans promis par les prompts avec ce que les stores et le RGPD exigent, la liste des écrans à maquetter s'établit ainsi :

- **Onboarding et compte (~8)** : écrans 2 et 3 de l'onboarding (promis au § 6 du prompt n° 2, non maquettés), création de compte (Apple / Google / e-mail), saisie e-mail + mot de passe, vérification d'e-mail, mot de passe oublié, ajout guidé des 3 premières personnes, demandes de permissions (notifications, photos).
- **Saisie et édition (~9)** : saisie d'une interaction (le geste central du produit, absent de toutes les sources — voir chapitre périmètre), édition d'une personne (les ~30 champs du § 9 : préférences, cadeaux, dates importantes), création d'événement calendrier (le « + » de l'écran 5 est muet), création de souvenir (photo, note, audio), détail d'un souvenir, création de promesse, écriture d'une capsule, liste des capsules, ouverture d'une capsule.
- **Paramètres et légal (~8)** : le prompt n° 2 (§ 26) promet huit rubriques — thème, langue, notifications, sauvegardes, sécurité, confidentialité, export des données, suppression de compte — dont aucune n'est maquettée ; s'y ajoutent CGU/politique de confidentialité et la double confirmation de suppression de compte (exigence Apple).
- **Monétisation (~5)** : paywall (7,99 CHF/mois, 59,99 CHF/an, et le Premium Plus à 11,99 CHF/mois si maintenu), comparaison des offres, gestion de l'abonnement, restauration des achats, et les écrans de limite atteinte (11ᵉ relation, 101ᵉ photo) — moments de conversion décisifs, aujourd'hui invisibles.
- **Écrans systémiques (~7)** : recherche (promise au § 8), centre de notifications (la cloche de l'Accueil ne mène nulle part), états vides des listes principales, erreur réseau, hors-ligne, chargement.
- **Autres écrans promis (~5)** : profil (onglet présent, écran absent), historique complet (§ 11), défis (§ 21), statistiques avancées Premium, configuration des widgets.

Soit environ 30 à 40 écrans réels contre 12 maquettés : la planche couvre le tiers « vitrine » du produit — celui qui se montre — et laisse non dessinés le tiers « saisie » et le tiers « gestion », qui sont pourtant ceux où se gagnent l'activation, la conversion et la conformité.

## Points à trancher

1. **Thème : les Paramètres promettent « Thème » (prompt n° 2, § 26), mais tout le reste — direction artistique, maquettes, positionnement — décrit un produit exclusivement sombre.** Concevoir et maintenir un thème clair double le coût de design et de QA visuelle pour un bénéfice nul au lancement. **Recommandation ferme : thème sombre unique au lancement ; retirer l'entrée « Thème » des Paramètres V1 ; en contrepartie, construire la palette en tokens sémantiques (fond, surface, texte primaire…) et non en valeurs codées en dur, pour qu'un thème clair reste possible plus tard sans refonte.**
2. **Barre d'onglets : « Souvenirs » ou « Calendrier » en quatrième position ?** L'écran 5 affiche un onglet « Calendrier » là où les quatre autres écrans à barre d'onglets et les deux prompts affichent « Souvenirs » (incohérence n° 1 du relevé). **Recommandation ferme : figer Accueil / Relations / + / Souvenirs / Profil.** Les souvenirs sont le cœur du positionnement (« coffre à souvenirs ») et le moteur de rétention revendiqué par la définition du succès ; le calendrier reste accessible depuis la section « Aujourd'hui » de l'Accueil et depuis les fiches. Corriger la maquette 5.
3. **Le double « + ».** Les écrans 6, 8 et 9 cumulent le bouton « + » central de la barre d'onglets et un FAB « + » flottant en bas à droite : deux affordances de création concurrentes sur le même écran, sans que ni l'une ni l'autre ne soit spécifiée. **Recommandation ferme : un seul « + » — le bouton central — ouvrant une feuille de création contextuelle (personne, souvenir, promesse, événement, l'onglet actif préséléctionnant le type) ; supprimer les FAB flottants.**
4. **Émojis ou bibliothèque d'icônes.** Tranché plus haut sur le fond. **Recommandation ferme : bibliothèque d'icônes propriétaire ou open source au trait fin, teintée dans la palette, avec accents émotionnels dessinés ; les émojis sont réservés au contenu utilisateur.** C'est un chantier borné (30 à 40 glyphes couvrent les 12 écrans actuels) et à faire avant le développement, pas après.
5. **Règles chromatiques du score.** Les maquettes colorent 94 % en vert et 38 % en orange, sans règle énoncée ; les seuils du score eux-mêmes ne sont normés nulle part (voir chapitre cohérence). **Recommandation ferme côté design : trois états visuels et pas plus (bon = vert doux, neutre = or/blanc, à raviver = orange), chacun systématiquement doublé d'un libellé texte ; les seuils numériques exacts sont à fixer avec la formule du score, mais la grammaire visuelle peut et doit être figée dès maintenant.** Le rouge est réservé aux erreurs système, jamais aux personnes.
6. **Photos de démonstration.** **Recommandation ferme : avant toute diffusion publique de la planche ou des captures stores, remplacer chaque photographie par un visuel sous licence documentée, et consigner le jeu de démonstration canonique (personnages, scores, dates — date de référence proposée : 5 mars 2026) dans le design system.**

## Recommandations

### P0 — Figer le design system v1 (condition d'entrée du développement)

Le livrable prioritaire est un document de tokens court (10 à 15 pages) qui transforme la direction artistique en valeurs. L'embryon suivant est proposé comme base de décision — chaque valeur est à valider par le porteur du projet puis à vérifier en outillage de contraste, mais l'important est qu'après cet arbitrage, plus rien ne soit « environ » :

**Palette (valeurs hexadécimales proposées, contrastes indicatifs à confirmer en outillage) :**

| Token | Usage | Hex proposé | Contraste indicatif |
|---|---|---|---|
| `bg/base` | Fond d'écran noir profond | `#0E0E10` | — |
| `surface/card` | Cartes anthracite | `#1C1C21` | — |
| `surface/raised` | Surfaces élevées (feuilles, menus) | `#26262B` | — |
| `text/primary` | Texte principal blanc cassé | `#F5F4F0` | ≈ 15:1 sur carte — AA/AAA |
| `text/secondary` | Méta-informations grises | `#A5A3A0` | ≈ 7:1 sur carte — AA ; **ne jamais descendre sous ≈ `#8A8886`** (limite AA 4,5:1) |
| `accent/gold` | Or de marque (actions, progression, actif) | `#D9B45B` | ≈ 8:1 sur noir et sur carte — AA même en petit corps |
| `accent/gold-strong` | Or des boutons pleins (texte noir dessus) | `#E4C465` | Texte `#0E0E10` dessus ≈ 10:1 |
| `semantic/success` | Vert doux (scores élevés) | `#6FCF97` | ≈ 9:1 sur carte |
| `semantic/warning` | Orange (relations à raviver) | `#F2A65A` | ≈ 8:1 sur carte |
| `semantic/error` | Rouge discret (erreurs système uniquement) | `#E0655F` | ≈ 5:1 sur carte — AA texte courant |

**Typographie** : pas de police fantaisie sans nécessité — SF Pro (iOS) / Roboto (Android) en graisses 700-800 pour les « titres épais » suffisent au lancement et éliminent tout sujet de licence ; si une police de marque est retenue pour les titres, sa licence applicative doit être vérifiée. Échelle proposée : Display 28 pt / 800, Titre d'écran 22 pt / 700, Titre de carte 17 pt / 600, Corps 16 pt / 400, Secondaire 13 pt / 400, Légende 12 pt / 500 — **rien sous 12 pt**, et support obligatoire de l'agrandissement système (Dynamic Type / font scaling) jusqu'à au moins 130 %.

**Rayons et espacements** : rayons — cartes 20 pt, grandes cartes et feuilles 24 pt, champs 12 pt, pastilles/FAB/avatars pleins (cercle). Espacement sur base 4 pt (4 / 8 / 12 / 16 / 24 / 32), marges d'écran 20 pt, écart inter-cartes 12 pt. Zones tactiles minimales 44 × 44 pt.

**Composants** : spécifier les 17 composants de l'inventaire ci-dessus, chacun avec ses variantes et ses états (défaut, pressé, désactivé, chargement, vide, erreur). Trois consolidations s'imposent : une seule « barre de progression » paramétrable (score, cercle, XP), une seule « carte relation » avec variante alerte, un seul « + ».

Toujours en P0 :

- **Audit de contraste exhaustif** de toutes les paires texte/fond des maquettes après fixation de la palette, au seuil WCAG AA (4,5:1 texte courant, 3:1 texte large), avec correction des gris fautifs. Une demi-journée outillée, à refaire à chaque évolution de palette.
- **Bibliothèque d'icônes** remplaçant les émojis (voir point à trancher n° 4) : ~40 glyphes, style trait fin aligné sur le logo.
- **Maquetter les écrans critiques manquants** dans l'ordre d'importance produit : saisie d'interaction, onboarding complet (y compris ajout des 3 personnes et permissions), états vides de l'Accueil et des Souvenirs, paywall et écrans de limite atteinte, Paramètres avec suppression de compte. C'est le minimum sans lequel ni l'activation, ni la conversion, ni la validation par les stores ne sont couvertes.
- **Remplacer les photos de démonstration** par des visuels sous licence documentée et figer le jeu de données de démonstration canonique.

### P1 — Compléter la couverture avant le développement des écrans concernés

- **Matrice écrans × états** : pour chacun des ~35 écrans cibles, définir les états vide, chargement (squelettes dans la géométrie des cartes), erreur, hors-ligne. Les états vides des écrans émotionnels (Souvenirs, Ligne de vie) méritent un vrai travail éditorial : ce sont eux qui portent la promesse des cinq premières minutes.
- **Spécification motion et haptique** : durées (proposition : 150-200 ms pour les transitions courantes, 300-400 ms réservées aux moments émotionnels comme l'ouverture d'une capsule), courbes standard de la plateforme, inventaire des retours haptiques ; remplacer la consigne « transitions lentes » par « transitions rapides par défaut, lenteur réservée aux moments de célébration ».
- **Direction éditoriale bienveillante** pour la santé du cercle et les relations à raviver : reformulations, iconographie apaisée, état « relation en pause » sans pénalité visuelle.
- **Déclinaison Android** : passe de revue des ~35 écrans pour décider composant par composant ce qui est commun et ce qui suit la plateforme ; ajouter au moins trois maquettes de contrôle au gabarit Android.
- **Redondance non chromatique systématique** (libellés doublant chaque code couleur) et libellés d'accessibilité pour lecteurs d'écran intégrés à la spec de chaque composant.

### P2 — Après le lancement ou en parallèle sans bloquer

- **Préparation du thème clair** : uniquement via la discipline de tokens (aucune valeur en dur), sans production de maquettes claires avant que la demande soit avérée.
- **Kit de marque** : icône d'application, splash définitif, captures et visuels stores, gabarits de communication — dérivés du design system, pas improvisés.
- **Design des widgets** (fonctionnalité Premium promise) : quatre widgets annoncés (§ 24), zéro maquette ; à traiter avec la phase qui les livre.
- **Tests d'accessibilité outillés récurrents** (contraste, VoiceOver/TalkBack, agrandissement de police) intégrés à la checklist de recette de chaque version.

## Verdict

Pas prêt. La direction artistique est le meilleur actif visuel du projet — cohérente entre les trois sources, différenciante, déjà appliquée avec discipline sur 12 écrans — mais il n'existe aujourd'hui aucun système : pas une valeur figée, une iconographie émoji impubliable en l'état, aucun état système dessiné, et une couverture d'environ un tiers des écrans réels, concentrée sur la vitrine au détriment de la saisie, de la monétisation et de la conformité. Le chapitre fournit l'embryon de design system à arbitrer ; à condition de figer les tokens, de passer l'audit de contraste AA, de remplacer les émojis par une iconographie dédiée et de maquetter la vingtaine d'écrans critiques manquants, le « mois 1 : design complet » de la roadmap peut tenir sa promesse — sans ces prérequis, l'exigence « extrêmement premium » du prompt n° 1 restera un slogan.
