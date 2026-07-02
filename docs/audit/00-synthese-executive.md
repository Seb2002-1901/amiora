# Synthèse exécutive — Audit produit AMIORA

> **Ce qui a été audité.** Deux documents de spécification (le « prompt 1 » : vision, MVP et business model ; le « prompt 2 » : spécification détaillée en 31 sections) et une planche de 12 maquettes haute fidélité. **Aucun code n'existe à ce jour** : le dépôt était vide au début de l'audit. La question du mandat — « que manque-t-il pour un produit fini, utilisable et vendable ? » — est donc traitée comme un audit de la spécification et du chemin qui reste à parcourir, pas comme un audit d'application.
>
> **Date de l'audit :** 2 juillet 2026. **Périmètre :** 13 chapitres couvrant vision, cohérence des sources, périmètre fonctionnel, UX, design, score relationnel, architecture technique, notifications, conformité, monétisation, risques, roadmap et KPI.

## Verdict global

La vision est forte, le problème visé est réel et remarquablement formulé, et les maquettes sont prometteuses — la direction artistique noir/or est un véritable actif. Mais l'écart entre ces documents et un produit livrable est important : les trois sources se contredisent sur 32 points, le geste central du produit (consigner une interaction) n'est spécifié nulle part, et rien n'existe côté technique, juridique ou commercial.

| Adjectif du mandat | État actuel | Ce qui manque | Condition de bascule |
|---|---|---|---|
| **FINI** | **2/10** — vision mûre, 12 maquettes de qualité, mais zéro ligne de code et une spécification sans document de référence (32 divergences entre les trois sources, mécaniques centrales sans définition normative). | La spécification de référence v1.0, ~20-28 écrans supplémentaires (états vides, saisie, édition, paramètres, paywall), 6 à 9 mois de développement, une bêta fermée. | Tous les écrans livrés y compris états vides et erreurs, CRUD complet, suppression de compte et export fonctionnels, crash-free > 99,5 %. |
| **UTILISABLE** | **3/10** — les parcours de consultation sont bien pensés, mais tout le système (score, statistiques, alertes) repose sur une saisie manuelle dont ni l'écran, ni le flux, ni le modèle de données n'existent ; onboarding trop lourd ; cas sensibles (décès, rupture) absents ; accessibilité jamais mentionnée. | Le flux « Enregistrer une interaction » en 2 taps, un score tolérant à la sous-saisie, les statuts « En pause / En mémoire », les états vides, l'import des contacts, le mode hors-ligne. | Boucle quotidienne < 30 s, saisie d'une interaction < 10 s, fonctionnement hors-ligne, accessibilité de base (contrastes AA, VoiceOver/TalkBack), support et FAQ en place. |
| **VENDABLE** | **2/10** — les prix existent (7,99 CHF/mois, 59,99 CHF/an) et l'économie unitaire est saine, mais la grille est contradictoire entre les sources, aucun écran de paywall n'est maquetté, aucun document légal n'existe, et plusieurs exigences des stores sont éliminatoires en l'état (politique de confidentialité, suppression de compte, privacy labels). | Grille tarifaire unique, paywall spécifié et testé, CGU et politique de confidentialité, avis juridique nLPD/RGPD (données de tiers, allergies = donnée de santé), fiches stores, processus de remboursement. | Achats in-app testés de bout en bout avec règle d'expiration écrite (« on ne confisque jamais ce qui a été créé »), documents légaux publiés, revue des stores passée. |

**En une phrase :** le projet est sain sur le fond et réalisable par une petite équipe, mais il est aujourd'hui au stade « concept documenté », pas « produit » — et le calendrier de 4 mois du prompt 1 est irréaliste d'un facteur trois ; un lancement soft crédible en Suisse romande se situe en **avril 2027**.

## Les 5 décisions à prendre maintenant

