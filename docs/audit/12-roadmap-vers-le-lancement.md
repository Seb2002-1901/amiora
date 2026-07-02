# Roadmap vers un produit fini, utilisable et vendable

Ce chapitre conclut l'audit en répondant frontalement à la question du mandat : que manque-t-il pour un produit **fini**, **utilisable** et **vendable** — et dans quel ordre, à quelle date, avec quels moyens ? Les sources proposent deux plans de route. Le prompt n° 1 avance un calendrier en quatre mois (« Mois 1 : design complet. Mois 2 : développement du MVP. Mois 3 : tests. Mois 4 : publication iOS et Android »). Le prompt n° 2 propose quatre phases fonctionnelles (phase 1 : connexion, relations, calendrier, souvenirs, notifications ; phase 2 : promesses, score, statistiques, défis, badges ; phase 3 : capsules, album annuel, widgets, Premium ; phase 4 : album physique, partage familial, événements collaboratifs) — mais sans aucune durée, aucune date, aucune ressource. Aucun des deux plans ne définit ce que signifient concrètement les trois adjectifs du mandat, ni ne mentionne la bêta, la conformité, les stores ou le support.

Ce chapitre confronte ces deux roadmaps, définit une « definition of done » opposable pour chacun des trois adjectifs, puis propose une roadmap datée à partir de juillet 2026, dimensionnée pour l'équipe réaliste du projet : un à deux développeurs et un designer à temps partiel. La conclusion tient en une phrase : le lancement en quatre mois est impossible, mais un lancement soft en Suisse romande en **avril 2027** est crédible, à condition de figer la spécification ce mois-ci et de traiter la conformité en parallèle du développement, pas après.

## Constats

Malgré leurs lacunes, les deux roadmaps sources contiennent des acquis qu'il faut conserver.

**Le séquencement du prompt n° 2 est directionnellement juste.** Placer en phase 1 le cœur (connexion, relations, calendrier, souvenirs, notifications) et repousser en phase 2 le score, les statistiques, les défis et les badges est exactement le bon réflexe : c'est la logique retenue par le chapitre 03 (MVP « boucle de valeur minimale »), qui la durcit encore. De même, reléguer en phase 4 le partage familial et les événements collaboratifs est cohérent avec l'analyse juridique du chapitre 09, qui identifie ces fonctions comme celles qui font sortir les données de tiers de la sphère privée et exigent une revue dédiée. Le squelette du prompt n° 2 peut donc servir d'armature à la roadmap consolidée — il lui manque « seulement » les dates, les moyens et les critères.

**Le prompt n° 1 a le mérite d'ordonner design → développement → tests → publication.** L'intention est saine : le design précède le code, les tests précèdent la publication. C'est le calibrage qui est faux, pas l'ordre.

**La matière première des critères de sortie existe déjà.** Les deux prompts listent des KPI exploitables : utilisateurs actifs quotidiens, relations créées, souvenirs ajoutés, rétention à 30 jours, conversion Premium (prompt n° 1) ; inscriptions, J1, J7, J30, conversion, rétention annuelle (prompt n° 2, § 29). Il suffit de transformer ces listes en seuils chiffrés et datés pour obtenir des jalons vérifiables — ce que fait ce chapitre.

