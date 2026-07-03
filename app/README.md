# AMIORA — Application Flutter

Squelette initialisé au Sprint 0. Référence : `docs/sprint-0/05-architecture-flutter.md`
(feature-first + clean architecture + offline-first, décisions figées par le PRD V1.2).

## Démarrage

```bash
# 1. Générer les dossiers natifs (non versionnés à ce stade)
flutter create --platforms ios,android .

# 2. Dépendances (rafraîchir les contraintes avant le premier build)
flutter pub get

# 3. Code généré (Drift)
dart run build_runner build --delete-conflicting-outputs

# 4. Lancer (environnement dev)
flutter run -t lib/main_dev.dart
```

## Environnements

`dev` / `staging` / `prod` via les points d'entrée `lib/main_<env>.dart`
(équivalent `--dart-define=AMIORA_ENV=<env>`). Secrets à fournir par
`--dart-define` : `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SENTRY_DSN`,
`REVENUECAT_API_KEY` — jamais dans le dépôt.

## Responsive (obligatoire)

Trois classes de taille (design system § 9) : `compact` < 600 dp,
`medium` 600-839, `expanded` ≥ 840 (NavigationRail + contenu centré 600 dp).
`SafeArea` partout ; aucune taille fixe de mise en page ; gouttières 16/24.

Matrice de vérification : **375×667 (iPhone SE) · 393×852 (iPhone 15/16) ·
360×780 (Galaxy S24) · 430×932 (Pro Max) · 412×915 (Ultra) · 834×1194 (iPad)**
— `TestDevices.all` dans `lib/core/layout/breakpoints.dart`.
Règle : un écran n'est terminé que lorsqu'il passe sur les six gabarits
sans débordement.

## Budgets de performance (PRD)

60 FPS minimum · démarrage à chaud < 2 s · transitions 150-350 ms ·
images compressées avant upload (~2048 px / ~400 Ko) + miniatures ·
listes en `ListView.builder` (chargement progressif) · cache local
SQLite/Drift (l'app fonctionne 100 % hors ligne, synchronisation
silencieuse en arrière-plan).

## Branchement des services réels (Phases 2 à 5)

Tout le câblage est prêt et **gardé par configuration** : sans clé,
l'application fonctionne en mode local intégral. À fournir (uniquement
des valeurs PUBLIQUES — jamais de clé `service_role`, jamais de secret) :

| Service | Valeur à fournir | Où elle va |
|---|---|---|
| Supabase | URL du projet (`https://xxxx.supabase.co`) | `--dart-define=SUPABASE_URL=…` |
| Supabase | Clé `anon` (publique) | `--dart-define=SUPABASE_ANON_KEY=…` |
| RevenueCat | Clé SDK publique iOS (`appl_…`) et Android (`goog_…`) | `--dart-define=REVENUECAT_API_KEY=…` (par flavor/plateforme) |
| Firebase | `google-services.json` (Android) et `GoogleService-Info.plist` (iOS) | dossiers natifs + `--dart-define=AMIORA_FCM=true` |

Côté serveur (à faire une fois les comptes créés — guides dans `supabase/README.md`) :

1. `supabase db push` (joue les migrations, dont `memory_links`) ;
2. activer les fournisseurs Apple / Google / e-mail (redirection OAuth :
   `ch.amiora.app://login-callback`) ;
3. déployer les 5 Edge Functions + secrets (`FCM_SERVICE_ACCOUNT_JSON`,
   `RC_WEBHOOK_SECRET`) et planifier les crons ;
4. RevenueCat : produits `5,99 CHF/mois` et `44,99 CHF/an` avec essai
   14 jours, entitlement `premium`, webhook vers
   `https://xxxx.supabase.co/functions/v1/revenuecat-webhook`.

Comportements déjà câblés côté app : redirection de connexion quand le
backend est configuré, synchronisation outbox → Supabase (débouncée 3 s
après chaque mutation + périodique 5 min + à la connexion), tirage
last-write-wins, restauration complète sur nouvel appareil, mode lecture
seule piloté par l'entitlement RevenueCat (création bloquée, consultation/
export intacts), enregistrement du jeton push dans `devices`.

## Tests

```bash
flutter test                          # dont test/presence_score_test.dart
```

Les vecteurs de l'Indice de présence sont un CONTRAT : ne jamais les
modifier pour « faire passer » un changement de formule.

## Ordre de développement (PRD V1.2)

1. Authentification · navigation · design system · base locale · synchro
2. Relations (CRUD + archivage)
3. Ajouter une interaction · historique · Indice de présence · notifications
4. Souvenirs · photos · notes · chronologie · En mémoire
5. Calendrier · promesses · Premium/RevenueCat · lecture seule
6. Tests · optimisations · corrections · bêta privée
