# Revue des décisions finales V1.1 — état du GO / NO GO

Les [Décisions finales V1.1](../decisions-finales-v1.1.md) répondent aux trois corrections prioritaires de la [revue de la V1.0](14-revue-de-la-specification-v1.0.md) : les paiements sont mis en conformité avec les règles des stores, le MVP est re-découpé en trois lots, et le document se termine par une checklist GO / NO GO à huit critères qui conditionne le début du développement. C'est la bonne discipline. Ce chapitre évalue chacun des huit critères à la date de la revue : **figé**, **partiellement figé** ou **non figé** — et identifie la décision encore absente du dossier.

## Ce que la V1.1 règle

* **Paiements (V-1, bloquant) : réglé.** StoreKit + Play Billing via RevenueCat pour le numérique ; Stripe et TWINT explicitement interdits pour les abonnements et réservés aux biens physiques futurs. Conforme à la recommandation, rien à ajouter.
* **Périmètre MVP (V-3) : réglé.** Le MVP V1 revient à la boucle de valeur : authentification, relations en CRUD complet (« créer, modifier, supprimer » — le C-seulement de l'ancienne spec est corrigé), interactions, souvenirs photos/notes/albums (vidéos et documents sortis), calendrier, notifications, Indice de présence, « En mémoire ». Capsules, Bucket List, statistiques avancées, badges, défis et widgets partent en V1.1 ; album PDF, partage familial et livre imprimé en V1.2. Ce découpage neutralise aussi la question des noms de badges (V-5), reportée avec eux.
* **Pondérations et affichage de l'Indice de présence (O-1, en partie) :** six variables pondérées (35/25/15/10/10/5, somme correcte de 100), quatre bandes d'affichage au vocabulaire bienveillant, lexique interdit (« toxique », « dangereuse »). C'est la moitié normative qui manquait.
* **Registre des notifications (O-3, en partie) :** exemples autorisés réécrits sans compteur de jours (« Cela fait quelque temps… » remplace « Cela fait trente jours… » — la faute éditoriale relevée en V-6 est corrigée), exemples interdits explicites.
* **Sauvegarde, export, récupération, suppression 100 % gratuits** avec la règle gravée « ne jamais bloquer l'accès aux souvenirs créés » — la recommandation la plus importante du chapitre 10 est désormais un principe fondateur.
* **Modèle de données allégé (V-7, en partie) :** `Videos`, `BucketLists` et `Statistics` retirées — les statistiques redeviennent un calcul dérivé comme le recommandait le chapitre 07.
* **KPI nettoyés (O-9) :** « temps passé » a disparu de la liste, remplacé par une hypothèse à valider explicitement hebdomadaire (« les utilisateurs reviennent-ils au moins une fois par semaine ? ») — cohérent avec l'unité WAU et la North Star du chapitre 13.

## État de la checklist GO / NO GO

| # | Critère | État | Ce qui manque |
|---|---|---|---|
| 1 | Paiements figés | ✅ **Figé** | Rien. |
| 2 | MVP figé | ✅ **Figé** (périmètre) | Rafraîchir la liste des écrans héritée de la V1.0 : Capsule temporelle et Bucket List en sortent, « Promesses » doit y entrer (fonctionnalité affichée au calendrier, table `Promises`, mais toujours aucun écran nommé). |
| 3 | Indice de présence figé | 🟡 **Partiel** | Les pondérations ne suffisent pas à coder : il manque la conversion de chaque variable en points — décroissance de « dernière interaction », définition mesurable de « régularité », cadence attendue par relation, score de départ d'une nouvelle relation, plancher de chute en cas de sous-saisie. Le chapitre 06 contient tout cela : le recalibrer sur les six pondérations officielles et l'annexer. Sans annexe, deux développeurs coderaient deux indices différents. |
| 4 | Notifications figées | 🟡 **Partiel** | Le ton est figé, pas la mécanique : plafond (recommandé : 1/jour, 4/semaine), ordre de priorité, heures calmes (21 h-9 h), opt-in progressif après la première valeur, snooze/pause par relation, mode discret sur écran verrouillé (chap. 08). |
| 5 | Modèle de données figé | 🟡 **Quasi** | La liste des 13 tables est cohérente avec le MVP, mais une liste de noms n'est pas un schéma : annexer champs, types et relations (chap. 07). À trancher aussi : les dates importantes méritent une table dédiée (le calendrier et la ligne de vie en dépendent) et il faut décider où vivent préférences et idées cadeaux (champs JSON de `Relationships` suffisent en V1). |
| 6 | Design system figé | 🟡 **Partiel** | La direction artistique et un premier token (coins 24 px) sont figés. Manquent : palette en valeurs hex, échelle typographique, grille d'espacement, iconographie dédiée en remplacement des émojis, états système (vide, chargement, erreur, hors-ligne) et cibles de contraste AA (chap. 05 fournit l'embryon complet à arbitrer). |
| 7 | Parcours utilisateur figé | ❌ **Non figé** | Rien n'est encore écrit sur : l'onboarding (nombre minimum de personnes, champs obligatoires, moment de la demande de permission notifications), l'arbre de navigation (comment atteint-on Calendrier, Promesses, « En mémoire » depuis les 5 onglets ?), les états vides du premier jour, et le hors-ligne d'abord — toujours absent alors que le chapitre 07 le classe P0 non rattrapable. |
| 8 | « Ajouter une interaction » conçue et validée | ❌ **Non validé** | La structure (8 champs) et le budget < 10 s sont figés — très bien — mais le critère dit « conçue **et validée** » : il faut la maquette du flux, un prototype cliquable et un test chronométré sur 5-10 personnes. Préciser d'abord quels champs sont obligatoires : avec 8 champs tous actifs, < 10 s est impossible ; recommandation : **type + personne(s) obligatoires, tout le reste facultatif et pré-rempli** (date = aujourd'hui), enrichissable après coup. |