**La « définition du succès » est une vraie étoile polaire.** Les deux prompts la formulent en termes de rétention émotionnelle (« Je ne peux plus supprimer AMIORA parce qu'elle contient une partie de mon histoire »). C'est une définition mesurable par procuration : rétention longue, volume de souvenirs accumulés, taux de réactivation. Elle justifie que la roadmap privilégie la solidité de la boucle quotidienne sur l'étendue du catalogue.

## Faiblesses et manques

### La roadmap du prompt n° 1 est irréaliste d'un facteur trois sur le calendrier et six sur le développement

Le chapitre 03 a chiffré le périmètre du « MVP » du prompt n° 1 (compte, relations, informations détaillées, historique, calendrier, journal multi-médias, ligne de vie, promesses, relations en danger, statistiques) à **six à neuf mois de développement**, contre le seul « Mois 2 » alloué. Le mois de design est tout aussi insuffisant : les 12 maquettes existantes couvrent « la vitrine, pas le magasin » (chapitre 03) ; un produit publiable exige trente à quarante écrans, en comptant l'authentification complète, la saisie d'interaction, les paramètres, le paywall, les états vides, les erreurs et les permissions. Enfin, le « Mois 3 : tests » ne définit ni testeurs, ni protocole, ni critères de réussite, et le « Mois 4 : publication iOS et Android » ignore les délais de revue des stores, la configuration des achats intégrés et l'exigence — bloquante — d'une politique de confidentialité publiée (chapitre 09). Ce calendrier n'est pas optimiste : il est inexécutable, et le suivre conduirait soit à l'explosion des délais, soit à l'effondrement de la qualité — fatal pour un produit dont le prompt n° 1 exige lui-même un design « extrêmement premium ».

### La roadmap du prompt n° 2 n'est pas une roadmap

Quatre phases sans durée, sans date, sans effectif et sans critère de passage ne constituent pas un plan mais une table des matières. Trois défauts structurels s'y ajoutent. Premièrement, les **notifications sont en phase 1 mais le score en phase 2**, alors que les alertes « relations en danger » (« 34 jours sans appel », § 17) reposent sur des seuils que personne n'a normés — le chapitre 02 a relevé trois jeux de seuils contradictoires entre les sources (48/87 jours au prompt n° 1 ; 34/72/119 au prompt n° 2 ; 32/96/61 sur les maquettes). Deuxièmement, le **Premium n'arrive qu'en phase 3** : le produit ne teste sa « vendabilité » qu'après deux phases entières, ce que le chapitre 10 identifie comme une faiblesse — aucune des 12 maquettes ne montre d'ailleurs un paywall. Troisièmement, aucune phase ne contient la bêta, la conformité, le support, la page web ou la préparation des fiches stores : tout ce qui sépare un logiciel d'un produit.

### Aucune source ne définit « fini », « utilisable » ni « vendable »

Le mandat lui-même (« produit fini, utilisable et vendable », titre du prompt n° 1) n'est décliné nulle part en critères vérifiables. Sans definition of done, la publication devient une décision d'humeur et chaque adjectif un slogan. Ce manque est comblé ci-dessous : les trois listes de contrôle proposées doivent devenir contractuelles — aucun jalon franchi tant que sa liste n'est pas verte.

### Les invisibles du chemin critique

Ni l'un ni l'autre plan ne budgète : la consolidation de la spécification (32 divergences à arbitrer, chapitre 02, estimée à une à deux semaines) ; l'avis juridique nLPD/RGPD et les documents contractuels (chapitre 09, P0 bloquant pour la revue des stores) ; le recrutement des bêta-testeurs (plusieurs semaines si l'on veut 50-200 personnes réellement actives) ; la configuration et le test des achats intégrés sur deux stores ; la mise en place de la télémétrie sans laquelle aucun critère de sortie n'est mesurable ; le support et le processus de remboursement. Chacun de ces postes est petit ; leur omission collective est ce qui transforme les « quatre mois » annoncés en douze mois subis.

## Definition of done : les trois adjectifs du mandat

### FINI — le produit est complet et stable

