# Chapitre 7 — Architecture technique

Ce chapitre audite la dimension technique du projet AMIORA. Le constat de départ tient en une phrase : **la spécification technique n'existe pratiquement pas**. Elle se résume à quatre lignes du prompt 1 (« Coûts techniques : très faibles. Pas d'IA obligatoire. Base de données légère. Stockage photos : principale dépense. ») et à la section 28 du prompt 2, qui aligne quatorze noms de tables sans un seul champ, sans une seule relation, sans un seul type. Aucune des trois sources ne mentionne de plateforme, de langage, de backend, d'API, de stratégie hors-ligne, de sécurité ou de conformité. Les maquettes, elles, ne portent aucune information technique (elles utilisent un gabarit iOS, heure « 9:41 », sans que le choix iOS/Android soit pour autant instruit).

Ce vide n'est pas rédhibitoire — le produit décrit est techniquement standard et ne comporte aucun verrou technologique — mais il rend la roadmap du prompt 1 (« Mois 2 : développement du MVP ») intenable et masque des décisions structurantes qui, si elles sont prises implicitement en cours de développement, coûteront très cher à corriger : l'architecture hors-ligne, le pipeline média, la planification des notifications et la livraison différée des capsules temporelles. Ce chapitre instruit ces décisions une à une et propose une architecture de référence complète, dimensionnée pour un développeur solo ou une très petite équipe visant iOS et Android.

## Constats — ce que la spécification fait bien

Même embryonnaire, la pensée technique des sources contient plusieurs intuitions justes qu'il faut créditer :

- **La lucidité sur le poste de coût principal.** Le prompt 1 identifie correctement le stockage des photos comme « principale dépense » et en fait même un risque explicite (« Le stockage photo doit être optimisé »). C'est exact : dans une application dont la promesse est « l'album de vie émotionnel », le média est le seul coût variable significatif, et il est **cumulatif** (la photothèque d'un utilisateur ne fait que croître d'année en année).
- **« Pas d'IA obligatoire » est une position saine et vérifiée.** Toutes les mécaniques décrites — score relationnel (fréquence des contacts, promesses tenues, souvenirs créés), seuils de « relations en danger », ligne de vie « automatique » (en réalité construite à partir des dates importantes saisies), rappels — sont des **règles déterministes** calculables sans aucun modèle d'apprentissage. C'est une excellente nouvelle pour les coûts, la prévisibilité du comportement et la confidentialité de données très intimes.
- **Une ébauche de modèle de données existe.** Les 14 tables du § 28 (Users, Relationships, Categories, Memories, Photos, Videos, Notes, Events, Promises, Activities, Statistics, Notifications, Subscriptions, Achievements) couvrent l'essentiel des domaines fonctionnels et prouvent que le porteur a réfléchi en entités, pas seulement en écrans. La liste est fausse et incomplète (voir plus bas), mais elle est corrigeable.
- **Le périmètre est technologiquement banal — au bon sens du terme.** Pas de temps réel multi-utilisateurs en V1 (le partage familial est en Phase 4), pas de messagerie, pas de flux social : une application mono-utilisateur de type CRUD + média + notifications. C'est exactement le périmètre qu'un solo peut livrer avec une stack cross-platform et un backend managé.
- **La conscience des obligations réglementaires affleure.** Le § 26 du prompt 2 liste « sauvegardes, sécurité, confidentialité, export données, suppression compte » dans les Paramètres. Rien n'est spécifié, mais les bons mots sont là.
- **La monétisation est globalement alignée sur la structure de coûts** : les postes coûteux (photos illimitées, sauvegardes, album annuel, « espace illimité » du Premium Plus à 11,99 CHF/mois) sont placés derrière l'abonnement, tandis que le gratuit est plafonné (10 relations, 100 photos), ce qui borne le coût des utilisateurs non payants.

## Faiblesses et manques

### 1. Aucun choix de stack, donc aucune base de chiffrage

Ni plateforme (natif iOS + natif Android ? cross-platform ?), ni langage, ni backend, ni hébergement ne sont évoqués. Or ce choix conditionne tout : le coût du MVP varie du simple au double entre une base de code unique et deux applications natives ; le design « noir premium, or élégant, animations fluides » exige un framework où l'interface sur mesure est peu coûteuse ; les widgets (fonction Premium annoncée) imposent du code natif quel que soit le choix. La roadmap « Mois 2 : développement du MVP » a été écrite sans cette réflexion — elle est, on le verra, sous-estimée d'un facteur cinq à huit.

