# Sprint 0 — Suivi des livrables et état du GO Bêta

Dernière mise à jour : 3 juillet 2026. Documents de référence : [PRD V1.2](../prd-v1.2.md) (GO développement validé, [chapitre 16](../audit/16-revue-du-prd-v1.2-validation-du-go.md)).

## Livrables du Sprint 0

| # | Livrable | Fichier(s) | État |
|---|---|---|---|
| 1 | Formule de l'Indice de présence | [01-indice-de-presence.md](01-indice-de-presence.md) | ✅ **Finalisé** — formule déterministe, 5 exemples chiffrés, implémentée dans `app/lib/domain/presence/` avec vecteurs de test |
| 2 | Prototype « Ajouter une interaction » | [02-prototype-ajouter-interaction.md](02-prototype-ajouter-interaction.md) · [prototype](../../prototype/ajouter-interaction.html) | 🟡 **Prototype livré** (chronomètre intégré, médiane calculée) — les 5-10 tests utilisateurs restent à mener (protocole et gabarit de rapport prêts) |
| 3 | Design system | [03-design-system.md](03-design-system.md) | ✅ **Finalisé** — tokens hex (contrastes WCAG calculés), typographie, 18 composants, Lucide, responsive § 9, matrice d'états § 9.4, budgets de performance § 9.5 |
| 4 | Schéma de données | [04-schema-de-donnees.md](04-schema-de-donnees.md) · [04-schema.sql](04-schema.sql) | ✅ **Finalisé** — 18 tables, 56 politiques RLS, testé sur PostgreSQL (16 assertions), déployé dans `supabase/migrations/` |
| 5 | Architecture Flutter | [05-architecture-flutter.md](05-architecture-flutter.md) | ✅ **Finalisé** — et concrétisé dans `app/` (squelette compilable, voir ci-dessous) |
| 6 | Architecture Supabase | [06-architecture-supabase.md](06-architecture-supabase.md) | ✅ **Finalisé** — et concrétisé dans `supabase/` (migration + 5 Edge Functions) |
| 7 | Juridique | [07-juridique.md](07-juridique.md) | 🟡 **Projets complets rédigés** (CGU, politique de confidentialité, consentements, checklists stores) — validation par un avocat nLPD/RGPD requise avant publication |
| 8 | Plan de bêta privée | [08-plan-beta-privee.md](08-plan-beta-privee.md) | ✅ **Finalisé** — 50-100 testeurs, 30 jours, cibles go/no-go chiffrées |
| 9 | Plan B | [09-plan-b.md](09-plan-b.md) | ✅ **Finalisé** — seuils de déclenchement et 4 options pré-arbitrées |

## Concrétisation (au-delà des documents)

| Élément | Emplacement | Contenu |
|---|---|---|
| Maquettes haute fidélité | [`maquettes/`](../../maquettes/) | 25 écrans + 6 états système + aperçus responsive sur les 6 gabarits (planches HTML autonomes) |
| Prototype interactif | [`prototype/`](../../prototype/) | Flux du geste central avec chronomètre et médiane |
| Application Flutter | [`app/`](../../app/) | Squelette complet : thème sur tokens, coquille adaptative (NavigationBar/Rail), 17 routes, domaine Dart pur, **Indice de présence implémenté et testé** (vecteurs du livrable 1), base Drift + outbox |
| Backend Supabase | [`supabase/`](../../supabase/) | Migration initiale (= livrable 4), 5 Edge Functions (notifications, RevenueCat, export, purge, suppression), config et guide de déploiement |

## État de la checklist GO Bêta

Ce qui se vérifie dans le dépôt est fait ; ce qui exige un poste de développement (SDK Flutter, appareils, projets Supabase/Firebase/RevenueCat réels) est balisé.

| Critère GO Bêta | État | Prochaine action |
|---|---|---|
| Toutes les maquettes existent | ✅ | — (25 écrans + 6 états + responsive + captures réelles de l'app) |
| L'application compile sur iOS et Android | 🟡 Code vérifié | `flutter analyze` : 0 erreur · 16 tests verts · build web réussi · app exécutée en navigateur (captures/). Builds device à confirmer sur poste avec Xcode/Android SDK |
| Aucune erreur responsive détectée | ✅ Vérifié | Test widget de la coquille sur les 6 gabarits (`TestDevices.all`) vert + captures réelles aux 6 tailles (`captures/`) |
| Geste « Ajouter une interaction » < 10 s | 🟡 Fonctionne de bout en bout | Création → sauvegarde locale → recalcul de l'Indice testés sur SQLite réel (`core_gesture_test.dart`) ; les 5-10 chronométrages humains restent à mener |
| Authentification fonctionne | 🔲 Phase 1 | Créer les projets Supabase (dev/staging/prod), activer Apple/Google/e-mail, câbler `main.dart` |
| Synchronisation fonctionne | 🔲 Phase 1 | Implémenter la boucle outbox → Supabase (architecture § 4) |
| Notifications fonctionnent | 🔲 Phase 3 | Déployer `daily-notifications` + FCM, tester sur appareils |
| Mode lecture seule fonctionne | 🔲 Phase 5 | Webhook RevenueCat en sandbox + politiques RLS déjà en place |
| Abonnements fonctionnent | 🔲 Phase 5 | Produits 5,99 CHF/mois et 44,99 CHF/an dans App Store Connect / Play Console + RevenueCat |
| Aucun bug bloquant | 🔲 Phase 6 | Bêta interne avant bêta privée |

**Lecture honnête :** le Sprint 0 est documenté et concrétisé à hauteur de ce qu'un dépôt peut porter — spécifications finalisées, maquettes réelles, code initialisé avec la mécanique centrale testée. Le GO Bêta lui-même se joue maintenant dans les phases 1 à 6 du PRD sur un poste de développement, en suivant l'ordre obligatoire (auth → relations → interactions/indice → souvenirs → premium → bêta).