- **100 % des écrans du périmètre v1.0** (spécification de référence, chapitre 02) maquettés **et** implémentés, y compris états vides (première ouverture, aucune relation, aucun souvenir), états de chargement, écrans d'erreur, mode hors-ligne et permissions refusées (contacts, photos, notifications).
- **Onboarding complet** : les 4 écrans du prompt n° 2 (§ 6) + création de compte (Apple, Google, e-mail) + ajout guidé des premières personnes (minimum une, incitation contextuelle à trois — chapitre 04), avec possibilité de passer et de reprendre plus tard ; récupération de mot de passe fonctionnelle.
- **CRUD intégral** sur toutes les entités du MVP : création, édition, archivage et suppression d'une relation, d'une interaction, d'un événement, d'une promesse — pas seulement la création, seule montrée par les maquettes.
- **Suppression de compte dans l'application** (exigence des stores) et **export des données** (§ 26 du prompt n° 2, obligation de portabilité — chapitre 09), tous deux gratuits.
- **Crash-free sessions > 99,5 %** sur les 30 derniers jours de bêta, mesuré par télémétrie ; zéro bug bloquant ou critique ouvert ; dette connue documentée.
- **Textes finalisés et relus** en français (notifications, e-mails transactionnels, messages d'erreur) ; contenus de démonstration purgés (les maquettes sont figées sur « mars 2026 », observation n° 14).
- **Notifications réglables** (fréquence, plafond quotidien, désactivation par personne — chapitre 08) et testées sur iOS et Android.

### UTILISABLE — le produit rend service en moins d'une minute par jour

- **Boucle quotidienne < 30 secondes** : ouvrir l'application → voir qui recontacter et les échéances du jour → agir ou consigner. Mesurée en bêta, pas déclarée.
- **Saisie d'une interaction < 10 secondes et ≤ 2 gestes** depuis l'accueil — le geste central du produit, aujourd'hui spécifié nulle part (chapitre 03) ; temps médian mesuré par télémétrie.
- **Valeur en moins de cinq minutes** : la promesse explicite du prompt n° 1 (« En moins de cinq minutes, l'utilisateur obtient de la valeur ») validée par tests utilisateurs sur prototype, puis en bêta (taux de complétion de l'onboarding ≥ 70 %).
- **Fonctionnement hors-ligne** : consultation et saisie sans réseau, synchronisation au retour de connexion — indispensable pour une saisie « dans l'instant » (train, montagne, étranger).
- **Accessibilité de base** : contrastes vérifiés (le duo or-sur-noir et les textes gris sur anthracite sont à risque — chapitre 05), tailles de police dynamiques, parcours principal praticable au lecteur d'écran (VoiceOver/TalkBack), cibles tactiles suffisantes.
- **Rappels perçus comme aidants, pas culpabilisants** : formulation positive, plafond quotidien, réglages accessibles — condition posée par le prompt n° 1 lui-même (« Les rappels ne doivent pas être intrusifs »).
- **Support joignable** : FAQ intégrée, adresse de contact, délai de réponse annoncé (par exemple 2 jours ouvrés).

### VENDABLE — le produit peut encaisser de l'argent en toute légalité

- **Paywall implémenté et achats intégrés testés** (sandbox puis production) sur les deux stores : souscription mensuelle et annuelle, restauration d'achat, changement de palier, et surtout la **règle d'expiration** de l'abonnement écrite et implémentée (que devient la mémoire de l'utilisateur ? — chapitre 10, décision la plus importante du modèle).
- **Grille tarifaire validée** : prix de lancement recommandé au chapitre 10 (5,99 CHF/mois, 44,99 CHF/an, essai gratuit, prix fondateur) plutôt que les 7,99/59,99 CHF affichés sans preuve ; grille EUR définie avant toute communication hors de Suisse.
- **CGU/CGV et politique de confidentialité publiées**, liées depuis l'application et les fiches stores ; déclarations de confidentialité des stores remplies (étiquettes de confidentialité Apple, Data Safety Google) ; âge minimum affiché (chapitre 09).
- **Fiches stores complètes** : captures d'écran par gabarit, description, mots-clés, catégorie, classification d'âge, dans les deux stores.
- **Page web publique** : présentation, tarifs, mentions légales, politique de confidentialité, contact — également support de la liste d'attente bêta.
- **Processus de remboursement documenté** : les remboursements passent par Apple et Google, mais le support doit savoir orienter et consentir un geste commercial ; procédure écrite.
- **Mesure en place** : entonnoir d'acquisition, J1/J7/J30, conversion Premium, conformes au consentement recueilli.
- **Chaîne de mise à jour opérationnelle** : intégration continue, capacité à publier un correctif sur les deux stores en moins d'une semaine.