### 2. Un modèle de données réduit à des noms, ambigu et lacunaire

La liste du § 28 souffre de trois défauts distincts :

- **Ambiguïté « Activities » vs « Events ».** Le prompt 2 décrit d'un côté un calendrier d'événements planifiés (§ 16 : anniversaires, sorties, promesses, vacances) et de l'autre un historique d'« interactions » passées (§ 10-11 : message, appel, sortie, cadeau) qui alimente le score (§ 19). La liste du § 28 contient « Events » et « Activities » sans dire lequel couvre quoi — et **la table la plus centrale du produit, Interactions, n'existe pas** alors que le score, l'historique, les « dernières interactions » de la fiche et les seuils de danger reposent entièrement sur elle.
- **Absences pures et simples.** Ne figurent dans aucune table : les **idées cadeaux** (§ 9 : liste, prix, liens, notes), les **dates importantes** (§ 9 : première rencontre, mariage, diplôme…), les **préférences** (§ 9 : restaurants, fleurs, tailles, allergies…), les **défis et séries** (§ 21 et prompt 1 : séries 7/30/100 jours — la table « Achievements » ne couvre au mieux que les badges), les **capsules temporelles** (§ 22, pourtant fonctionnalité Premium vitrine), la **ligne de vie** (§ 14), les **appareils** de l'utilisateur (indispensables pour le push et le multi-appareil) et tout **journal d'audit** (indispensable pour le support et la conformité).
- **Découpages contestables.** « Photos », « Videos » et « Notes » comme tables séparées alors que l'écran Souvenirs les traite comme des types d'un même contenu (photos, vidéos, messages, notes, audio, documents — § 13) ; « Statistics » comme table stockée alors que toutes les statistiques du § 18 (214 appels, 47 sorties, 284 heures) sont des agrégats dérivables des interactions — les stocker comme données premières garantit des incohérences ; « Notifications » sans distinction entre règles de rappel, notifications planifiées et notifications envoyées.

### 3. Aucune doctrine hors-ligne, alors que le produit l'exige

C'est le manque le plus grave. Le cas d'usage nominal d'AMIORA est de **consigner un souvenir au moment où on le vit** : une randonnée en montagne, un voyage, un repas de famille à la cave — précisément les situations où le réseau est absent ou mauvais. Le prompt 2 cite lui-même « organiser une randonnée » (§ 15) et des voyages parmi les usages types. Une application qui affiche une roue de chargement au sommet d'une montagne trahit sa promesse au moment exact où elle devait la tenir. Rien, dans aucune source, ne parle de mode hors-ligne, de file d'attente d'écriture, de synchronisation ou de résolution de conflits. Si ce choix n'est pas fait avant la première ligne de code, l'application sera construite « online-first » et le rattrapage coûtera des mois.

### 4. Le pipeline média n'est pas conçu

« Stockage photos : principale dépense » est un constat, pas une conception. Manquent : la compression côté client (une photo d'iPhone sort à 3-6 Mo ; stockée telle quelle, elle décuple les coûts), la génération de miniatures (sans elles, la grille de l'écran Souvenirs téléchargera des dizaines de Mo à chaque ouverture), l'upload en tâche de fond avec reprise sur erreur (sinon l'utilisateur doit garder l'application ouverte), les quotas (la limite « 100 photos » du gratuit doit être appliquée côté serveur, pas seulement dans l'interface) et le sort des vidéos et documents (§ 13), qui pèsent dix à cent fois plus qu'une photo et ne sont l'objet d'aucune limite dans l'offre Premium « photos illimitées ».

### 5. Notifications : le lieu du calcul n'est pas tranché

