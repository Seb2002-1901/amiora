# Revue de la Spécification de référence V1.0

La Spécification de référence V1.0 ([`docs/specification-de-reference-v1.0.md`](../specification-de-reference-v1.0.md)) a été publiée en réponse à l'audit du 2 juillet 2026. Elle constitue exactement le document que l'audit réclamait en décision n° 1 : une source unique, versionnée, qui prévaut sur les prompts 1 et 2 désormais archivés. Ce document en fait la revue : ce que la V1.0 résout, les points de vigilance qu'elle introduit, et ce qui reste ouvert avant de figer le cahier des charges de développement.

Le bilan d'ensemble est très positif : la V1.0 reprend la grande majorité des arbitrages structurants de l'audit, souvent mot pour mot dans l'esprit. Quatre points nouveaux méritent toutefois une correction rapide — dont un bloquant (les moyens de paiement) — et une dizaine de sujets restent à spécifier avant développement.

## Ce que la V1.0 résout

| Recommandation de l'audit | Traitement dans la V1.0 | Statut |
|---|---|---|
| Créer une spécification de référence unique et versionnée (chap. 02) | Document « Version 1.0, statut : référence officielle » | ✅ Résolu |
| Spécifier le geste central de saisie (chap. 03, 04 — manque n° 1) | « L'application est construite autour d'une seule action : AJOUTER UNE INTERACTION », écran dédié n° 9, structure de l'interaction définie (type, date, durée, qualité, notes, photos, lieu, personnes) | ✅ Résolu sur le principe |
| Sauvegarde cloud gratuite pour tous (chap. 07, 09, 10) | « Sauvegarde cloud » au palier gratuit, « Sauvegarde gratuite pour tous » en section Confidentialité | ✅ Résolu |
| Export et suppression garantis (chap. 09) | « Export possible. Suppression définitive possible. » + suppression du compte dans l'authentification | ✅ Résolu |
| Retirer les données médicales (« allergies ») (chap. 09) | « Aucune donnée médicale. Aucune donnée sensible. » | ✅ Résolu |
| Score privé, unilatéral, jamais partagé, non-jugeant (chap. 06) | « Indice de présence », « jamais partagé », « ne juge pas la relation » | ✅ Résolu |
| Renommer « Relations en danger » (chap. 04, 06, 08) | Suppression explicite au profit de « Relation à entretenir », « Prenez des nouvelles » | ✅ Résolu |
| Ton des notifications bienveillant (chap. 08) | « Le ton doit toujours rester bienveillant. Jamais culpabilisant. » | ✅ Résolu sur le principe (voir vigilance V-6) |
| Statut mémoriel pour les personnes décédées (chap. 04, 09) | Fonction « En mémoire » complète (photos, souvenirs, chronologie, capsules) | ✅ Résolu |
| Stack Flutter + Supabase/PostgreSQL (chap. 07) | Reprise à l'identique, notifications Firebase | ✅ Résolu |
| Table `Interactions` manquante au modèle de données (chap. 07) | Présente dans les tables principales | ✅ Résolu |
| Prix mensuel abaissé (chap. 10) | Premium à 5,99 CHF/mois | ✅ Résolu (voir vigilance V-2 sur l'annuel) |
| Premium Plus supprimé du lancement (chap. 10) | Absent de la V1.0 | ✅ Résolu |
| Navigation officielle à 5 onglets (chap. 02, 05) | Accueil · Relations · Ajouter · Souvenirs · Profil | ✅ Résolu |
| Conformité nLPD/RGPD posée comme obligation (chap. 09) | « Conformité RGPD et nLPD suisse obligatoire » | ✅ Posé (les livrables restent à produire) |
| KPI centrés sur les interactions enregistrées (chap. 13) | « Interactions enregistrées » ajoutées aux KPI | ✅ Résolu (voir point ouvert O-9 sur « temps passé ») |
| Règle fondatrice anti-inflation fonctionnelle | Nouvelle section « Règle fondatrice » à 4 objectifs | ✅ Apport nouveau et bienvenu |

Deux ajouts de la V1.0 n'étaient pas dans l'audit et sont pertinents : la fonction « Souvenir du jour » (excellent levier de rétention passive, cohérent avec la mission) et la « Bucket List » (anticipée en V2 par les sources initiales). Leur coût de développement reste réel — voir V-3.

## Points de vigilance introduits par la V1.0

### V-1 (P0, bloquant) — Les moyens de paiement listés violent les règles des stores

La V1.0 liste « Stripe, Apple Pay, Google Pay, TWINT ». Or pour des **biens numériques** (abonnement Premium, capsules, exports PDF), Apple et Google **imposent leurs systèmes d'achat intégré** (StoreKit / Play Billing) avec commission de 15-30 % ; Stripe, Apple Pay « web » et TWINT y sont interdits pour ce type d'achat, et une application qui les proposerait serait rejetée en revue. Correction recommandée :

* **Abonnement Premium :** achats in-app natifs uniquement, via **RevenueCat** (déjà recommandé au chap. 07) qui unifie StoreKit et Play Billing.
* **Stripe / TWINT / Apple Pay / Google Pay :** réservés aux **biens physiques** vendus hors app (album annuel imprimé commandé depuis une page web, chap. 10) — seul cas où ils sont autorisés et pertinents.

### V-2 (P0) — La grille tarifaire est devenue incohérente

5,99 CHF/mois × 12 = 71,88 CHF, contre un annuel maintenu à 59,99 CHF : la remise annuelle tombe à ~17 % (elle était de ~37 % à 7,99/59,99). L'annuel — qui est le meilleur abonnement pour AMIORA (rétention, trésorerie) — n'est plus assez attractif. Deux options cohérentes : **(a) recommandée :** 5,99 CHF/mois et **44,99 CHF/an** (~37 % de remise, alignée sur le chap. 10) ; (b) conserver 59,99 CHF/an mais remonter le mensuel à 7,99 CHF. Il faut aussi réintroduire deux éléments absents de la V1.0 : l'**essai gratuit de 14 jours** et la **grille EUR** (indispensable dès la Phase 4 « Lancement France » de la roadmap V1.0).

### V-3 (P0) — Le périmètre du MVP regonfle

L'audit avait chiffré le MVP des sources à 6-9 mois et recommandé une « boucle de valeur minimale » (chap. 03). La V1.0 réintègre dans les écrans du MVP : **Capsule temporelle, Bucket List, En mémoire, Statistiques**, plus vidéos et documents dans les souvenirs — tout en adoptant par ailleurs une excellente « règle fondatrice » anti-inflation. Ces fonctions passent la règle fondatrice, mais pas le calendrier : à 18 écrans + gamification + calendrier multi-vues, on retombe sur ~8-10 mois de développement solo. Recommandation : conserver la V1.0 comme périmètre de la **v1.x publique**, mais découper explicitement le premier lot livrable (relations, interactions, rappels, souvenirs photos/notes, « En mémoire » simplifié) et placer Capsule temporelle, Bucket List, vidéos/documents et statistiques avancées dans les lots v1.1-v1.2. À défaut, re-dater la roadmap en conséquence — la V1.0 n'a d'ailleurs plus aucune date (voir O-8).

### V-4 (P1) — Le palier gratuit est devenu très généreux

20 relations + 500 photos + sauvegarde cloud gratuites : c'est le double des relations et cinq fois les photos du palier arbitré au chap. 02/10 (10 relations, 100 photos). Conséquences : (a) le coût de stockage des utilisateurs gratuits est multiplié, (b) le principal déclencheur de conversion (le quota de photos, lié à la valeur émotionnelle accumulée) ne sera atteint qu'après des années d'usage pour la plupart des utilisateurs. La sauvegarde gratuite est le bon choix et ne doit pas bouger ; en revanche, **150-200 photos gratuites** suffisent à tenir la promesse tout en gardant un levier de conversion réaliste. À trancher avec des données de bêta si besoin, mais 500 est un choix militant qu'il faut faire en connaissance de cause.

### V-5 (P1) — Badges : doublon et anglicisme résiduels

La liste « Communicateur · Voyageur · Explorateur · Souvenir Keeper · Toujours présent » réintroduit **deux badges pour le même fait générateur** (Voyageur et Explorateur récompensaient tous deux les voyages selon les sources — en garder un, ou différencier explicitement leurs critères), conserve l'anglicisme **« Souvenir Keeper »** (le chap. 06 recommandait « Gardien des souvenirs » pour un produit 100 % francophone au lancement), et ne définit **aucun seuil** (le chap. 06 propose un barème complet par catégorie). « Toujours présent » est un bon remplacement de « Fidèle/Fidélité » — son critère reste à définir (proposition : 1 an d'attention régulière sur une relation).

