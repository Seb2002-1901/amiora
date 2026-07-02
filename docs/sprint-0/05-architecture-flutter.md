# Sprint 0 — Livrable 5 : Architecture Flutter définitive

* **Statut : NORMATIF — les choix de ce document sont figés.**
* **Références :** [PRD V1.2](../prd-v1.2.md) · [Audit, chapitre 7 — Architecture technique](../audit/07-architecture-technique.md) · [Livrable 1 — Indice de présence](01-indice-de-presence.md)

Ce document définit l'architecture de l'application Flutter d'AMIORA. Il est écrit pour qu'un développeur puisse construire l'application **sans aucune décision d'architecture supplémentaire**. Toute dérogation à ce document doit être documentée et validée avant implémentation.

---

## 1. Principes d'architecture

Trois principes non négociables, imposés par le PRD et l'audit (R1, R3) :

### 1.1 Feature-first

Le code est organisé **par fonctionnalité** (auth, relations, interactions, souvenirs…), pas par type technique. Chaque feature contient sa couche de présentation complète (écrans, widgets, providers). Ce qui est partagé entre features vit dans `core/`, `domain/` et `data/` — rien d'autre n'est partagé.

### 1.2 Clean architecture (trois couches)

| Couche | Contenu | Dépend de |
|---|---|---|
| **Présentation** (`features/*/presentation`) | Écrans, widgets, providers Riverpod | Domain uniquement |
| **Domaine** (`domain/`) | Entités métier, interfaces de repositories, use cases | Rien (Dart pur, zéro import Flutter/Drift/Supabase) |
| **Données** (`data/`) | Drift (base locale), clients Supabase, implémentations des repositories, moteur de synchronisation | Domain (implémente ses interfaces) |

Règle de dépendance stricte : **les flèches pointent vers le domaine**. La couche présentation ne voit jamais Drift ni Supabase ; la couche domaine ne voit jamais Flutter. Cette règle est vérifiable par revue de code (imports) et doit être appliquée dès le premier commit.

### 1.3 Offline-first

* **Lecture et écriture 100 % locales.** L'interface lit et écrit exclusivement dans la base SQLite locale (Drift). Aucun écran, aucune action de création ou de modification ne dépend du réseau. Le PRD l'exige : créer une relation, un souvenir, une interaction, modifier une note et consulter ses données doivent fonctionner sans Internet.
* **Le réseau est un processus d'arrière-plan**, jamais une condition de l'interface. La synchronisation est automatique et **silencieuse** : pas d'écran de chargement, pas de bouton « synchroniser », au plus un indicateur discret « en attente d'envoi » sur les médias.
* **Identifiants UUID v4 générés côté client** sur toutes les entités : condition de la création hors ligne sans collision.
* **Suppressions logiques** (`deleted_at`) partout, pour que les suppressions se propagent entre appareils.

---

## 2. Arborescence du projet