## Roadmap consolidée : juillet 2026 → avril 2027, puis itérations

Hypothèses de dimensionnement : 1 à 2 développeurs (idéalement 2 sur un framework multiplateforme — chapitre 07), 1 designer à temps partiel (~40-50 %), le porteur du projet en product owner, un avocat en prestation ponctuelle. Le périmètre est le **MVP resserré** du chapitre 03 (relations, saisie d'interaction en deux gestes, rappels d'anniversaires et de reprise de contact, paramètres complets), pas le catalogue du prompt n° 1.

| Jalon | Période | Livrable vérifiable | Critère de passage |
|---|---|---|---|
| **J0 — Spécification figée** | 6–24 juillet 2026 | Spécification de référence v1.0 (32 arbitrages du chapitre 02), matrice MoSCoW, spécification du geste de saisie d'interaction ; avis juridique commandé | Document signé par le porteur ; plus aucune source concurrente |
| **J1 — Design system et maquettes complètes** | mi-juillet – fin septembre 2026 | Design system (tokens, composants), 30-40 écrans y compris états vides, erreurs, paramètres, paywall ; prototype cliquable testé sur 5-8 utilisateurs romands | Boucle quotidienne < 30 s et onboarding < 5 min validés sur prototype |
| **J2 — MVP feature-complete** | août – fin novembre 2026 | Socle technique (août-sept.), puis écrans ; build interne complet, télémétrie active, dogfooding du porteur dès octobre | 100 % du périmètre v1.0 implémenté ; liste FINI aux deux tiers verte |
| **J3 — Bêta fermée** | décembre 2026 – février 2027 | TestFlight + piste fermée Play, **50-200 testeurs** romands recrutés dès l'automne via la liste d'attente ; 2-3 builds correctifs | Critères chiffrés ci-dessous, tous atteints |
| **J4 — Conformité et monétisation** | janvier – mars 2027 (en parallèle de J3) | Politique de confidentialité et CGU publiées, déclarations stores, hébergement CH/UE confirmé, achats intégrés testés, page web en ligne | Liste VENDABLE verte ; six P0 du chapitre 09 soldés |
| **J5 — Lancement soft Suisse romande** | **avril 2027** | v1.0 sur App Store et Google Play, visibilité volontairement limitée (communautés, presse locale), prix fondateur | 1 000–3 000 téléchargements en 8 semaines ; conversion et rétention mesurées |
| **J6 — Itérations** | mai – octobre 2027 | v1.1 : score relationnel simplifié et seuils calibrés sur données réelles (chapitre 06) ; v1.2 : gamification légère, souvenirs enrichis ; v1.3 : Premium étoffé (capsule, album annuel PDF) | Revue trimestrielle ; go/no-go extension zone euro fin 2027 (grille EUR, chapitre 10) |

**Critères de sortie de bêta (J3), chiffrés et mesurés par télémétrie :**

- **Rétention J7 ≥ 30 %** et J30 ≥ 15 % sur les cohortes de testeurs ;
- **Taux de saisie d'interactions** : ≥ 60 % des testeurs actifs d'une semaine consignent au moins 3 interactions dans la semaine ; temps médian de saisie < 10 s ;
- Complétion de l'onboarding (compte + 3 proches) ≥ 70 % ;
- Crash-free sessions > 99,5 % ; zéro bug critique ouvert ;
- Signal qualitatif : entretiens avec ≥ 15 testeurs ; une part substantielle (cible ≥ 40 %) se déclarant « très déçue » si l'application disparaissait.

Si un critère n'est pas atteint, la bêta est prolongée par cycles de quatre semaines — le lancement recule, il ne se force pas. Noter que la fenêtre de bêta couvre les fêtes de fin d'année : période à forte densité relationnelle (anniversaires, repas de famille, bonnes résolutions), c'est le meilleur banc d'essai possible pour ce produit.

### Effort et chemin critique

Estimation grossière en personnes-mois (PM), volontairement en fourchettes :