Les notifications sont le moteur de rétention du produit (« Vous n'avez pas vu Thomas depuis 42 jours », « Anniversaire de Julie dans 3 jours »). Or elles supposent un **calcul quotidien** (recalcul des jours sans contact, détection des seuils, anniversaires à J-7 et J-3) et des **récurrences** (« appeler papa chaque semaine », § 15). Deux architectures sont possibles — planification locale sur l'appareil ou moteur serveur + push — et aucune source ne choisit. Le choix n'est pas anodin : iOS limite à 64 les notifications locales en attente, une notification locale n'est pas recalculée si l'utilisateur n'ouvre plus l'application (précisément le moment où AMIORA doit le rattraper), et les widgets comme le futur partage familial supposent de toute façon un serveur.

### 6. La capsule temporelle est incompatible avec une exécution locale

L'écran 10 des maquettes promet une livraison « dans 1 an → 5 mars 2027 » ou « dans 5 ans → 5 mars 2031 ». Aucun mécanisme local ne peut tenir cette promesse : d'ici cinq ans, l'utilisateur aura changé de téléphone, peut-être désinstallé puis réinstallé l'application ; une notification locale programmée à cinq ans est une fiction. Une capsule perdue n'est pas un bug ordinaire : c'est la trahison d'un message écrit « pour le futur », parfois adressé à un proche disparu entre-temps. La livraison différée est donc nécessairement un **travail serveur** (stockage durable, tâche planifiée, push + e-mail de secours), et rien de tout cela n'est spécifié. S'y ajoute une ambiguïté fonctionnelle : le déblocage « à un événement » (mariage, naissance) suppose que quelqu'un renseigne la date de l'événement — l'application ne peut pas la deviner.

### 7. Sécurité : silence complet sur des données très sensibles

AMIORA stockera des notes intimes sur le couple et la famille, des photos d'enfants, des adresses, des allergies, l'historique complet des relations d'une personne. C'est un des jeux de données les plus sensibles qu'une application grand public puisse détenir. Aucune source ne dit un mot du chiffrement (au repos, en transit), de la gestion des sessions et des jetons, de l'isolation des données entre utilisateurs, du verrouillage de l'application, ni des URL d'accès aux photos (publiques ? signées ?). Le mot « sécurité » apparaît une fois, comme intitulé de menu (§ 26).

### 8. Sauvegarde et export : une contradiction avec la promesse même du produit

Les deux prompts placent la « sauvegarde cloud » dans le **Premium**. Lu littéralement, cela signifie qu'un utilisateur gratuit qui casse ou perd son téléphone **perd l'histoire de ses relations** — exactement ce que la « définition du succès » du prompt 1 jure d'empêcher (« Je ne veux pas perdre cette application parce qu'elle contient l'histoire de mes relations »). Faire payer la survie des données est intenable commercialement (avis dévastateurs garantis au premier téléphone perdu) et fragile juridiquement. Par ailleurs, « export données » et « suppression compte » (§ 26) sont cités sans aucune spécification, alors que le RGPD (utilisateurs de l'UE) et la LPD suisse révisée, en vigueur depuis septembre 2023, en font des obligations : droit d'accès et de portabilité, droit à l'effacement, annonce des violations de données.

### 9. « Coûts très faibles » : vrai pour le variable, faux par omission