```text
amiora/
├── android/                          # Projet Android (flavors dev/staging/prod)
├── ios/                              # Projet iOS (schemes dev/staging/prod)
├── assets/
│   ├── images/
│   └── fonts/
├── lib/
│   ├── main_dev.dart                 # Point d'entrée flavor dev
│   ├── main_staging.dart             # Point d'entrée flavor staging
│   ├── main_prod.dart                # Point d'entrée flavor prod
│   ├── bootstrap.dart                # Initialisation commune (Sentry, Firebase, Drift, Supabase, ProviderScope)
│   ├── app.dart                      # Widget racine (MaterialApp.router, thème, localisation)
│   │
│   ├── core/                         # Transverse, sans logique métier
│   │   ├── config/
│   │   │   ├── env.dart              # Lecture des dart-define (URLs Supabase, clés par flavor)
│   │   │   └── flavor.dart           # Enum Flavor {dev, staging, prod}
│   │   ├── theme/
│   │   │   ├── app_tokens.dart       # Tokens du design system : couleurs (noir profond,
│   │   │   │                         #   anthracite, or premium…), rayons, espacements, durées
│   │   │   ├── app_typography.dart
│   │   │   └── app_theme.dart        # ThemeData construit à partir des tokens
│   │   ├── router/
│   │   │   ├── app_router.dart       # Configuration go_router (voir § 3.2)
│   │   │   ├── routes.dart           # Constantes de chemins et de noms de routes
│   │   │   └── modal_page.dart       # Page personnalisée pour les routes en bottom sheet
│   │   ├── errors/
│   │   │   ├── app_exception.dart    # Hiérarchie d'exceptions (voir § 5)
│   │   │   └── result.dart           # Result<T> (sealed class, voir § 5)
│   │   ├── logging/
│   │   │   └── app_logger.dart       # Façade de log (console en dev, Sentry en prod)
│   │   ├── analytics/
│   │   │   ├── analytics_service.dart      # Abstraction (interface)
│   │   │   ├── analytics_events.dart       # Catalogue typé des événements (voir § 6)
│   │   │   └── posthog_analytics.dart      # Implémentation (instance UE)
│   │   └── utils/
│   │       ├── date_utils.dart
│   │       ├── uuid.dart
│   │       └── extensions/
│   │
│   ├── domain/                       # Dart pur — aucune dépendance Flutter/Drift/Supabase
│   │   ├── entities/
│   │   │   ├── relationship.dart
│   │   │   ├── interaction.dart
│   │   │   ├── memory.dart
│   │   │   ├── media_asset.dart
│   │   │   ├── promise.dart
│   │   │   ├── event.dart
│   │   │   ├── important_date.dart
│   │   │   ├── preference.dart
│   │   │   ├── presence_score.dart
│   │   │   ├── subscription_status.dart
│   │   │   └── user_profile.dart
│   │   ├── repositories/             # Interfaces abstraites (implémentées dans data/)
│   │   │   ├── auth_repository.dart
│   │   │   ├── relationship_repository.dart
│   │   │   ├── interaction_repository.dart
│   │   │   ├── memory_repository.dart
│   │   │   ├── promise_repository.dart
│   │   │   ├── event_repository.dart
│   │   │   ├── subscription_repository.dart
│   │   │   └── settings_repository.dart
│   │   └── usecases/
│   │       ├── compute_presence_score.dart   # Voir § 10 — implémente le livrable 01
│   │       ├── log_interaction.dart
│   │       ├── create_relationship.dart
│   │       ├── archive_relationship.dart
│   │       ├── create_memory.dart
│   │       ├── complete_promise.dart
│   │       ├── build_lifeline.dart           # Ligne de vie (vue dérivée)
│   │       ├── get_memory_of_the_day.dart    # « Souvenir du jour »
│   │       ├── export_user_data.dart         # PDF + JSON
│   │       └── delete_account.dart
│   │
│   ├── data/
│   │   ├── local/                    # Drift — source de vérité de l'interface
│   │   │   ├── app_database.dart     # Déclaration de la base (SQLCipher)
│   │   │   ├── tables/               # Miroir du schéma serveur + colonnes de synchro
│   │   │   │   ├── relationships_table.dart
│   │   │   │   ├── interactions_table.dart
│   │   │   │   ├── memories_table.dart
│   │   │   │   ├── media_assets_table.dart
│   │   │   │   ├── promises_table.dart
│   │   │   │   ├── events_table.dart
│   │   │   │   ├── important_dates_table.dart
│   │   │   │   ├── preferences_table.dart
│   │   │   │   ├── score_snapshots_table.dart
│   │   │   │   ├── settings_table.dart
│   │   │   │   └── outbox_table.dart # File de mutations (voir § 4)
│   │   │   └── daos/
│   │   │       ├── relationship_dao.dart
│   │   │       ├── interaction_dao.dart
│   │   │       ├── memory_dao.dart
│   │   │       ├── promise_dao.dart
│   │   │       ├── event_dao.dart
│   │   │       └── outbox_dao.dart
│   │   ├── remote/                   # Clients Supabase — utilisés uniquement par sync/
│   │   │   ├── supabase_client_provider.dart
│   │   │   ├── auth_api.dart
│   │   │   ├── sync_api.dart         # Push/pull des mutations
│   │   │   └── storage_api.dart      # Upload médias (URL signées)
│   │   ├── sync/
│   │   │   ├── sync_engine.dart      # Orchestration push/pull, LWW (voir § 4)
│   │   │   ├── sync_triggers.dart    # Réseau, resume, push silencieux
│   │   │   ├── outbox_processor.dart
│   │   │   └── media_upload_queue.dart  # Upload arrière-plan avec reprise (voir § 4.4)
│   │   ├── media/
│   │   │   └── media_processor.dart  # Compression ~2048 px / ~400 Ko + miniature 400 px
│   │   └── repositories/             # Implémentations des interfaces du domaine
│   │       ├── relationship_repository_impl.dart
│   │       ├── interaction_repository_impl.dart
│   │       ├── memory_repository_impl.dart
│   │       ├── promise_repository_impl.dart
│   │       ├── event_repository_impl.dart
│   │       ├── auth_repository_impl.dart
│   │       ├── subscription_repository_impl.dart
│   │       └── settings_repository_impl.dart
│   │
│   ├── features/                     # Une feature = présentation complète d'un domaine d'écran
│   │   ├── auth/
│   │   │   └── presentation/
│   │   │       ├── screens/          # login_screen, signup_screen, forgot_password_screen
│   │   │       ├── widgets/
│   │   │       └── providers/
│   │   ├── onboarding/
│   │   │   └── presentation/{screens,widgets,providers}
│   │   ├── home/
│   │   │   └── presentation/{screens,widgets,providers}
│   │   ├── relationships/
│   │   │   └── presentation/
│   │   │       ├── screens/          # relationships_screen, relationship_form_screen,
│   │   │       │                     #   relationship_detail_screen (fiche : infos, préférences,
│   │   │       │                     #   dates importantes, ligne de vie)
│   │   │       ├── widgets/
│   │   │       └── providers/
│   │   ├── interactions/
│   │   │   └── presentation/
│   │   │       ├── screens/          # add_interaction_sheet (bottom sheet, < 10 s)
│   │   │       ├── widgets/
│   │   │       └── providers/
│   │   ├── memories/
│   │   │   └── presentation/{screens,widgets,providers}   # grille, album, chronologie
│   │   ├── calendar/
│   │   │   └── presentation/{screens,widgets,providers}   # vues jour/semaine/mois
│   │   ├── promises/
│   │   │   └── presentation/{screens,widgets,providers}
│   │   ├── statistics/
│   │   │   └── presentation/{screens,widgets,providers}
│   │   ├── profile/
│   │   │   └── presentation/{screens,widgets,providers}   # profil, gamification (niveaux, badges)
│   │   ├── settings/
│   │   │   └── presentation/{screens,widgets,providers}   # notifications, confidentialité,
│   │   │                                                  #   export, suppression, opt-out analytics
│   │   ├── paywall/
│   │   │   └── presentation/{screens,widgets,providers}   # écran Premium, essai, lecture seule
│   │   └── in_memoriam/
│   │       └── presentation/{screens,widgets,providers}
│   │
│   └── l10n/
│       ├── app_fr.arb                # Langue de référence
│       └── app_en.arb
│
├── test/
│   ├── domain/usecases/              # Tests unitaires (dont vecteurs de l'indice, livrable 01)
│   ├── data/sync/                    # Tests du moteur de synchronisation
│   ├── features/                     # Tests widget par feature
│   └── goldens/                      # Golden tests du design system
├── integration_test/
│   └── add_interaction_flow_test.dart  # Flux « ajouter une interaction » chronométré
├── l10n.yaml
├── analysis_options.yaml
└── pubspec.yaml
```