| Poste | Effort |
|---|---|
| Consolidation de la spécification (J0) | 0,5 PM |
| Design system, maquettes complètes, tests prototype (J1) | 2 – 3 PM |
| Socle technique + développement MVP (J2) | 8 – 12 PM |
| Bêta : corrections, animation des testeurs, télémétrie (J3) | 3 – 4 PM |
| Conformité, documents, stores — hors honoraires juridiques (J4) | 1 PM |
| Monétisation : paywall, achats intégrés, page web (J4) | 1 – 1,5 PM |
| Lancement soft : fiches stores, communication, support (J5) | 1 PM |
| **Total jusqu'au lancement soft** | **≈ 17 – 23 PM sur ~10 mois** |

S'y ajoutent des débours externes : honoraires juridiques (quelques milliers de francs, chapitre 09), comptes développeur, infrastructure, et un budget d'acquisition même modeste pour le lancement — poste identifié comme non financé au chapitre 10.

Le **chemin critique** est : spécification figée (J0) → spécification et design du geste de saisie + écrans cœur (J1) → développement du cœur (J2) → bêta et critères de sortie (J3) → lancement (J5). Deux chantiers sont hors de ce chemin mais **bloquants en fin de course** et doivent donc démarrer immédiatement en parallèle : le juridique (l'absence de politique de confidentialité suffit à faire échouer la revue des stores) et le recrutement des testeurs (sans 50-200 personnes prêtes en décembre, la bêta glisse d'autant). Le calendrier ci-dessus intègre environ 15 % de marge ; toute reprise du périmètre du prompt n° 1 (score, gamification, médias lourds dans le premier lot) la consomme instantanément et repousse le lancement au-delà de l'été 2027.

## Points à trancher

1. **Calendrier : 4 mois (prompt n° 1) vs phases sans durée (prompt n° 2).** Les deux sont inutilisables tels quels : l'un est inexécutable, l'autre n'engage à rien. **Recommandation ferme :** rejeter formellement le calendrier du prompt n° 1, conserver la logique de phases du prompt n° 2, et adopter la roadmap datée J0-J6 ci-dessus comme plan de référence unique, revu mensuellement.
2. **Contenu du premier lot : MVP du prompt n° 1 (avec score, promesses, statistiques, ligne de vie) vs phase 1 du prompt n° 2 (sans).** Maquettes ambiguës : elles montrent niveau, XP et badges partout. **Recommandation ferme :** phase 1 du prompt n° 2, durcie selon le chapitre 03 — le score et la gamification n'entrent qu'en v1.1/v1.2, calibrés sur les données de bêta et de lancement ; les maquettes sont corrigées en conséquence dès J1.
3. **Premium : phase 3 (prompt n° 2) vs nécessité de tester la vendabilité tôt.** **Recommandation ferme :** le paywall et un Premium volontairement réduit sont présents dès la v1.0 du lancement soft. Un produit ne devient pas « vendable » en repoussant la vente ; c'est le lancement soft qui doit mesurer la conversion, pas une phase 3 lointaine.
4. **Publication : « iOS et Android » simultanés au mois 4 (prompt n° 1), rien chez le prompt n° 2.** **Recommandation ferme :** développement multiplateforme (chapitre 07), bêta simultanée TestFlight + Play, lancement soft sur les deux stores — la cible familiale romande est répartie sur les deux systèmes et un produit « mémoire des relations » ne peut pas exclure la moitié d'un foyer. Si l'équipe se réduit à un seul développeur, publier iOS d'abord (Sign in with Apple obligatoire de toute façon) et Android à +6-8 semaines, en le disant publiquement.
5. **Marché de lancement : aucun n'est défini dans les sources (prix en CHF, cible implicitement francophone).** **Recommandation ferme :** lancement soft limité à la Suisse romande — marché du porteur, prix en CHF déjà cohérents, bassin suffisant pour valider rétention et conversion — puis décision zone euro fin 2027 sur données, avec grille EUR dédiée (chapitre 10).