L'affirmation du prompt 1 doit être nuancée. Les coûts **variables** (stockage, bande passante, push) sont effectivement faibles — chiffrage plus bas. Mais le prompt ignore : les coûts **fixes** (compte développeur Apple ~99 USD/an, compte Google Play ~25 USD une fois, backend managé de l'ordre de 25 USD/mois dès qu'on sort des offres gratuites, outillage de crash/monitoring, domaine, e-mail transactionnel) ; la **commission des stores** de 15 à 30 % prélevée sur les 7,99 CHF/mois et 59,99 CHF/an, qui est de très loin le premier « coût technique » du projet ; et le **support utilisateur**, inévitable dès lors qu'on garde les souvenirs des gens (demandes de restauration, litiges d'abonnement, exports). « Très faibles » vaut pour l'infrastructure d'un petit volume d'utilisateurs ; ce n'est pas un business plan.

### 10. Effort de développement : la roadmap est irréaliste

« Mois 1 : design. Mois 2 : développement du MVP. Mois 3 : tests. Mois 4 : publication. » Le périmètre MVP de la Phase 1 du prompt 2 (connexion, relations, calendrier, souvenirs, notifications) représente à lui seul, hors-ligne et pipeline média compris, plusieurs mois de travail pour un développeur expérimenté ; le périmètre implicite des maquettes (score, niveaux, badges, promesses, capsule, statistiques) le double. L'estimation détaillée est donnée en recommandation R9 : **6 à 9 mois** de développement solo pour un MVP honnête, pas quatre semaines.

## Points à trancher

| # | Point | Termes de l'alternative | Décision recommandée | Justification |
|---|---|---|---|---|
| T-01 | Framework applicatif | Natif double (Swift + Kotlin) vs **Flutter** vs React Native | **Flutter** | Une seule base de code pour iOS+Android (le prompt 1 exige les deux au mois 4) ; rendu propriétaire garantissant un pixel-perfect identique sur les deux plateformes — décisif pour un design « extrêmement premium » entièrement sur mesure (noir/or, animations, effet verre) qui n'utilise presque rien des composants natifs ; écosystème hors-ligne mûr (SQLite via Drift, moteurs de sync). React Native est un second choix défendable si le développeur vient du monde JavaScript ; le natif double est exclu pour un solo (double effort, double maintenance). Inconvénients assumés de Flutter : widgets d'accueil et extensions à écrire en natif quand même, taille d'application supérieure. |
| T-02 | Backend | **Supabase (PostgreSQL managé)** vs Firebase vs backend maison | **Supabase** | Le domaine est intrinsèquement **relationnel** (relations → interactions → score ; promesses ; dates), ce que Postgres modélise naturellement là où Firestore (NoSQL) force des dénormalisations pénibles pour l'historique, les agrégats de statistiques et l'export RGPD ; Row Level Security pour l'isolation par utilisateur ; authentification Apple/Google/e-mail intégrée ; stockage objet avec transformations d'images ; fonctions Edge + tâches planifiées pour le score quotidien, les notifications et les capsules ; hébergement des données possible **dans l'UE** (argument LPD/RGPD) ; réversibilité (c'est du Postgres standard, exportable). Firebase garde l'avantage sur le push (FCM), que l'on utilisera de toute façon comme canal d'envoi, Supabase n'étant pas exclusif de FCM. Un backend maison est exclu à ce stade (coût, sécurité, délai). |
| T-03 | « Activities » vs « Events » (§ 28) | Deux tables floues | **Remplacer par le couple Interactions (passé) / Events (planifié)** | Une *interaction* est un fait passé (appel, message, sortie, visite, cadeau) horodaté qui alimente le score et l'historique ; un *event* est un élément de calendrier futur (sortie planifiée, rappel, anniversaire projeté). Un événement passé et confirmé génère une interaction. « Activities » disparaît. C'est le seul découpage qui rende calculables à la fois le calendrier (§ 16), l'historique (§ 11) et le score (§ 19). |
| T-04 | Photos / Videos / Notes en tables séparées | Trois tables vs table média unifiée | **Une table `memories` + une table `media_assets`** | L'écran Souvenirs traite photos, vidéos, notes, audio et documents comme des types d'un même flux (§ 13). Un souvenir (texte, date, relations liées) porte 0..n médias typés. Trois tables parallèles tripleraient le code de synchronisation et de quota pour rien. |
| T-05 | Table « Statistics » | Stocker les statistiques vs les calculer | **Calculer** (agrégats SQL, éventuellement matérialisés) | Toutes les valeurs du § 18 dérivent des interactions et des médias. Les stocker comme données premières crée une double vérité qui divergera (les maquettes en donnent déjà l'exemple : 43 sorties / 317 photos sur l'écran 9 contre 47 / 416 au § 18). |
| T-06 | Sauvegarde cloud réservée au Premium | Sauvegarde payante vs synchronisation de base gratuite | **Synchronisation et sauvegarde de base gratuites pour tous** ; le Premium différencie les **quotas** (photos illimitées vs 100, vidéo, « espace illimité » du Premium Plus) | La perte de données d'un utilisateur gratuit est inacceptable au regard de la promesse du produit (voir faiblesse n° 8) et le coût d'un compte gratuit plafonné à 100 photos est négligeable (~50 Mo). La frontière payante saine est le volume, pas la survie des données. |
| T-07 | Notifications locales vs serveur | Planification sur l'appareil vs moteur serveur + push | **Serveur maître, local en appoint** | Le calcul quotidien des seuils et anniversaires vit dans une tâche planifiée serveur qui envoie via APNs/FCM ; les notifications locales ne servent que de filet (rappels ponctuels créés hors-ligne, avant synchronisation). Justification en faiblesse n° 5 : limite iOS de 64 notifications locales, impossibilité de recalcul local si l'application n'est plus ouverte, cohérence multi-appareils. |
| T-08 | Capsule temporelle : où vit l'échéance ? | Appareil vs serveur | **Serveur, exclusivement**, avec push + e-mail de secours à l'échéance | Voir faiblesse n° 6 : une échéance à 5 ans ne survit ni au changement de téléphone ni à la désinstallation. L'e-mail de secours (adresse du compte) garantit la livraison même si l'application n'est plus installée. |
| T-09 | Où se calcule le score relationnel ? | Client vs serveur | **Serveur** (tâche quotidienne), snapshot répliqué localement pour l'affichage hors-ligne | Le score doit décroître **même quand l'application n'est pas ouverte** (c'est le principe des relations en danger) et déclencher les notifications ; seul un calcul serveur le permet. Préalable non technique : la formule elle-même n'existe pas (voir chapitre sur la cohérence des spécifications) et doit être écrite avant. |