1. **Figer une spécification de référence v1.0** (chapitre 02). Les trois sources se contredisent sur 32 points numérotés D-01 à D-32, tous instruits et tranchés dans l'audit : navigation officielle (Accueil / Relations / + / Souvenirs / Profil), 6 catégories, seuils, nomenclature des badges, jeu de données de démonstration canonique. Une à deux semaines d'arbitrage éditorial suffisent ; sans cela, tout développement produira des choix implicites et contradictoires.
2. **Resserrer le MVP à la boucle de valeur minimale et spécifier le geste de saisie** (chapitres 03 et 04). Le « MVP » annoncé représente 6 à 9 mois de travail, pas un. Le premier lot doit être : compte, fiche courte à 7 champs, import des contacts, **saisie d'interaction en 2 taps** (le manque n° 1 de tout le dossier), rappels anniversaires et reprise de contact, archivage, CRUD complet. Score, gamification et médias lourds passent en v1.1-v1.3.
3. **Adopter la formule du score et ses garde-fous éthiques** (chapitre 06). Le score 0-100 est la promesse centrale et n'a ni formule, ni pondération, ni décroissance ; l'audit en propose une, calibrée pour reproduire les valeurs des maquettes (Emma 94, Papa 67, Thomas 38). Garde-fous non négociables : score unilatéral et strictement privé, jamais de classement, masquable, démarrage neutre, statuts « En pause / En mémoire » qui gèlent score et rappels.
4. **Garantir la sauvegarde et l'export à tous, gratuitement** (chapitres 07, 09 et 10). La « sauvegarde cloud » classée Premium signifie qu'un utilisateur gratuit qui perd son téléphone perd tout — l'exact inverse de la promesse « mémoire de tes relations ». Règle à graver : la synchronisation des données et l'export complet sont gratuits ; le Premium vend le volume (photos illimitées, capsules, album) ; **on ne reprend jamais ce qui a été créé**, on limite seulement la création.
5. **Simplifier la grille tarifaire de lancement** (chapitre 10). Un seul palier payant au lancement : Premium à **5,99 CHF/mois / 44,99 CHF/an** avec essai gratuit de 14 jours et prix fondateur (7,99/59,99 est le sommet du marché lifestyle pour un produit inconnu), grille EUR localisée pour la francophonie, Premium Plus (11,99 CHF) supprimé du lancement. Recalculer toute projection en net après commission stores de 15-30 %.

## Les 5 risques majeurs

1. **Churn par charge de saisie manuelle** (probabilité élevée × impact critique). Les statistiques de démonstration (214 appels, 43 sorties, 63 souvenirs par an) exigent près d'un acte de saisie par jour, demandé à une cible décrite comme manquant de temps — et la détection automatique des appels est impossible sur iOS. Sans saisie en 2 taps, revue hebdomadaire guidée et score tolérant à la sous-saisie, les compteurs deviennent faux, puis accusateurs, puis motif de désinstallation.
2. **Perte de données** — mortelle pour un produit dont la promesse est d'être une mémoire. Aggravée par la spec elle-même (sauvegarde en Premium) ; mitigation : synchronisation universelle gratuite, architecture hors-ligne d'abord, suppressions logiques, purge différée à 30 jours.
3. **Roadmap irréaliste → burn et abandon.** Quatre mois annoncés pour un périmètre chiffré à 17-23 personnes-mois : l'ancre des « 4 mois » doit être officiellement abandonnée auprès de toutes les parties prenantes.
4. **Fuite de données intimes = fin de la marque.** L'application stocke des données personnelles de tiers non consentants, dont une donnée de santé (allergies), des notes intimes et des photos. Chiffrement dès la V1, verrouillage biométrique, hébergement CH/UE avec DPA, avis juridique nLPD/RGPD avant lancement.
5. **Usage malveillant et risque réputationnel.** Fichage d'un ex, contrôle coercitif dans le couple, gamification moquable (« noter grand-maman 58 % ») et notifications culpabilisantes (« 96 jours sans voir Thomas »). Revue d'abusabilité en P0, registre éditorial bienveillant (« relation à nourrir », jamais « en danger » ; invitation orientée futur, jamais compteur-reproche en push), bannir le terme interne « système addictif ».

## Forces du projet

- **Un problème réel, universel et bien formulé** : la négligence des proches par manque d'attention quotidienne, avec une définition du succès orientée rétention qui est un vrai actif stratégique.
- **Un anti-positionnement net** (ni réseau social, ni messagerie, ni carnet de contacts) sur un créneau émotionnel/familial peu occupé — les personal CRM existants visent le réseautage professionnel.
- **Une direction artistique cohérente et disciplinée** : le noir/anthracite/or est appliqué sans exception sur les 12 maquettes ; 17 composants récurrents forment déjà la matière première d'un design system.
- **Un business model plausible** : freemium par abonnement, marge variable > 80 %, coûts variables réellement faibles si le pipeline média est bien conçu.
- **Un périmètre techniquement standard**, sans IA nécessaire, réalisable par un développeur solo compétent avec une stack managée (recommandation : Flutter + Supabase).

## Chemin recommandé

La roadmap détaillée (chapitre 12) part de juillet 2026 pour une équipe de 1-2 développeurs et un designer à temps partiel :