Règles d'implantation :

* Un fichier = un widget public ou une classe publique principale.
* Les widgets réutilisables **entre features** (boutons, cartes, avatars du design system) vivent dans `core/theme/` s'ils sont purement visuels, sinon dans une feature « propriétaire » — jamais dans un fourre-tout `shared/`.
* Aucune feature n'importe une autre feature. La communication passe par le domaine (use cases, repositories) et par la navigation (go_router).

---

## 3. Choix figés

| Domaine | Choix | Justification courte |
|---|---|---|
| Gestion d'état | **Riverpod** (providers typés, `AsyncNotifier`, génération de code) | Injection de dépendances et état dans le même outil ; providers testables par overrides ; `AsyncNotifier` modélise nativement chargement/erreur/donnée. |
| Navigation | **go_router** | Routage déclaratif, deep links (notifications → écran cible), `StatefulShellRoute` pour la barre à 5 onglets, pages modales personnalisées. |
| Base locale | **Drift** (SQLite, chiffrée SQLCipher) | Requêtes typées et réactives (`Stream`), migrations versionnées, écosystème hors-ligne mûr ; recommandation R1 de l'audit. |
| Backend | **supabase_flutter** | Auth Apple/Google/e-mail, Postgres + RLS, Storage ; projet hébergé dans l'UE (audit T-02). Utilisé **uniquement** par la couche `data/remote` et `data/sync`. |
| Abonnements | **purchases_flutter** (RevenueCat) | StoreKit + Play Billing unifiés, restauration d'achats, webhooks d'état ; imposé par le PRD. |
| Push | **firebase_messaging** (FCM/APNs) | Canal d'envoi des notifications serveur et des push silencieux de synchronisation. |
| Erreurs / crashs | **sentry_flutter** | Crashs et erreurs non fatales, release health par flavor ; scrubbing configuré (voir § 5.3). |
| i18n | **ARB** via `flutter_localizations` + `intl` | Français langue de référence (`app_fr.arb`), anglais ensuite. Aucune chaîne en dur dans les écrans. |
| Analytics | **PostHog** (instance hébergée UE) derrière l'abstraction `AnalyticsService` | Privacy-first, hébergement UE, opt-out simple ; l'abstraction permet d'en changer sans toucher aux features. |