## Recommandations

### R1 (P0) — Figer la stack de référence

Décision recommandée, ferme, pour un solo ou une équipe de deux :

- **Application : Flutter** (Dart), une base de code iOS + Android ; design system implémenté en widgets propriétaires (le chapitre Design fournit les tokens).
- **Base locale : SQLite** via Drift — **source de vérité de l'interface** (l'application lit et écrit toujours en local, jamais directement le réseau).
- **Backend : Supabase**, projet hébergé dans l'UE : Postgres + Row Level Security, Auth (Apple, Google, e-mail — conforme au § 6 du prompt 2), Storage pour les médias, fonctions Edge et tâches planifiées (score quotidien, notifications, capsules).
- **Synchronisation :** moteur dédié (par exemple PowerSync, conçu pour le couple SQLite/Postgres) ou file de synchronisation maison ; voir R3.
- **Push : FCM + APNs** (gratuits), déclenchés par le serveur.
- **Abonnements : RevenueCat** au-dessus de StoreKit/Play Billing — indispensable pour gérer proprement 7,99 CHF/mois, 59,99 CHF/an et le palier Premium Plus à 11,99 CHF/mois sur les deux stores, les restaurations d'achat et les webhooks d'état d'abonnement.
- **Qualité : Sentry** (crashs), CI GitHub Actions (tests + builds), distribution bêta TestFlight / Play Console pistes internes.

### R2 (P0) — Adopter le modèle de données de référence ci-dessous

Ce modèle corrige et complète la liste du § 28. Identifiants **UUID générés côté client** (condition de la création hors-ligne), horodatages `created_at`/`updated_at`/`deleted_at` (suppression logique, nécessaire à la synchronisation) sur toutes les tables.

