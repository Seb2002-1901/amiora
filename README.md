# AMIORA

**Prends soin des personnes qui comptent.**

AMIORA est un projet d'application mobile qui aide chacun à entretenir ses relations importantes — partenaire, famille, amis — pour éviter qu'elles ne se dégradent par négligence. L'application se veut la mémoire de tes relations : elle retient les proches, les souvenirs, les promesses, les dates importantes et le temps passé ensemble, puis propose de petites attentions quotidiennes pour rester présent.

> **État du projet.** L'application **tourne** : accueil, relations, fiche et geste central « Ajouter une interaction » fonctionnent de bout en bout sur la base locale (SQLite/Drift) avec recalcul immédiat de l'Indice de présence — 16 tests verts, `flutter analyze` sans erreur, build web vérifié en navigateur réel sur les 6 gabarits (`captures/`). Backend Supabase structuré (migration + 5 Edge Functions), maquettes et juridique livrés. Restent : builds device (Xcode/Android SDK), connexion Supabase/RevenueCat (phases 1 et 5 du PRD), tests utilisateurs chronométrés, bêta privée. Suivi : [docs/sprint-0/README.md](docs/sprint-0/README.md).

## Documents de référence

1. **[PRD Final V1.2](docs/prd-v1.2.md)** — ★ le document de référence produit, statut **GO DÉVELOPPEMENT** : geste central spécifié de bout en bout, modèle premium sans plan gratuit (essai 14 jours, 5,99 CHF/mois · 44,99 CHF/an), hors-ligne d'abord, 17 écrans, politique de notifications.
2. **[Suivi du Sprint 0 et checklist GO Bêta](docs/sprint-0/README.md)** — l'état des 9 livrables et ce qui reste avant la bêta privée.
3. **[Maquettes haute fidélité](maquettes/)** — 25 écrans + 6 états système + aperçus responsive sur 6 gabarits (ouvrir les fichiers HTML dans un navigateur).
4. **[Validation du GO](docs/audit/16-revue-du-prd-v1.2-validation-du-go.md)** · **[Décisions V1.1](docs/decisions-finales-v1.1.md)** · **[Spécification V1.0](docs/specification-de-reference-v1.0.md)** — l'historique des décisions.
5. **[Synthèse exécutive de l'audit](docs/audit/00-synthese-executive.md)** — le point de départ : verdict « fini / utilisable / vendable », cinq décisions, cinq risques majeurs, roadmap.

## Plan du dépôt

```
app/          Application Flutter (squelette : thème, navigation adaptative,
              domaine + Indice de présence testé, base Drift + outbox)
supabase/     Backend : migration initiale, 5 Edge Functions, config, guide
maquettes/    3 planches HTML haute fidélité (écrans, états, responsive)
prototype/    Prototype interactif « Ajouter une interaction » (chronométré)
docs/
├── prd-v1.2.md                            ★ PRD Final — document de référence actif (GO développement)
├── decisions-finales-v1.1.md              Décisions de pré-développement (historique)
├── specification-de-reference-v1.0.md     Document fondateur (historique)
├── sprint-0/ Les 9 livrables normatifs + suivi GO Bêta (README.md)
│   ├── 01-indice-de-presence.md           Formule déterministe (implémentée dans app/)
│   ├── 02-prototype-ajouter-interaction.md Spécification UX + protocole de test < 10 s
│   ├── 03-design-system.md                Tokens, composants, responsive, états, performance
│   ├── 04-schema-de-donnees.md + .sql     18 tables, RLS, testé sur PostgreSQL
│   ├── 05-architecture-flutter.md         Feature-first, clean, offline-first
│   ├── 06-architecture-supabase.md        Auth, Storage, Edge Functions, sauvegardes
│   ├── 07-juridique.md                    CGU + confidentialité (projets à faire valider)
│   ├── 08-plan-beta-privee.md             50-100 testeurs, 30 jours, go/no-go chiffrés
│   └── 09-plan-b.md                       Seuils et options si le premium sans gratuit cale
├── spec/    Les sources historiques auditées (archivées)
│   ├── prompt-1-audit-produit.md          Document source n° 1 (vision, MVP, business model)
│   ├── prompt-2-specification-detaillee.md Document source n° 2 (spécification en 31 sections)
│   └── maquettes-observations.md          Relevé factuel des 12 maquettes + incohérences repérées
└── audit/   L'audit produit et ses revues (17 documents)
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
    ├── 15-revue-des-decisions-v1.1.md        État du GO / NO GO après les décisions V1.1
    └── 16-revue-du-prd-v1.2-validation-du-go.md  Validation du GO développement
```

## Définition du succès

> « Je ne peux plus supprimer AMIORA parce qu'elle contient une partie de mon histoire, de mes souvenirs et des personnes que j'aime. »
