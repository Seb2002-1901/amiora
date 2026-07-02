# Revue du PRD V1.2 — validation du GO

Le [PRD Final V1.2](../prd-v1.2.md) se déclare « GO DÉVELOPPEMENT ». Ce chapitre confronte cette déclaration à la checklist GO / NO GO que le projet s'était donnée en V1.1 et que le [chapitre 15](15-revue-des-decisions-v1.1.md) avait évaluée à 2 critères figés sur 8. La réponse tient en une phrase : **le GO est désormais défendable comme GO de démarrage** — la V1.2 lève l'essentiel des réserves, dont les deux plus importantes (le geste central est spécifié de bout en bout, la tarification est tranchée) — à condition de traiter quatre reliquats pendant le sprint 0, avant de coder les modules concernés.

## Ce que la V1.2 lève

* **Le geste central est enfin complet.** Champs obligatoires réduits à **personne + type**, tout le reste facultatif, flux défini en 5 étapes (+ → personne → type → Enregistrer → confirmation), budget < 10 secondes maintenu. C'était la recommandation exacte du chapitre 15 ; il ne reste que la **validation** (test chronométré sur prototype).
* **La politique de notifications est figée pour l'essentiel.** Plafonds (2/jour, 6/semaine), heures silencieuses (22 h-8 h), registre bienveillant avec terminologie interdite. Les plafonds sont un peu plus généreux que la recommandation du chapitre 08 (1/jour, 4/semaine) mais restent dans l'épure ; à surveiller en bêta via le taux de désactivation.
* **La Décision 11 est prise — et par un pivot assumé :** plus aucun plan gratuit. Essai complet de 14 jours puis 5,99 CHF/mois ou **44,99 CHF/an** (la remise annuelle de ~37 % recommandée est adoptée). La règle « ne jamais bloquer l'accès aux souvenirs créés » est respectée par le **mode lecture seule** après expiration (consulter, exporter, supprimer). Voir l'analyse du pivot ci-dessous.
* **Le hors-ligne d'abord est acté** (dernier P0 technique en suspens) : création de relations, souvenirs et interactions sans réseau, synchronisation automatique et silencieuse au retour — conforme au chapitre 07.
* **La liste des écrans est rafraîchie et cohérente** : l'écran Promesses manquant est ajouté, Capsule temporelle et Bucket List sont sortis conformément au découpage V1.1, « Archiver » complète le cycle de vie des relations, la table `Preferences` rejoint le modèle de données.
* **Les KPI sont recalibrés sur le nouveau modèle** : essais démarrés, conversions après 14 jours, taux d'abonnement — l'entonnoir mesurable correspond enfin au modèle économique choisi.

## Le pivot stratégique : premium sans plan gratuit

C'est le changement le plus lourd de la V1.2, et il mérite d'être instruit honnêtement.

**Ce que le pivot résout.** Il répond d'un coup à la question laissée ouverte au chapitre 15 (« que vend le Premium au jour 1 ? » — réponse : tout), supprime le coût de stockage d'une base d'utilisateurs gratuits, met fin aux arbitrages de quotas (10/20 relations, 100/200/500 photos), et il est cohérent avec le positionnement affiché : premium, confidentiel, sans publicité — l'abonnement est le modèle qui n'a pas besoin de monétiser la donnée.

**Ce que le pivot coûte.** L'acquisition devient le point dur. Un essai avec engagement de paiement convertit bien ceux qui le démarrent (typiquement une nette majorité), mais réduit fortement le nombre de ceux qui le démarrent — surtout pour une marque inconnue sans canal d'acquisition financé. Et la valeur d'AMIORA est **cumulative** : le produit est le plus convaincant après des mois de souvenirs accumulés, or l'essai dure 14 jours. Tout repose donc sur deux surfaces : la fiche store et l'onboarding, qui deviennent des pages de vente autant que des écrans produit.

**Recommandations associées (à intégrer au sprint 0) :**

1. **Traiter le pivot comme une hypothèse à valider, pas un dogme.** La bêta privée — présente dans la roadmap V1.0 puis disparue des documents — doit être réintroduite avec deux métriques de décision : taux de démarrage d'essai (store → essai) et conversion essai → payant. Définir à l'avance le plan B mesuré (par ex. un palier gratuit étroit) si le haut de l'entonnoir s'effondre.
2. **Concevoir l'onboarding comme le « moment wow » fabriqué** : import des contacts, création des 3 premières fiches en 2 minutes, premier « Souvenir du jour » et Indice de présence visibles immédiatement — l'utilisateur doit percevoir la valeur cumulative avant de l'avoir accumulée.
3. **Corriger la formulation « carte bancaire obligatoire »** : via StoreKit et Play Billing, l'essai engage le moyen de paiement du compte Apple/Google (offre de lancement standard) — aucune carte n'est saisie dans l'app. La mécanique voulue est la bonne ; le PRD doit employer les termes des stores pour éviter toute confusion en revue.
4. **Chiffrer le coût du mode lecture seule** : les comptes expirés conservent leur stockage à vie gratuitement — c'est le bon choix produit, mais il faut une politique de coût (compression, archivage froid après N mois d'inactivité).