### V-6 (P2) — L'échelle de qualité d'une interaction est déséquilibrée

« Très mauvais / Moyen / Bien / Excellent » : quatre niveaux asymétriques (un seul négatif, extrême). Pour un produit qui s'interdit la culpabilisation, une échelle symétrique et douce est préférable — par exemple « Difficile / Correct / Bien / Excellent » — et le champ doit rester **facultatif** dans le flux de saisie rapide. Même remarque pour « Durée » : facultative, sinon la saisie en 2 taps (chap. 04) est impossible. À noter également : l'exemple de notification « Cela fait trente jours sans voir Thomas » conservé dans la V1.0 est précisément un compteur-reproche que la règle « jamais culpabilisant » de la même page interdit — remplacer par une invitation orientée futur (« Un appel à Thomas cette semaine ? », chap. 08).

### V-7 (P2) — Le modèle de données a perdu des tables en route

La liste V1.0 ajoute bien `Interactions` et `BucketLists`, mais omet des entités nécessaires à ses propres fonctionnalités : **`TimeCapsules`** (la capsule est pourtant écran MVP n° 16 et avantage Premium), **`ImportantDates`** (section « Dates importantes »), **`GiftIdeas`/`Preferences`** (section « Préférences »), `Devices`, `XpLedger`. Par ailleurs `Statistics` reste listée comme table alors que le chap. 07 recommande un calcul dérivé, et le trio `Photos`/`Videos`/`Notes` gagnerait à suivre le modèle unifié `memories` + `media_assets`. Reprendre le modèle de référence du chap. 07 comme annexe technique de la spécification.