**Bilan : 2 critères sur 8 pleinement acquis, 4 partiels, 2 non entamés.** Le NO GO reste donc en vigueur — conformément à la règle que la V1.1 s'est elle-même donnée — mais tout ce qui manque est un travail de complétion balisé (2 à 4 semaines de spécification et de design), pas de re-conception.

## La décision absente : le prix (proposition de « Décision 11 »)

La V1.1 ne traite pas la vigilance V-2, pourtant classée P0 : la grille tarifaire reste celle, incohérente, de la V1.0 (5,99 CHF/mois × 12 = 71,88 CHF contre 59,99 CHF/an, soit ~17 % de remise annuelle seulement). Et le re-découpage du MVP crée une question nouvelle : **que vend le Premium au lancement ?** Capsules, widgets, défis et statistiques avancées étant partis en V1.1, l'offre payante du jour 1 se réduit à « relations illimitées + photos illimitées » — c'est mince pour convertir, alors que « conversion Premium » figure dans les KPI de lancement.

Proposition de Décision 11 à prendre avant le GO :

1. **Tarifs :** 5,99 CHF/mois · **44,99 CHF/an** (~37 % de remise) · essai gratuit 14 jours · grille EUR équivalente préparée pour la phase France.
2. **Quotas gratuits :** 20 relations conservées si assumé, quota photos ramené de 500 à **200** (500 photos gratuites ≈ des années d'usage : le levier de conversion ne se déclencherait jamais, chap. 14 V-4).
3. **Contenu Premium au lancement :** relations et photos illimitées + **une fonctionnalité émotionnelle différenciante** remontée de V1.1 (recommandation : la capsule temporelle, petite à développer et forte en valeur perçue) ; à défaut, assumer un paywall discret en V1 et faire de la conversion un KPI de V1.1 seulement.
4. **Règle d'expiration** (déjà acquise en Décision 6, à recopier dans la page paywall) : à l'expiration de l'abonnement, tout ce qui a été créé reste accessible ; seule la création au-delà des quotas gratuits est limitée.

## Prochaines actions recommandées

1. **Prendre la Décision 11** (tarifs, quotas, contenu Premium du jour 1).
2. **Annexer les quatre spécifications prêtes** à la V1.1 : Indice de présence calculable (chap. 06 recalibré sur les pondérations officielles), politique de notifications (chap. 08), schéma de données complet (chap. 07), exigence hors-ligne d'abord (chap. 07).
3. **Concevoir et tester « Ajouter une interaction »** : maquette, prototype, 5-10 tests chronométrés, critère de validation médiane < 10 s — c'est le dernier verrou du critère 8.
4. **Figer les tokens du design system** (chap. 05) puis maquetter les ~25-30 écrans du MVP V1, états vides compris.
5. **Lancer les chantiers juridiques en parallèle** (politique de confidentialité, CGU, avis nLPD/RGPD — chap. 09) : hors chemin critique du design, mais bloquants pour la revue des stores.

## Verdict

La V1.1 est un très bon document de gouvernance : elle corrige le point bloquant des paiements, ramène le MVP à la bonne taille, fige la moitié normative de l'Indice de présence et impose une discipline GO / NO GO saine. En l'état, le GO n'est pas encore atteignable — il manque une décision (le prix), quatre annexes techniques dont la matière existe déjà dans l'audit, et surtout la conception validée du geste central. Aucun de ces manques ne demande plus de quelques semaines. La cible réaliste : une V1.2 des décisions intégrant la Décision 11 et les annexes, puis un GO prononcé sur preuve — le test chronométré du flux « Ajouter une interaction ».