1. **Juillet 2026 — figer la spécification de référence v1.0** (les 32 arbitrages du chapitre 02) et lancer immédiatement les deux chantiers hors chemin critique mais bloquants : le juridique (politique de confidentialité, CGU, avis nLPD/RGPD) et le recrutement des bêta-testeurs.
2. **Août-septembre 2026 — design system et maquettes complètes** : tokens figés (palette, typographie, grille 4 pt), iconographie dédiée remplaçant les émojis, 30-40 écrans dont les états vides et le flux de saisie.
3. **Octobre-novembre 2026 — développement du MVP resserré**, hors-ligne d'abord, télémétrie instrumentée dès le premier build.
4. **Décembre 2026-février 2027 — bêta fermée** (50-200 testeurs) avec critères de sortie chiffrés : rétention J7 ≥ 30 %, ≥ 60 % des testeurs consignant ≥ 3 interactions/semaine, saisie médiane < 10 s, crash-free > 99,5 %.
5. **Janvier-mars 2027 — conformité et monétisation en parallèle** : paywall, achats in-app, documents légaux, fiches stores.
6. **Avril 2027 — lancement soft en Suisse romande**, puis itérations v1.1-v1.3 (score, gamification, Premium complet) jusqu'à l'automne, extension zone euro décidée fin 2027 sur données.

Effort total estimé : **17-23 personnes-mois**. La publication est déclenchée par la complétion des trois listes FINI / UTILISABLE / VENDABLE, pas par une date.

## Table des matières de l'audit

| Chapitre | Contenu |
|---|---|
| [01 — Vision et positionnement](01-vision-et-positionnement.md) | Vision, cibles et concurrence ; recommande un segment tête de pont (proches éloignés) et la validation terrain des deux hypothèses vitales avant toute ligne de code. |
| [02 — Cohérence des spécifications](02-coherence-des-specifications.md) | Le pivot de l'audit : 32 divergences entre les trois sources (D-01 à D-32), toutes instruites et tranchées, et la spécification de référence v1.0 à figer. |
| [03 — Périmètre fonctionnel et MVP](03-perimetre-fonctionnel-mvp.md) | Inventaire complet des fonctionnalités, démonstration que le « MVP » est un produit de troisième version, et re-découpage MoSCoW autour de la boucle de valeur minimale. |
| [04 — UX et parcours utilisateur](04-ux-parcours-utilisateur.md) | Le risque UX n° 1 (saisie manuelle sans écran spécifié), l'onboarding, le ton des notifications, les cas sensibles (décès, rupture), les états vides et l'accessibilité. |
| [05 — Design et système visuel](05-design-system.md) | Embryon de design system (tokens, 17 composants), audit de contraste WCAG, remplacement de l'iconographie émoji et liste des ~20-28 écrans manquants. |
| [06 — Score relationnel et gamification](06-score-relationnel-et-gamification.md) | Spécification complète et implémentable du score (décroissance exponentielle, cadences par relation), niveaux/XP, badges unifiés et garde-fous éthiques. |
| [07 — Architecture technique](07-architecture-technique.md) | Stack recommandée (Flutter + Supabase), modèle de données de référence corrigé, hors-ligne d'abord, pipeline média, notifications et capsules côté serveur, estimation d'effort. |
| [08 — Notifications et engagement](08-notifications-et-engagement.md) | Politique complète (budget, priorités, heures calmes, opt-in progressif), réécriture bienveillante de tous les exemples, séries hebdomadaires et widgets. |
| [09 — Confidentialité, sécurité et conformité](09-confidentialite-securite-conformite.md) | Données de tiers non consentants, allergies = donnée de santé, nLPD/RGPD, exigences éliminatoires des stores, décès et héritage numérique, six prérequis P0 au lancement. |
| [10 — Business model et monétisation](10-business-model-et-monetisation.md) | Grille unique recommandée, règle « on ne confisque jamais », prix d'entrée abaissé avec essai gratuit, unit economics nets après commissions et album imprimé en achat unique. |
| [11 — Registre des risques](11-risques-et-mitigations.md) | 20 risques qualifiés (probabilité × impact × mitigation) en 6 domaines, top 5 et plan de réduction séquencé en 5 phases. |
| [12 — Roadmap vers le lancement](12-roadmap-vers-le-lancement.md) | Definitions of done opposables des trois adjectifs du mandat et roadmap datée (spec figée juillet 2026 → lancement soft avril 2027, 17-23 personnes-mois). |
| [13 — KPI et mesure du succès](13-kpi-et-mesure-du-succes.md) | North Star « interactions réelles consignées par semaine et par utilisateur actif », arbre AARRR, instrumentation privacy-first et cibles go/no-go de bêta ; « temps passé » reclassé en anti-objectif. |