## Points encore ouverts (à spécifier avant développement)

* **O-1 — La formule de l'Indice de présence.** La V1.0 liste six variables mais toujours aucune formule, pondération ni décroissance. La spécification complète du chap. 06 (décroissance exponentielle, cadence attendue par relation, démarrage neutre, tolérance à la sous-saisie) est prête à être annexée telle quelle.
* **O-2 — Les cadences et seuils de « Relation à entretenir ».** Le renommage est acté, mais les déclencheurs (à partir de quand propose-t-on de prendre des nouvelles ?) restent indéfinis. Recommandation du chap. 06 : fréquence cible par relation, alerte à 1,5×, notification à 2×.
* **O-3 — La politique de notifications.** Le ton est cadré, pas la mécanique : budget (1/jour, 4/semaine), priorités, heures calmes, opt-in progressif, snooze par relation (chap. 08).
* **O-4 — L'arbre de navigation.** Calendrier, Statistiques, Capsule, Bucket List, Promesses (fonctionnalité sans écran listé !) ne sont pas raccordés aux 5 onglets. L'écran « Promesses » doit être ajouté à la liste des écrans du MVP et chaque écran doit avoir un point d'entrée défini (chap. 02, D-01 à D-05).
* **O-5 — Le budget de performance de la saisie.** Graver l'exigence chiffrée : enregistrer une interaction en **2 taps et < 10 secondes**, seuls le type et la personne étant obligatoires (chap. 04).
* **O-6 — Le hors-ligne d'abord.** Absent de la V1.0 alors que le chap. 07 le classe P0 non rattrapable (souvenir consigné sans réseau, montagne, avion).
* **O-7 — Niveaux et XP.** Éléments confirmés (« niveaux, XP ») mais barème, courbe et plafonds anti-farming restent à reprendre du chap. 06.
* **O-8 — La roadmap n'a plus de dates ni de critères.** Les 5 phases sont justes mais non datées et sans critères de passage ; réintégrer le calendrier et les critères de sortie de bêta chiffrés du chap. 12 (rétention J7 ≥ 30 %, ≥ 3 interactions consignées/semaine pour 60 % des testeurs, crash-free > 99,5 %).
* **O-9 — « Temps passé » reste dans les KPI.** Le chap. 13 le classe anti-objectif : à reclasser en garde-fou (session courte et stable), la North Star étant « interactions réelles consignées par semaine et par utilisateur actif » — cohérente avec le KPI « interactions enregistrées » ajouté par la V1.0.
* **O-10 — Les livrables de conformité.** L'obligation nLPD/RGPD est posée ; restent à produire : politique de confidentialité, CGU, avis juridique sur les données de tiers, privacy labels, registre des traitements (chap. 09). « Aucune donnée sensible » est un objectif de collecte par design, pas un état de fait : les notes libres et photos resteront intimes et doivent être protégées comme telles (chiffrement, verrouillage biométrique).
* **O-11 — Accessibilité et états système.** Toujours aucune mention (contrastes AA, VoiceOver/TalkBack, états vides, hors-ligne, erreurs) — à intégrer au design system avant maquettage des ~30 écrans (chap. 05).