### 3.1 Dépendances

Toutes les dépendances sont prises en **dernière version stable** au moment de l'initialisation du projet (aucun numéro de version n'est figé ici ; le `pubspec.lock` fait foi ensuite).

**Production :** `flutter_riverpod`, `riverpod_annotation`, `go_router`, `drift`, `drift_flutter`, `sqlcipher_flutter_libs`, `supabase_flutter`, `purchases_flutter`, `firebase_core`, `firebase_messaging`, `flutter_local_notifications` (filet local hors ligne, audit R5), `sentry_flutter`, `intl`, `connectivity_plus`, `background_downloader` (upload en tâche de fond avec reprise), `flutter_image_compress`, `image_picker`, `flutter_secure_storage`, `uuid`, `posthog_flutter`.

**Développement :** `build_runner`, `riverpod_generator`, `drift_dev`, `custom_lint`, `riverpod_lint`, `flutter_lints`, `mocktail`, `integration_test` (SDK).

Règle : **toute dépendance supplémentaire doit être justifiée par écrit** (issue) avant ajout. Pas de package pour ce que Dart 3 ou le SDK Flutter fait déjà (ex. : `Result` maison plutôt qu'une bibliothèque fonctionnelle complète).

### 3.2 Table des routes (go_router)

La navigation principale du PRD (Accueil · Relations · Ajouter · Souvenirs · Profil) est portée par un `StatefulShellRoute.indexedStack` à **4 branches** ; le bouton central « + » n'est pas une branche : il ouvre la route modale d'ajout d'interaction.

| # écran PRD | Écran | Chemin | Type |
|---|---|---|---|
| 1 | Splash | `/splash` | Plein écran (redirection selon session) |
| 2 | Onboarding | `/onboarding` | Plein écran |
| 3 | Connexion | `/login` | Plein écran |
| — | Mot de passe oublié | `/login/forgot-password` | Plein écran |
| 4 | Création du compte | `/signup` | Plein écran |
| 5 | Accueil | `/home` | Branche shell 1 |
| 6 | Relations | `/relationships` | Branche shell 2 |
| 7 | Ajouter relation | `/relationships/new` | Plein écran (poussé sur la branche 2) |
| 8 | Fiche relation | `/relationships/:id` | Plein écran (poussé sur la branche 2) |
| — | Modifier relation | `/relationships/:id/edit` | Plein écran |
| 9 | **Ajouter interaction** | `/add-interaction` (paramètre facultatif `relationshipId`) | **Route modale en bottom sheet** (page personnalisée `ModalSheetPage`, `parentNavigatorKey` = navigateur racine) |
| 10 | Souvenirs | `/memories` | Branche shell 3 |
| — | Détail souvenir / album | `/memories/:id` | Plein écran |
| 11 | Calendrier | `/calendar` | Plein écran (accessible depuis Accueil) |
| 12 | Promesses | `/promises` | Plein écran (accessible depuis Accueil et fiche relation) |
| 13 | Statistiques | `/statistics` | Plein écran |
| 14 | Profil | `/profile` | Branche shell 4 |
| 15 | Paramètres | `/settings` | Plein écran (poussé sur la branche 4) |
| 16 | Premium (paywall) | `/paywall` | Modale plein écran (`fullscreenDialog`) |
| 17 | En mémoire | `/in-memoriam` et `/in-memoriam/:id` | Plein écran |

Règles de navigation figées :

* **Redirection globale** dans `app_router.dart` : session absente → `/login` ; onboarding non terminé → `/onboarding` ; abonnement expiré → accès en lecture seule, toute route de création/modification redirige vers `/paywall`.
* Les **notifications ouvrent des deep links** (`/relationships/:id`, `/promises`, `/memories/:id`) ; l'événement `notification_opened` est journalisé au passage (voir § 6).
* La route `/add-interaction` est accessible depuis n'importe quel onglet (bouton central), depuis la fiche relation (pré-remplie via `relationshipId`) et par deep link. Le flux complet — sélection personne, sélection type, Enregistrer, confirmation — vit **dans un seul bottom sheet** pour tenir l'objectif < 10 secondes.

### 3.3 Base locale Drift : miroir du schéma serveur

La base locale reprend **le même schéma logique que le serveur** (tables du PRD : relations, préférences, dates importantes, interactions, souvenirs, médias, événements, promesses, réglages, instantanés de score…), avec les mêmes identifiants UUID. Chaque table synchronisée porte en outre les colonnes de synchronisation :

| Colonne | Rôle |
|---|---|
| `updated_at` (UTC, millisecondes) | Horodatage de dernière modification — clé de la résolution last-write-wins. |
| `deleted_at` (UTC, nullable) | Suppression logique ; les lignes supprimées restent jusqu'à propagation puis purge. |
| `pending_ops` (entier) | Nombre de mutations de cette ligne encore en attente dans l'outbox ; `> 0` ⇒ la ligne est « en attente d'envoi » (indicateur discret dans l'interface, et une ligne locale plus récente ne doit pas être écrasée par un pull). |

La base est **chiffrée** (SQLCipher), clé stockée dans Keychain/Keystore via `flutter_secure_storage` (audit R6).

---

## 4. Couche de synchronisation

La synchronisation est un module autonome (`data/sync/`), invisible pour la présentation.

### 4.1 File de mutations (table `outbox`)

Toute écriture passe par une transaction Drift unique : **mutation de la table métier + insertion d'une ligne d'outbox**. Schéma de la table :

| Colonne | Contenu |
|---|---|
| `id` | UUID de la mutation |
| `entity_table` | Table concernée (`interactions`, `memories`…) |
| `entity_id` | UUID de la ligne |
| `op` | `insert` / `update` / `delete` |
| `payload` | JSON de la ligne après mutation (état complet, pas un diff) |
| `created_at` | Horodatage de la mutation |
| `attempts` | Compteur de tentatives d'envoi |
| `last_error` | Dernier code d'erreur (diagnostic ; jamais de contenu utilisateur) |

L'`outbox_processor` pousse les mutations **dans l'ordre de création**, par lots, vers l'API de synchronisation Supabase. Une mutation acceptée est supprimée de l'outbox et `pending_ops` est décrémenté. Une mutation refusée pour une raison durable (quota, validation) est retirée de la file et remontée comme `SyncException` typée ; une erreur réseau laisse la mutation en place avec retentative à **backoff exponentiel plafonné** (1 min → 2 → 4 → … → 1 h).

### 4.2 Déclencheurs

La synchronisation (push outbox puis pull des changements serveur) démarre sur :

1. **Retour du réseau** (`connectivity_plus`) ;
2. **Reprise de l'application** (passage au premier plan, via `AppLifecycleListener`) ;
3. **Push silencieux** FCM (`content-available`) envoyé par le serveur quand un autre appareil du même compte a poussé des changements ;
4. Immédiatement **après chaque mutation locale** si le réseau est disponible (l'utilisateur connecté ne doit jamais attendre le prochain déclencheur).

Une seule passe de synchronisation à la fois (verrou) ; les déclenchements concurrents sont coalescés.

### 4.3 Résolution de conflits : last-write-wins par `updated_at`

Les données sont mono-utilisateur ; les conflits ne surviennent qu'entre appareils du même compte. Règle figée pour la V1 (audit R3) :

* Au pull, une ligne serveur ne remplace la ligne locale que si son `updated_at` est **strictement supérieur** et que la ligne locale n'a pas de mutation en attente (`pending_ops = 0`).
* Au push, le serveur applique la même règle : la mutation gagne si son `updated_at` est plus récent, sinon elle est ignorée et l'état serveur redescend au pull suivant.
* Les suppressions (`deleted_at`) suivent la même règle et priment à horodatage égal.

Cette stratégie sera réévaluée uniquement si un partage multi-utilisateurs apparaît dans une version ultérieure.

### 4.4 Médias

Pipeline figé (audit R4), exécuté **avant** toute mise en file d'upload :

1. **Compression à la capture** (`media_processor`) : bord long ramené à **~2048 px**, JPEG qualité ~80 %, cible **~400 Ko** par photo ;
2. **Miniature 400 px** (~30 Ko) générée localement, affichée dans toutes les grilles ;
3. Les deux fichiers sont stockés localement, la ligne `media_assets` est créée avec `upload_status = pending` — le souvenir est **immédiatement visible et complet hors ligne** ;
4. **Upload en tâche de fond avec reprise** (`background_downloader`, adossé à `URLSession` background sur iOS et `WorkManager` sur Android) vers le bucket privé Supabase Storage, miniature d'abord puis original ; reprise automatique après coupure, échec ou redémarrage ;
5. À l'upload réussi, `upload_status = uploaded` ; en attendant, l'interface montre un indicateur discret « en attente d'envoi », jamais un blocage.

Les originaux pleine résolution ne quittent **jamais** l'appareil : seule la version compressée est envoyée.

---

## 5. Gestion des erreurs et journalisation

### 5.1 Hiérarchie d'exceptions (`core/errors/app_exception.dart`)

```dart
sealed class AppException implements Exception {
  const AppException(this.code); // code stable, jamais de contenu utilisateur
  final String code;
}

class NetworkException extends AppException {}       // hors ligne, timeout, 5xx
class AuthException extends AppException {}          // session expirée, identifiants invalides
class SyncException extends AppException {}          // mutation refusée, conflit irrécupérable
class QuotaException extends AppException {}         // limite de stockage/volume atteinte
class SubscriptionException extends AppException {}  // essai expiré, achat échoué, lecture seule
class StorageException extends AppException {}       // base locale, fichiers, chiffrement
```

Chaque exception porte un `code` stable (ex. `sync.rejected.validation`) utilisé pour les logs et le mapping vers des messages localisés. **Les messages affichés à l'utilisateur viennent des ARB, jamais des exceptions.**

### 5.2 `Result<T>` dans les use cases

Les use cases ne lancent pas d'exceptions vers la présentation : ils retournent un type somme maison (Dart 3, pas de dépendance externe) :

```dart
sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> { const Success(this.value); final T value; }
class Failure<T> extends Result<T> { const Failure(this.error); final AppException error; }
```

La couche `data/` attrape les erreurs techniques (Drift, Supabase, plateforme), les convertit en `AppException` typées, et les use cases les propagent en `Failure`. Les providers (`AsyncNotifier`) traduisent `Failure` en état d'erreur affichable. Une exception qui atteint la présentation sans avoir été typée est un bug.

### 5.3 Règles de journalisation

* **Jamais de contenu utilisateur dans les logs** : ni prénom, ni nom, ni note, ni lieu, ni légende, ni URL signée, ni adresse e-mail. Uniquement des identifiants techniques (UUID), des codes d'erreur, des compteurs et des durées.
* Façade unique `AppLogger` (`core/logging/`) : console structurée en dev, Sentry en staging/prod. Aucun `print` dans le code (lint bloquant).
* Sentry : `sendDefaultPii = false`, scrubbing des breadcrumbs (pas de corps de requêtes), `environment` renseigné par flavor, release health activé.
* Niveaux : `debug` (dev uniquement), `info` (jalons techniques : synchro terminée, migration exécutée), `warning` (retentative, conflit résolu), `error` (exception typée non récupérée).

---

## 6. Analytics privacy-first

Abstraction `AnalyticsService` + catalogue typé `analytics_events.dart` : **aucun appel direct au SDK dans les features**, et un événement non déclaré dans le catalogue ne peut pas être émis.

**Règle absolue :** les propriétés ne contiennent **jamais** de contenu utilisateur ni de nom de tiers — pas de prénom, pas de texte de note ou de promesse, pas de lieu, pas d'identifiant de relation. Uniquement des types énumérés, des compteurs et des durées. **Opt-out** disponible dans Paramètres → Confidentialité ; l'opt-out coupe l'émission à la source (dans `AnalyticsService`), pas seulement l'envoi.

Catalogue V1 (exhaustif — tout ajout passe par une revue) :

| Événement | Propriétés | Moment |
|---|---|---|
| `onboarding_completed` | — | Fin de l'onboarding |
| `signup_completed` | `provider` (apple/google/email) | Compte créé |
| `login_completed` | `provider` | Connexion |
| `relationship_created` | `category` | Relation enregistrée |
| `relationship_archived` | — | Archivage |
| `interaction_logged` | `type`, `seconds_to_complete`, `offline` (bool) | Interaction enregistrée — mesure l'objectif < 10 s |
| `memory_created` | `media_count` | Souvenir enregistré |
| `promise_created` | — | Promesse créée |
| `promise_completed` | — | Promesse terminée |
| `important_date_added` | `type` | Date importante ajoutée |
| `calendar_viewed` | `view` (jour/semaine/mois) | Ouverture du calendrier |
| `statistics_viewed` | — | Ouverture des statistiques |
| `memory_of_day_viewed` | — | « Souvenir du jour » ouvert |
| `in_memoriam_activated` | — | Passage d'une relation en mode « En mémoire » |
| `notification_opened` | `type` (attention/anniversaire/promesse/souvenir) | Ouverture depuis une notification |
| `paywall_viewed` | `source` (onboarding/lecture_seule/reglages) | Affichage du paywall |
| `trial_started` | — | Début d'essai 14 jours |
| `subscription_started` | `plan` (mensuel/annuel) | Abonnement actif |
| `subscription_cancelled` | `plan` | Annulation détectée |
| `export_requested` | `format` (pdf/json) | Export demandé |
| `account_deleted` | — | Suppression confirmée (dernier événement du compte) |
| `offline_sync_completed` | `ops_count`, `duration_ms`, `result` (ok/partiel/échec) | Fin d'une passe de synchronisation avec mutations |

Ces événements couvrent les KPI du PRD (inscriptions, essais, conversions, relations/interactions/souvenirs créés, rétention, churn).

---

## 7. Environnements

Trois environnements, isolés de bout en bout : **dev**, **staging**, **prod**.

| Élément | dev | staging | prod |
|---|---|---|---|
| Flavor Android / scheme iOS | `dev` | `staging` | `prod` |
| Identifiant d'application | `app.amiora.dev` | `app.amiora.staging` | `app.amiora` |
| Projet Supabase | dédié (UE) | dédié (UE) | dédié (UE) |
| Projet Firebase | dédié | dédié | dédié |
| Projet RevenueCat | dédié (produits de test / sandbox) | dédié (sandbox stores) | production |
| Sentry `environment` | `dev` | `staging` | `prod` |
| Analytics | désactivé | projet de test | production |

Mécanique figée :

* **Un point d'entrée par flavor** (`main_dev.dart`, `main_staging.dart`, `main_prod.dart`) qui fixe le `Flavor` puis appelle `bootstrap()`.
* **Toute configuration variable passe par `--dart-define-from-file`** (un fichier `env/<flavor>.json` par environnement, non commité pour prod) : URL et clé anonyme Supabase, clés RevenueCat, DSN Sentry, clé PostHog. Aucun secret en dur dans le code ; les fichiers Firebase (`google-services.json`, `GoogleService-Info.plist`) sont rangés par flavor dans les projets natifs.
* Les trois flavors sont **installables côte à côte** sur un même appareil (identifiants distincts).
* Interdiction absolue de pointer un build dev/staging vers le projet Supabase de production.

---

## 8. Injection de dépendances

L'injection de dépendances est assurée **exclusivement par Riverpod**. Aucun service locator, aucun singleton global.

* Chaque service et repository est exposé par un provider dans sa couche : `appDatabaseProvider`, `supabaseClientProvider`, `syncEngineProvider`, `analyticsServiceProvider`, `relationshipRepositoryProvider` (type de retour : **l'interface du domaine**, jamais l'implémentation), etc.
* Les use cases sont exposés par des providers qui assemblent leurs dépendances ; la présentation ne consomme que des providers de use cases et d'état, jamais un repository directement quand un use case existe.
* Le graphe est **paresseux** : rien n'est instancié avant le premier usage, sauf ce que `bootstrap()` initialise explicitement (base, Sentry, Firebase).
* **Tests** : les doubles sont injectés par `ProviderContainer(overrides: […])` / `ProviderScope(overrides: […])` — par exemple `relationshipRepositoryProvider.overrideWithValue(fakeRepo)`. C'est la seule technique de substitution autorisée ; aucune condition `if (test)` dans le code de production.

---

## 9. Stratégie de tests

| Niveau | Périmètre | Outils | Exigence |
|---|---|---|---|
| **Unitaires** | Tous les use cases, la résolution LWW, l'outbox, le mapping d'exceptions. **`compute_presence_score` est validé contre les vecteurs de test du [livrable 01](01-indice-de-presence.md)** (cas nominaux, bornes 0/100, relation sans interaction, mode « En mémoire »). | `flutter_test`, `mocktail`, Drift en mémoire | Couverture forte du domaine ; les vecteurs du livrable 01 sont un contrat : tout écart est un échec de build. |
| **Widget** | Écrans clés : accueil, liste et fiche relation, bottom sheet d'ajout d'interaction, paywall (y compris état lecture seule), souvenirs. | `flutter_test` + overrides Riverpod | États chargement/erreur/vide/données couverts pour chaque écran testé. |
| **Intégration** | Flux complet **« ajouter une interaction »** sur base locale réelle : ouverture du sheet → personne → type → Enregistrer → confirmation, **chronométré et instrumenté** ; le test échoue au-delà de **10 secondes** (budget PRD). Second flux : création hors ligne puis synchronisation au retour du réseau. | `integration_test` | Exécuté en CI sur émulateur à chaque fusion. |
| **Golden** | Composants du design system (boutons, cartes relation/souvenir, jauge de l'indice, états vides), thème sombre premium, tailles de police accessibles. | `flutter_test` (goldens natifs) | Tout changement visuel d'un composant exige la régénération assumée des goldens dans la revue. |

CI (GitHub Actions) : analyse statique (`custom_lint` inclus), tests unitaires et widget, goldens, puis tests d'intégration ; un build par flavor. Aucune fusion sans pipeline vert.

---

## 10. Module « Indice de présence »

La formule, les pondérations, les plages d'affichage et les vecteurs de test sont définis dans le **[livrable 01 — Indice de présence](01-indice-de-presence.md)**, qui est la seule source normative du calcul. Ce document n'en redéfinit rien ; il fixe **où et quand** le calcul s'exécute.

* **Le calcul s'exécute localement**, dans le use case `compute_presence_score` (`domain/usecases/`), en Dart pur, à partir des seules données locales (interactions, promesses, souvenirs, dates importantes de la base Drift). La formule étant **déterministe**, deux appareils synchronisés obtiennent le même résultat sans qu'un code serveur partagé soit nécessaire : **la source de vérité de l'indice affiché est le calcul local sur les données locales.** L'indice est ainsi toujours disponible et à jour hors ligne, dès l'enregistrement d'une interaction.
* **Recalcul événementiel** : l'indice d'une relation est recalculé immédiatement après toute mutation qui l'affecte (interaction enregistrée ou supprimée, promesse créée/terminée, souvenir créé, date importante modifiée, arrivée de données au pull de synchronisation). L'implémentation s'appuie sur les flux réactifs de Drift : les providers qui exposent l'indice se réévaluent quand les tables sources changent.
* **Tâche quotidienne** : l'indice décroît avec le temps même sans activité ; un recalcul complet de toutes les relations actives est exécuté une fois par jour (au premier passage au premier plan de la journée, et par tâche de fond planifiée quand la plateforme l'accorde), avec écriture d'un instantané dans `score_snapshots` pour alimenter les graphiques d'évolution.
* **Règles produit rappelées** (PRD) : l'indice est privé, jamais partagé ni envoyé aux proches ; l'affichage utilise exclusivement les libellés du PRD (« Très entretenue » … « Peu entretenue ») ; les relations en mode « En mémoire » et les relations archivées sont **exclues** du calcul et de tout rappel.
* Le serveur n'a pas besoin de l'indice pour l'affichage ; s'il doit en connaître une valeur (par exemple pour moduler une notification), il applique les règles du livrable 01 sur les données synchronisées — sans jamais devenir la source de vérité de ce que l'utilisateur voit.

---

## Récapitulatif des décisions figées

1. Feature-first + clean architecture à trois couches, dépendances orientées vers un domaine en Dart pur.
2. Offline-first intégral : Drift (SQLite chiffré) source de vérité de l'interface, UUID client, suppressions logiques, synchronisation silencieuse par outbox et last-write-wins sur `updated_at`.
3. Riverpod (état + injection, overrides pour les tests), go_router (shell 4 branches + ajout d'interaction en bottom sheet modal), Supabase, RevenueCat, FCM, Sentry, ARB français d'abord, PostHog UE en opt-out.
4. Pipeline média : compression ~2048 px / ~400 Ko + miniature 400 px avant tout upload, envoi en tâche de fond avec reprise.
5. Indice de présence calculé localement (formule du livrable 01), recalcul événementiel + quotidien, instantanés historisés.