## État final de la checklist GO / NO GO

| # | Critère | Ch. 15 | V1.2 | Reste à faire |
|---|---|---|---|---|
| 1 | Paiements figés | ✅ | ✅ **Figé** | — |
| 2 | MVP figé | ✅ | ✅ **Figé** | — |
| 3 | Indice de présence figé | 🟡 | 🟡 **Partiel** | Toujours pas de formule calculable (décroissance de « dernière interaction », mesure de la « régularité », score initial d'une nouvelle relation, plancher en sous-saisie). **Annexer le chapitre 06 recalibré avant de coder le module score.** Seul vrai reliquat de spécification. |
| 4 | Notifications figées | 🟡 | ✅ **Figé pour l'essentiel** | Opt-in progressif et snooze/pause par relation à régler au design ; ordre de priorité entre types quand le plafond est atteint. |
| 5 | Modèle de données figé | 🟡 | 🟡 **Quasi** | La liste des 14 tables est stable et cohérente ; produire le schéma détaillé (champs, types, relations, index — matière au chapitre 07) avant les premières migrations. |
| 6 | Design system figé | 🟡 | 🟡 **Partiel** | Palette sémantique complète (6 rôles) mais toujours aucune valeur hex, pas d'échelle typographique ni d'iconographie de remplacement des émojis — à figer avant de maquetter les 17 écrans. |
| 7 | Parcours utilisateur figé | ❌ | 🟡 **Quasi** | Le flux du geste central est défini ; l'onboarding reste le seul écran sans contenu spécifié — critique, puisqu'il devient la page de vente de l'essai. Points d'entrée de Calendrier, Statistiques et Ligne de vie à préciser (la ligne de vie est une fonctionnalité V1 sans écran listé — probablement une vue de la fiche relation, à confirmer). |
| 8 | « Ajouter une interaction » conçue et validée | ❌ | 🟡 **Conçue, non validée** | Maquette + prototype + 5-10 tests chronométrés, critère : médiane < 10 secondes. À faire pendant le design, avant de figer le flux en code. |

**Bilan : 4 critères figés, 4 quasi/partiels, 0 non entamé** (contre 2/4/2 au chapitre 15).

## Points de cohérence résiduels

* **La gamification est ambiguë.** Le PRD V1 liste « niveaux, XP, badges, défis, progression du cercle » sans écrans, sans barème et sans marqueur de version, alors que la Décision 2 (V1.1) avait reporté badges, défis et widgets au lot V1.1. À trancher explicitement : soit la gamification reste hors du premier lot (recommandé — seule la « progression du cercle » légère sur l'accueil se justifie au jour 1), soit elle y entre avec barème XP et écrans dédiés.
* **« Capsules » figure dans les éléments conservés d'« En mémoire »** alors que les capsules temporelles sont au lot V1.1 — inoffensif, mais à aligner.
* **L'écran Statistiques (n° 13) est en V1** alors que les « statistiques avancées » sont au lot V1.1 : définir le contenu du tableau de bord V1 (compteurs simples par relation et globaux) pour éviter l'inflation en cours de développement.
* **La bêta privée et le calendrier ont disparu** des documents avec la roadmap : réintroduire les jalons datés et les critères de sortie de bêta du chapitre 12, ajustés au nouveau modèle économique.

## Verdict

Le GO déclaré par la V1.2 est **validé comme GO de démarrage** : la spécification est passée en trois itérations d'un concept contradictoire à un PRD cohérent, priorisé et développable, et plus aucun critère de la checklist n'est au point mort. Quatre réserves suspensives restent attachées à ce GO, toutes réalisables en sprint 0 sans bloquer le démarrage : (1) l'annexe « formule de l'Indice de présence » avant le module score ; (2) le test chronométré du geste central avant de figer son flux ; (3) les tokens du design system (hex, typographie, icônes) avant le maquettage des 17 écrans ; (4) le schéma de données détaillé avant les premières migrations. Deux chantiers parallèles doivent démarrer en même temps que le code : le juridique (politique de confidentialité, CGU — bloquants pour la revue des stores, chapitre 09) et la préparation de la bêta privée qui validera le pivot « premium sans gratuit », la décision la plus audacieuse et la moins réversible du dossier.