## Recommandations

### P0 — à engager en juillet 2026, conditions de tout le reste

1. **Figer la spécification de référence v1.0 avant fin juillet** (jalon J0) : arbitrer les 32 divergences du chapitre 02, adopter la matrice MoSCoW du chapitre 03, spécifier intégralement la saisie d'interaction. Une à deux semaines d'effort ; tout ce qui suit en dépend.
2. **Adopter les trois definitions of done (FINI / UTILISABLE / VENDABLE) comme critères contractuels** de sortie de jalon. Aucune publication tant que les trois listes ne sont pas vertes ; toute exception est documentée et datée.
3. **Lancer immédiatement le chantier conformité** (chapitre 09) : avis juridique, politique de confidentialité, CGU, arbitrage hébergement. Hors chemin critique du développement mais bloquant pour la revue des stores — commencer en juillet, pas en janvier.
4. **Rejeter officiellement le calendrier en quatre mois** et communiquer la roadmap J0-J6 (lancement soft avril 2027) à toutes les parties prenantes, pour tuer l'ancre irréaliste avant qu'elle ne serve de référence à un budget ou à un investisseur.
5. **Instrumenter dès le premier build** : télémétrie de la rétention, du temps de saisie, de la complétion d'onboarding et du crash-free. Sans mesure, les critères de sortie de bêta sont décoratifs.

### P1 — pendant la construction (août 2026 – mars 2027)

6. **Ouvrir la liste d'attente bêta dès septembre 2026** (page web + réseau du porteur + communautés romandes) pour disposer de 50-200 testeurs actifs en décembre ; prévoir l'animation de la bêta (canal d'échange, questionnaires, entretiens).
7. **Implémenter le paywall et les achats intégrés pendant J2/J4**, avec la grille de lancement du chapitre 10 (5,99 CHF/mois, 44,99 CHF/an, essai gratuit, prix fondateur) et la règle d'expiration écrite noir sur blanc.
8. **Geler tout développement score/gamification jusqu'aux données de bêta** : les seuils « relations en danger » et la formule du score (chapitre 06) se calibrent sur des usages réels, pas sur les valeurs contradictoires des maquettes.
9. **Préparer le lancement soft comme un projet à part entière** : fiches stores, page web, FAQ, presse locale romande, budget d'acquisition modeste mais réel, procédure de support et de remboursement.

### P2 — après le lancement soft (mai 2027 et au-delà)

10. **Revue de lancement à +8 semaines (juin 2027)** : rétention, conversion, entonnoir ; décision go/no-go sur l'extension zone euro avec grille EUR localisée.
11. **Séquencer les itérations v1.1-v1.3** (score, gamification légère, Premium étoffé) sur données, en conservant la discipline des definitions of done à chaque version.
12. **Ne rouvrir les chantiers V2/V3** (partage famille, albums collaboratifs, coffre-fort) qu'après revue juridique dédiée (chapitre 09) et preuve de rétention à 6 mois — ce sont les fonctions les plus risquées juridiquement et les moins nécessaires à la promesse initiale.

## Verdict

**Pas prêt — mais planifiable.** Les deux roadmaps sources sont inutilisables en l'état : celle du prompt n° 1 sous-estime le calendrier d'un facteur trois et le développement d'un facteur six, celle du prompt n° 2 n'engage ni durées, ni moyens, ni critères, et aucune ne couvre la bêta, la conformité ou la mise en marché. En revanche, avec la spécification figée en juillet 2026, le MVP resserré du chapitre 03, une bêta fermée de 50-200 testeurs sortie sur critères chiffrés (rétention J7 ≥ 30 %, saisie < 10 s, crash-free > 99,5 %) et le chantier juridique mené en parallèle dès maintenant, un lancement soft en Suisse romande en avril 2027 est un objectif crédible pour 17 à 23 personnes-mois. La condition non négociable : traiter les trois listes FINI / UTILISABLE / VENDABLE comme le contrat de sortie — c'est leur complétion, et non une date, qui déclenche la publication.