| Entité | Champs principaux | Relations / remarques |
|---|---|---|
| `users` | id, e-mail, prénom, fournisseur d'auth, locale, fuseau horaire, statut d'abonnement (dénormalisé) | Fuseau horaire indispensable aux notifications « bonne heure ». |
| `devices` | id, user_id, plateforme, jeton push, dernière synchro | **Absente du § 28.** Push et multi-appareil. |
| `relationships` | id, user_id, prénom, nom, catégorie (enum : partenaire, famille, ami·e, enfant, mentor), photo (media_asset_id), téléphone, e-mail, date de naissance, adresse, métier, notes | La « personne » du produit. La table `Categories` du § 28 devient une énumération (liste fermée, cf. chapitre cohérence) ; conformément à l'arbitrage des chapitres 01 et 02, « professionnel » est retiré de la V1 — l'énumération reste extensible et son ajout ultérieur est trivial. |
| `preferences` | id, relationship_id, type (restaurant, fleur, taille, allergie…), valeur | **Absente du § 28** malgré le § 9. |
| `gift_ideas` | id, relationship_id, titre, prix, lien, note, statut (idée / offert), offert_le | **Absente du § 28** malgré le § 9 ; alimente l'action « 🎁 Cadeau » de la fiche. |
| `important_dates` | id, relationship_id, type (naissance, rencontre, mariage…), date, récurrence annuelle (bool) | **Absente du § 28** ; alimente calendrier, ligne de vie et rappels d'anniversaire. |
| `interactions` | id, relationship_id, type (appel, message, sortie, visite, voyage, cadeau), date, durée, note, event_id? | **La table centrale, absente du § 28.** Alimente score, historique, statistiques, seuils de danger. |
| `events` | id, user_id, relationship_id?, type, titre, date/heure, rappel, récurrence, statut (prévu / fait / annulé) | Calendrier (§ 16). Un événement « fait » génère une interaction. Remplace le flou Events/Activities. |
| `promises` | id, relationship_id, titre, échéance?, récurrence?, statut (à faire / terminée), terminée_le | « Appeler papa chaque semaine » impose le champ récurrence. |
| `memories` | id, user_id, relationships liées (n-n), titre, texte, date du souvenir, lieu?, épinglé ligne de vie (bool + type de jalon) | Fusionne Memories + Notes du § 28 ; la ligne de vie (§ 14) est une vue des souvenirs-jalons + dates importantes, pas une table. |
| `media_assets` | id, memory_id?, type (photo, vidéo, audio, document), chemin de stockage, taille, largeur/hauteur, miniature, hash, statut d'upload (en attente / envoyé / échec) | Fusionne Photos + Videos du § 28. Le statut d'upload est la clé du mode hors-ligne. |
| `time_capsules` | id, user_id, relationship_id?, contenu, créée_le, **échéance de livraison**, mode (date fixe / événement), statut (scellée / livrée), livrée_le, canal (push / e-mail) | **Absente du § 28** malgré le § 22 et l'écran 10. |
| `score_snapshots` | relationship_id, date, score 0-100, composantes du calcul | Historise le score (graphique « évolution » de l'écran 9). Remplace « Statistics » : tout le reste se calcule. |
| `badges` (référentiel) / `user_badges` | définition (code, seuil : Communicateur = 100 appels, Aventurier = 50 sorties…) ; obtention (user_id, relationship_id?, date) | Précise le vague « Achievements » du § 28. |
| `streaks` | user_id, type, compteur courant, record, dernière activité | **Absente du § 28** malgré les séries 7/30/100 jours du prompt 1. |
| `challenges` / `challenge_progress` | référentiel des défis hebdo/mensuels (§ 21) ; progression par utilisateur | **Absente du § 28.** |
| `xp_ledger` | user_id, relationship_id?, delta XP, motif, date | Journal additif ; « Niveau 47, 4 620 XP » se dérive, on ne stocke jamais un total modifiable. |
| `notification_rules` / `notification_log` | règles (type, seuils, heures calmes, activée) ; journal des envois (type, date, canal, ouverte?) | Remplace la table « Notifications » ambiguë ; le log permet le plafonnement anti-intrusion (« les rappels ne doivent pas être intrusifs », prompt 1). |
| `subscriptions` | user_id, palier (premium / premium plus), store, état, échéance, id RevenueCat | Conservée du § 28. |
| `exports` | user_id, type (RGPD, album PDF), statut, URL signée, expiration | Support de l'export § 26 et de l'album annuel § 23. |
| `audit_log` | user_id, action sensible (connexion, export, suppression, changement d'e-mail), date, appareil | **Absente du § 28.** Support et conformité. |

### R3 (P0) — Construire hors-ligne d'abord, la synchronisation comme fondation

À décider avant la première ligne de code, car ce n'est pas rattrapable :

1. **Lecture et écriture 100 % locales** (SQLite). L'utilisateur peut créer une relation, consigner un souvenir, cocher une promesse et consulter toute son histoire **sans aucun réseau**. Le réseau est un processus d'arrière-plan, jamais une condition de l'interface.
2. **File de synchronisation** : chaque mutation locale est journalisée puis poussée dès que le réseau revient ; les identifiants UUID client éliminent les collisions de création.
3. **Conflits** : les données sont mono-utilisateur, les conflits ne surviennent qu'entre appareils du même compte — la règle « dernière écriture gagne, par champ » suffit en V1 ; à réévaluer seulement pour le partage familial (Phase 4).
4. **Suppressions logiques** (`deleted_at`) pour que les suppressions se propagent entre appareils.
5. Les **agrégats serveur** (score, statistiques, badges) sont recalculés côté serveur puis répliqués localement en lecture : l'accueil affiche toujours quelque chose, même en avion.

### R4 (P0) — Concevoir le pipeline média et assumer son coût

- **Compression à la capture** : recadrage/redimensionnement à ~2048 px de bord long, JPEG/WebP qualité ~80 % → 300 à 500 Ko par photo (contre 3-6 Mo en sortie de capteur) ; génération locale d'une **miniature** (~30 Ko) affichée dans les grilles.
- **Upload en tâche de fond** (WorkManager côté Android, BGTaskScheduler côté iOS, encapsulés par Flutter) avec reprise sur échec et indicateur discret « en attente d'envoi » — cohérent avec le scénario montagne de R3.
- **Quotas appliqués côté serveur** (100 photos en gratuit) et **politique vidéo explicite** en Premium : durée maximale par clip ou quota de Go, sinon « photos illimitées » deviendra silencieusement « vidéos illimitées », seul scénario capable de ruiner la marge.
- **Ordre de grandeur des coûts**, en prenant l'utilisateur très actif du § 18 (416 photos/an) : 416 × ~0,45 Mo ≈ **0,2 Go par an**, en cumul (0,6 Go au bout de trois ans). Au tarif public courant de l'object storage (~0,02-0,03 USD/Go/mois), cela représente **de l'ordre de 0,05 à 0,20 CHF par an la première année**, et même un utilisateur pathologique à 10 Go (vidéos comprises) coûte ~2-4 CHF/an, bande passante comprise en ordre de grandeur. Rapporté à l'abonnement annuel de 59,99 CHF — soit ~51 CHF nets après commission store de 15 %, ~42 CHF après 30 % — **le coût variable média consomme quelques pourcents de la marge, pas davantage**, à condition que la compression et les quotas vidéo existent. L'intuition « coûts très faibles » est donc validée pour le variable ; les vrais postes sont les coûts fixes (backend ~300 USD/an, Apple 99 USD/an, outillage) et la commission des stores.

### R5 (P0) — Notifications planifiées côté serveur

Tâche planifiée quotidienne (par fuseau horaire, pour respecter le matin local) qui : recalcule les jours sans contact et les scores ; détecte anniversaires (J-7, J-3, J-0), échéances de promesses, seuils de « relation en danger » (une fois ces seuils enfin normés — les sources donnent 48/87, 34/72/119 et 32/96/61 jours, voir chapitre cohérence) ; applique les **heures calmes et un plafond d'envois par jour** (le prompt 1 en fait un risque explicite) ; envoie via FCM/APNs et journalise dans `notification_log`. Les notifications locales ne servent que de filet hors-ligne.

### R6 (P0) — Socle de sécurité et de conformité

- **Transit** : TLS partout, certificate pinning en option.
- **Repos** : chiffrement du stockage géré par le fournisseur (Postgres et object storage), base locale SQLite chiffrée (SQLCipher), jetons dans Keychain/Keystore.
- **Sessions** : jetons courts + refresh token révocable ; déconnexion à distance par appareil (table `devices`).
- **Isolation** : Row Level Security systématique — aucune requête ne peut lire les données d'un autre utilisateur, même en cas de bug applicatif.
- **Médias** : bucket privé + **URL signées à durée courte** ; jamais d'URL publique pour des photos de famille.
- **Verrouillage applicatif** optionnel (Face ID / empreinte) : attendu pour un journal intime relationnel.
- **Conformité RGPD / LPD révisée** : hébergement UE, registre des traitements, politique de confidentialité, export complet en libre-service (JSON + ZIP des médias, table `exports`), suppression de compte avec délai de grâce de 30 jours puis purge effective, procédure d'annonce des violations. À traiter comme une exigence de lancement, pas un « nice to have » : les formulaires de confidentialité de l'App Store et de Play exigent ces réponses dès la soumission.

### R7 (P1) — Sauvegarde, restauration, export

Appliquer T-06 : la synchronisation cloud de base (donc la survie des données) est **gratuite pour tous** ; la restauration se fait par simple reconnexion sur un nouvel appareil. Le Premium vend le volume (photos illimitées, vidéo, « espace illimité » Premium Plus) et les exports riches (album annuel PDF — généré **côté serveur**, un rendu PDF de centaines de photos n'ayant pas sa place sur le téléphone). Mettre à jour les prompts § 27 en conséquence.

### R8 (P1) — Capsule temporelle : implémentation serveur auditée

Appliquer T-08 : contenu stocké serveur, chiffré, échéance en base, tâche quotidienne de livraison, notification push **et** e-mail de secours, statut vérifiable par l'utilisateur (« scellée jusqu'au 5 mars 2027 »). Ajouter les règles produit manquantes : une capsule est-elle modifiable/supprimable avant terme ? Que se passe-t-il si le compte est supprimé avant l'échéance ? (Recommandation : suppression du compte = suppression des capsules, annoncée explicitement au moment de la suppression.)

### R9 (P1) — Re-planifier avec une estimation d'effort réaliste

Estimation pour **un développeur Flutter expérimenté à plein temps**, une fois les arbitrages de spécification rendus (formule de score, seuils, navigation — préalables non techniques) :

| Module | Contenu | Effort |
|---|---|---|
| Socle | Projet Flutter, design system, CI, environnements | 3-4 sem. |
| Comptes | Auth Apple/Google/e-mail, profil, appareils | 2 sem. |
| Relations | CRUD personne, fiche, catégories, préférences, cadeaux, dates importantes | 3-4 sem. |
| Hors-ligne + sync | SQLite, file de mutations, réplication (2-3 sem. si moteur type PowerSync, 4-6 sem. si maison) | 3-6 sem. |
| Souvenirs + média | Capture, compression, upload arrière-plan, miniatures, galerie, quotas | 4-5 sem. |
| Calendrier | Événements, récurrences, vues jour/semaine/mois, lien interactions | 2-3 sem. |
| Interactions + historique | Journalisation, écran historique, « dernières interactions » | 2 sem. |
| Promesses | Listes, récurrence, échéances | 1-2 sem. |
| Score + relations en danger | Tâche serveur, snapshots, écran alertes | 2 sem. |
| Gamification | XP, niveaux, badges, séries, défis | 2-3 sem. |
| Notifications | Moteur serveur, push, préférences, plafonds | 2-3 sem. |
| Monétisation | RevenueCat, paywall, quotas gratuit/Premium | 2 sem. |
| Paramètres + RGPD | Export, suppression, confidentialité, langues | 2 sem. |
| Capsule temporelle | Écrans + job serveur + e-mail | 1-2 sem. |
| Stabilisation | QA, bêta, corrections, fiches stores, soumission | 3-4 sem. |
| **Total MVP** | | **≈ 34-46 semaines, soit 6 à 9 mois** |

L'album annuel PDF (3-4 sem., serveur) et les widgets (2-3 sem., natif par plateforme) sont à placer **après** le lancement, conformément d'ailleurs à la Phase 3 du prompt 2. La roadmap « quatre mois tout compris » du prompt 1 doit être officiellement abandonnée.

### R10 (P2) — Industrialisation

Observabilité (Sentry, alertes sur la tâche de score et la file d'upload), sauvegardes de la base avec restauration testée, tests automatisés sur le moteur de sync et le calcul de score (les deux zones à bugs coûteux), revue annuelle des coûts de stockage, et préparation de l'architecture de partage familial (Phase 4) sans la construire : le choix Postgres + RLS la rend possible plus tard sans refonte.

## Verdict

**Pas prêt.** Sur le plan technique, AMIORA n'est pas un produit sous-spécifié : c'est un produit non spécifié — quatre lignes de coûts et quatorze noms de tables, dont manquent précisément les entités centrales (interactions, capsules, défis, idées cadeaux, dates importantes). Rien n'est pour autant hors de portée : le périmètre est standard, « pas d'IA obligatoire » est exact, et les coûts variables sont réellement faibles si le pipeline média est conçu dès le départ. Le chemin est clair : figer la stack (Flutter + Supabase), adopter le modèle de données de référence, construire hors-ligne d'abord, basculer notifications et capsules côté serveur, et re-planifier sur 6 à 9 mois de développement au lieu des quatre semaines annoncées. À ces conditions — et après l'arbitrage préalable des règles produit (score, seuils, navigation) —, un solo compétent peut livrer un MVP vendable ; sans elles, le développement produira une application en ligne seulement, muette hors réseau et incapable de tenir ses deux promesses les plus fortes : ne jamais perdre les souvenirs, et livrer un message cinq ans plus tard.
