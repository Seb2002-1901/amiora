# AMIORA — Backend Supabase

Référence normative : `docs/sprint-0/06-architecture-supabase.md`.
Région de production : **eu-central-2 (Zurich)**, repli Francfort.
Trois projets distincts : `amiora-dev`, `amiora-staging`, `amiora-prod` —
aucune donnée réelle hors production, jamais de clé `service_role` côté client.

## Mise en route locale

```bash
supabase start          # démarre Postgres + Studio en local
supabase db reset       # rejoue migrations/ (schéma complet + RLS)
supabase functions serve daily-notifications --env-file .env.local
```

## Migrations

- `migrations/20260705000000_init.sql` — schéma initial complet
  (18 tables, enums, index, triggers, 56 politiques RLS, purge).
  Source de vérité : `docs/sprint-0/04-schema.sql` (testé sur PostgreSQL,
  16 assertions). Toute évolution = nouvelle migration datée, jamais de
  modification d'une migration jouée.

## Edge Functions

| Fonction | Déclencheur | Secrets requis |
|---|---|---|
| `daily-notifications` | cron **horaire** (`0 * * * *`) | `FCM_SERVICE_ACCOUNT_JSON` |
| `purge-deleted` | cron quotidien (`30 3 * * *` UTC) | — |
| `revenuecat-webhook` | webhook RevenueCat | `RC_WEBHOOK_SECRET` |
| `export-data` | appel in-app (JWT utilisateur) | — |
| `account-deletion` | appel in-app (JWT utilisateur) | — |

Toutes lisent `SUPABASE_URL` / `SUPABASE_SERVICE_ROLE_KEY` /
`SUPABASE_ANON_KEY` fournis automatiquement par la plateforme.

```bash
supabase functions deploy daily-notifications
supabase secrets set FCM_SERVICE_ACCOUNT_JSON="$(cat firebase-sa.json)"
supabase secrets set RC_WEBHOOK_SECRET="…"
```

Planification (Dashboard → Edge Functions → Schedules, ou pg_cron) :
`daily-notifications` toutes les heures — la fonction ne notifie que les
utilisateurs dont l'heure locale est 09:00 (fuseau dans `settings`),
plafonds 2/jour et 6/semaine, heures silencieuses 22 h-8 h respectées
par construction, jamais de push pour une relation archivée/en mémoire.

## Storage

Buckets **privés** : `media-photos`, `media-thumbnails`, `exports`,
`avatars`. Chemins `{user_id}/{uuid}`, accès par URL signées courtes
(15 min ; 1 h pour les exports). Miniatures générées côté client.
Purge des orphelins et des comptes supprimés : `purge-deleted`.

## Sauvegardes

Production : sauvegardes quotidiennes + **PITR activé au lancement
public** (prix de la promesse « ne jamais perdre les souvenirs ») ;
test de restauration trimestriel documenté dans le journal d'exploitation.

## Sécurité

RLS activée sur toutes les tables (`auth.uid() = user_id`) ; tables
écrites par le serveur (`presence_scores`, `subscriptions`,
`notifications`, `achievements`) en lecture seule pour les clients ;
tests SQL de non-fuite entre deux utilisateurs exécutés en CI
(voir la section tests de la migration initiale).