## Recommandations

1. **P0 — Corriger les paiements** (V-1) : IAP natifs via RevenueCat pour tout bien numérique ; Stripe/TWINT réservés au futur album imprimé vendu via le web.
2. **P0 — Rendre la grille tarifaire cohérente** (V-2) : 5,99 CHF/mois + 44,99 CHF/an + essai 14 jours + grille EUR, et publier la règle d'expiration (« on ne confisque jamais ce qui a été créé », chap. 10).
3. **P0 — Découper la V1.0 en lots livrables** (V-3) : premier lot = boucle de valeur minimale + « En mémoire » ; Capsule, Bucket List, vidéos, statistiques avancées en v1.1-v1.2 ; re-dater la roadmap (O-8).
4. **P1 — Annexer les spécifications techniques prêtes** : formule du score (O-1), cadences (O-2), politique de notifications (O-3), modèle de données complet (V-7), hors-ligne (O-6), budget de saisie (O-5).
5. **P1 — Nettoyer la gamification** (V-5) : un seul badge voyage, « Gardien des souvenirs », critères chiffrés, et ajuster le palier photos gratuit (V-4).
6. **P2 — Finitions éditoriales** (V-6) : échelle de qualité symétrique et facultative, purger l'exemple de notification à compteur, ajouter l'écran Promesses à la liste (O-4).

## Verdict

La V1.0 transforme l'essai : sur les cinq décisions que la synthèse exécutive demandait de prendre, quatre sont prises et bien prises (spécification de référence, geste de saisie au centre, sauvegarde et export pour tous, prix d'entrée abaissé et Premium Plus retiré) et la cinquième (le périmètre du premier lot) est à moitié acquise. Le document introduit en revanche un point bloquant à corriger avant tout développement — les moyens de paiement incompatibles avec les règles des stores — et deux incohérences économiques faciles à réparer (remise annuelle, générosité du palier gratuit). Avec ces corrections et l'annexion des spécifications déjà rédigées dans l'audit (score, notifications, modèle de données, hors-ligne), la V1.1 de ce document peut devenir le cahier des charges de développement définitif.
