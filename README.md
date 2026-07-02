# AMIORA

**Prends soin des personnes qui comptent.**

AMIORA est un projet d'application mobile qui aide chacun à entretenir ses relations importantes — partenaire, famille, amis — pour éviter qu'elles ne se dégradent par négligence. L'application se veut la mémoire de tes relations : elle retient les proches, les souvenirs, les promesses, les dates importantes et le temps passé ensemble, puis propose de petites attentions quotidiennes pour rester présent.

> **État du projet.** Ce dépôt ne contient à ce stade **aucun code**. Il rassemble : la **Spécification de référence V1.0** (document fondateur officiel, juillet 2026), les documents sources qui l'ont précédée, et l'**audit produit complet** du 2 juillet 2026 qui répond à la question « que manque-t-il pour un produit fini, utilisable et vendable ? ».

## Documents de référence

1. **[Décisions finales V1.1](docs/decisions-finales-v1.1.md)** — les décisions de pré-développement qui prévalent sur tout le reste : paiements, MVP re-découpé en trois lots, pondérations de l'Indice de présence, registre des notifications, checklist GO / NO GO.
2. **[Spécification de référence V1.0](docs/specification-de-reference-v1.0.md)** — le document fondateur du produit : vision, MVP centré sur la saisie d'interaction, modèle économique, architecture. Amendé par les Décisions V1.1.
3. **[État du GO / NO GO](docs/audit/15-revue-des-decisions-v1.1.md)** — évaluation des huit critères de la checklist (2 figés, 4 partiels, 2 non entamés) et la décision encore absente : le prix.
4. **[Synthèse exécutive de l'audit](docs/audit/00-synthese-executive.md)** — verdict « fini / utilisable / vendable », cinq décisions, cinq risques majeurs et roadmap vers un lancement soft en Suisse romande.

## Plan du dépôt

```
docs/
├── decisions-finales-v1.1.md              ★ Décisions de pré-développement (prévalent sur la V1.0)
├── specification-de-reference-v1.0.md     Document fondateur (juillet 2026)
├── spec/    Les sources historiques auditées (archivées)
│   ├── prompt-1-audit-produit.md          Document source n° 1 (vision, MVP, business model)
│   ├── prompt-2-specification-detaillee.md Document source n° 2 (spécification en 31 sections)
│   └── maquettes-observations.md          Relevé factuel des 12 maquettes + incohérences repérées
└── audit/   L'audit produit et ses revues (16 documents)
    ├── 00-synthese-executive.md           Verdict global, décisions, risques, chemin recommandé
    ├── 01-vision-et-positionnement.md
    ├── 02-coherence-des-specifications.md  32 divergences tranchées entre les sources
    ├── 03-perimetre-fonctionnel-mvp.md
    ├── 04-ux-parcours-utilisateur.md
    ├── 05-design-system.md
    ├── 06-score-relationnel-et-gamification.md
    ├── 07-architecture-technique.md
    ├── 08-notifications-et-engagement.md
    ├── 09-confidentialite-securite-conformite.md
    ├── 10-business-model-et-monetisation.md
    ├── 11-risques-et-mitigations.md
    ├── 12-roadmap-vers-le-lancement.md
    ├── 13-kpi-et-mesure-du-succes.md
    ├── 14-revue-de-la-specification-v1.0.md  Revue de la V1.0 face à l'audit
    └── 15-revue-des-decisions-v1.1.md        État du GO / NO GO après les décisions V1.1
```

## Définition du succès

> « Je ne peux plus supprimer AMIORA parce qu'elle contient une partie de mon histoire, de mes souvenirs et des personnes que j'aime. »
