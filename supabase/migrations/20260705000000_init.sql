-- ============================================================================
-- AMIORA — Migration initiale (20260705000000_init)
-- Reprise intégrale du livrable 4 du Sprint 0 (docs/sprint-0/04-schema.sql),
-- source de vérité du schéma. Cible : PostgreSQL 15, dialecte Supabase
-- (schémas auth / storage gérés par la plateforme).
--
-- Cette migration est appliquée UNE SEULE FOIS par le suivi de migrations du
-- CLI Supabase (supabase db reset / supabase db push) : les instructions non
-- rejouables (create type, create table) n'ont pas besoin de garde-fou
-- supplémentaire. Toute évolution ultérieure passe par un nouveau fichier
-- horodaté (doc 06, § 3.1).
--
-- Écarts par rapport au livrable 4 (corrections d'erreurs manifestes,
-- signalées en revue) :
--   1. Index idx_important_dates_monthday : les expressions extract(...)
--      doivent être parenthésées individuellement (syntaxe PostgreSQL des
--      index d'expression) — sans quoi le script ne s'exécute pas.
--   2. purge_soft_deleted : le REVOKE ... FROM public retirait aussi le droit
--      d'exécution hérité par service_role ; un GRANT explicite est ajouté
--      pour que la fonction planifiée (purge-deleted) puisse l'appeler.
--
-- Références : docs/prd-v1.2.md (PRD de référence),
--              docs/sprint-0/06-architecture-supabase.md (architecture),
--              docs/audit/07-architecture-technique.md (modèle de données),
--              docs/audit/06-score-relationnel-et-gamification.md (indice).
-- Documentation associée : docs/sprint-0/04-schema-de-donnees.md
--
-- Principes appliqués partout :
--   * PK UUID générées côté client (offline-first) ; DEFAULT serveur en filet.
--   * Suppression logique via deleted_at, purge physique à J+30.
--   * updated_at maintenu par trigger (horloge serveur = version de référence
--     pour la synchronisation « dernière écriture gagne »).
--   * user_id sur toutes les tables porteuses de données personnelles,
--     Row Level Security systématique (auth.uid() = user_id).
--   * Identifiants d'énumération en anglais ; libellés français côté app.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 0. Extensions
-- ----------------------------------------------------------------------------

-- gen_random_uuid() est natif depuis PostgreSQL 13 ; pgcrypto est activé par
-- convention Supabase (fonctions de hachage utiles au pipeline média).
create extension if not exists pgcrypto;

-- pg_cron est disponible sur Supabase pour la tâche de purge quotidienne.
-- L'activation et la planification sont faites en fin de script (commentées :
-- l'équipe peut préférer une Edge Function planifiée, voir documentation).
-- create extension if not exists pg_cron;

-- ----------------------------------------------------------------------------
-- 1. Types énumérés
--    Identifiants anglais (stockage) ; les libellés français vivent côté app.
-- ----------------------------------------------------------------------------

-- Types d'interactions (PRD : Appel · Message · Repas · Sortie · Voyage ·
-- Visite · Cadeau · Moment ensemble · Photo souvenir · Événement important).
create type public.interaction_type as enum (
  'call', 'message', 'meal', 'outing', 'trip',
  'visit', 'gift', 'moment', 'photo', 'event'
);

-- Catégories de relations (PRD : Partenaire · Famille · Amis · Enfants ·
-- Mentor · Professionnel · Autres).
create type public.relationship_category as enum (
  'partner', 'family', 'friend', 'child', 'mentor', 'professional', 'other'
);

-- Statut d'une relation : active, archivée, ou « En mémoire » (personne
-- décédée : indice gelé, notifications coupées, souvenirs mis en valeur).
create type public.relationship_status as enum (
  'active', 'archived', 'in_memoriam'
);

-- États d'une promesse (PRD : à faire · en cours · terminée).
create type public.promise_status as enum (
  'todo', 'in_progress', 'done'
);

-- Qualité ressentie d'une interaction (saisie facultative).
create type public.interaction_quality as enum (
  'difficult', 'okay', 'good', 'excellent'
);

-- Types de souvenirs.
create type public.memory_type as enum (
  'photo', 'note', 'album'
);

-- Types de dates importantes (PRD : anniversaire, première rencontre,
-- premier rendez-vous, mariage, fiançailles, naissance, diplôme, personnalisé).
create type public.important_date_type as enum (
  'birthday', 'first_meeting', 'first_date', 'wedding',
  'engagement', 'birth', 'graduation', 'custom'
);

-- Type technique : statut d'upload d'un média (clé du fonctionnement
-- hors ligne — un média est visible localement avant d'être envoyé).
create type public.media_upload_status as enum (
  'pending', 'uploaded', 'failed'
);

-- ----------------------------------------------------------------------------
-- 2. Fonctions utilitaires
-- ----------------------------------------------------------------------------

-- Maintient updated_at à l'horloge SERVEUR sur chaque écriture : toute valeur
-- envoyée par le client est écrasée. C'est la garantie « l'horloge serveur
-- fait foi » de la résolution de conflit last-write-wins.
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

-- ----------------------------------------------------------------------------
-- 3. Tables — identité et compte
-- ----------------------------------------------------------------------------

-- Profil applicatif : complète auth.users (géré par Supabase Auth).
-- Une ligne créée automatiquement à l'inscription (trigger § 6).
create table public.users (
  id            uuid primary key references auth.users (id) on delete cascade,
  email         text,                                   -- copie de commodité (source : auth.users)
  first_name    text,
  last_name     text,
  avatar_url    text,                                   -- chemin Storage (bucket privé, URL signées)
  locale        text        not null default 'fr',
  timezone      text        not null default 'Europe/Zurich', -- indispensable aux notifications « à la bonne heure »
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now(),
  deleted_at    timestamptz                             -- posé à la demande de suppression du compte (délai de grâce 30 j)
);

-- Appareils de l'utilisateur : jetons push (FCM/APNs) et suivi de synchro.
-- Table technique nécessaire au moteur de notifications serveur.
create table public.devices (
  id             uuid primary key default gen_random_uuid(),
  user_id        uuid        not null references public.users (id) on delete cascade,
  platform       text        not null check (platform in ('ios', 'android')),
  push_token     text,                                  -- jeton FCM/APNs courant (peut être nul si push refusé)
  app_version    text,
  last_synced_at timestamptz,                           -- dernière synchronisation complète de cet appareil
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now(),
  deleted_at     timestamptz
);

-- Paramètres utilisateur (une ligne par utilisateur, créée à l'inscription).
-- Porte notamment les préférences de notifications du PRD :
-- heures silencieuses 22 h → 8 h, plafonds 2/jour et 6/semaine.
create table public.settings (
  user_id                    uuid primary key references public.users (id) on delete cascade,
  notifications_enabled      boolean     not null default true,
  quiet_hours_start          time        not null default '22:00',  -- début des heures silencieuses
  quiet_hours_end            time        not null default '08:00',  -- fin (plage à cheval sur minuit : logique serveur)
  max_notifications_per_day  smallint    not null default 2 check (max_notifications_per_day >= 0),
  max_notifications_per_week smallint    not null default 6 check (max_notifications_per_week >= 0),
  hide_scores                boolean     not null default false,    -- masque les indices chiffrés (états qualitatifs seuls)
  extra                      jsonb       not null default '{}'::jsonb, -- réglages additionnels sans migration
  created_at                 timestamptz not null default now(),
  updated_at                 timestamptz not null default now()
);

-- Cache local du statut RevenueCat (source de vérité : RevenueCat, répliqué
-- ici par webhook). Permet au client et aux règles serveur de connaître
-- l'état d'abonnement sans appel réseau vers RevenueCat.
create table public.subscriptions (
  user_id                 uuid primary key references public.users (id) on delete cascade,
  revenuecat_app_user_id  text,
  entitlement             text,                          -- ex. 'premium' ; null si aucun droit actif
  store                   text check (store in ('app_store', 'play_store', 'promotional')),
  is_trial                boolean     not null default false,
  will_renew              boolean     not null default false,
  expires_at              timestamptz,                   -- échéance du droit courant
  is_read_only            boolean     not null default false, -- vrai après expiration : consulter/exporter/supprimer uniquement
  created_at              timestamptz not null default now(),
  updated_at              timestamptz not null default now()
);

-- ----------------------------------------------------------------------------
-- 4. Tables — relations
-- ----------------------------------------------------------------------------

-- Référentiel des catégories de relations : libellé français et cadence
-- d'interaction attendue par défaut (en jours). Table partagée, en lecture
-- seule pour les clients (voir RLS § 8) — c'est l'exception assumée au
-- principe « user_id partout ».
create table public.relationship_categories (
  code                 public.relationship_category primary key,
  label_fr             text     not null,
  default_cadence_days smallint not null check (default_cadence_days between 1 and 365),
  sort_order           smallint not null,
  created_at           timestamptz not null default now()
);

-- Valeurs officielles (cadences par défaut arbitrées au Sprint 0).
insert into public.relationship_categories (code, label_fr, default_cadence_days, sort_order) values
  ('partner',      'Partenaire',    2,  1),
  ('family',       'Famille',       7,  2),
  ('friend',       'Amis',         14,  3),
  ('child',        'Enfants',       3,  4),
  ('mentor',       'Mentor',       30,  5),
  ('professional', 'Professionnel', 30, 6),
  ('other',        'Autres',       30,  7);

-- La « personne » du produit : table centrale des relations.
create table public.relationships (
  id                    uuid primary key default gen_random_uuid(),
  user_id               uuid not null references public.users (id) on delete cascade,
  first_name            text not null,
  last_name             text,
  category              public.relationship_category not null
                          references public.relationship_categories (code),
  status                public.relationship_status not null default 'active',
  photo_url             text,                            -- chemin Storage de la photo de profil
  birthday              date,                            -- dupliquée en important_dates(type 'birthday') par l'app
  phone                 text,
  email                 text,
  address               text,
  job                   text,
  notes                 text,
  expected_cadence_days smallint not null check (expected_cadence_days between 1 and 365),
                          -- cadence d'interaction attendue, personnalisable ;
                          -- remplie depuis le référentiel si absente (trigger § 6)
  notifications_paused  boolean     not null default false, -- pause des rappels pour cette relation uniquement
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now(),
  deleted_at            timestamptz
);

-- Préférences d'une relation, une ligne par domaine : restaurants, loisirs,
-- films, musique, couleurs, fleurs, parfums, idées cadeaux, notes diverses.
-- Le contenu est un tableau JSONB libre (chaînes ou objets {label, note, url}),
-- ce qui évite une table par domaine et simplifie la synchronisation (LWW ligne).
create table public.preferences (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references public.users (id) on delete cascade,
  relationship_id uuid not null references public.relationships (id) on delete cascade,
  kind            text not null check (kind in (
                    'restaurants', 'hobbies', 'movies', 'music', 'colors',
                    'flowers', 'perfumes', 'gift_ideas', 'notes'
                  )),
  content         jsonb       not null default '[]'::jsonb,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  deleted_at      timestamptz
);

-- Dates importantes d'une relation : alimentent le calendrier, la ligne de
-- vie et les rappels d'anniversaire.
create table public.important_dates (
  id               uuid primary key default gen_random_uuid(),
  user_id          uuid not null references public.users (id) on delete cascade,
  relationship_id  uuid not null references public.relationships (id) on delete cascade,
  type             public.important_date_type not null,
  label            text,                                 -- obligatoire pour un événement personnalisé
  date             date not null,
  recurs_annually  boolean     not null default true,    -- récurrence annuelle (anniversaires, mariage…)
  created_at       timestamptz not null default now(),
  updated_at       timestamptz not null default now(),
  deleted_at       timestamptz,
  constraint important_dates_custom_label check (type <> 'custom' or label is not null)
);

-- ----------------------------------------------------------------------------
-- 5. Tables — activité (interactions, événements, promesses)
-- ----------------------------------------------------------------------------

-- L'interaction : fait PASSÉ, cœur du produit (« Ajouter une interaction »).
-- Seuls le type et au moins un participant sont obligatoires ; tout le reste
-- est facultatif (objectif : saisie en moins de 10 secondes).
create table public.interactions (
  id               uuid primary key default gen_random_uuid(),
  user_id          uuid not null references public.users (id) on delete cascade,
  type             public.interaction_type not null,
  occurred_at      timestamptz not null default now(),
  duration_minutes smallint check (duration_minutes > 0), -- facultatif
  quality          public.interaction_quality,            -- facultatif
  location         text,                                  -- facultatif
  note             text,                                  -- facultatif
  created_at       timestamptz not null default now(),
  updated_at       timestamptz not null default now(),
  deleted_at       timestamptz
);

-- Table de liaison : participants d'une interaction (multi-personnes,
-- ex. un repas de famille concerne papa, maman et grand-maman à la fois).
-- user_id est dénormalisé pour porter la RLS sans jointure.
create table public.interaction_participants (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references public.users (id) on delete cascade,
  interaction_id  uuid not null references public.interactions (id) on delete cascade,
  relationship_id uuid not null references public.relationships (id) on delete cascade,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  deleted_at      timestamptz
);

-- Événement de calendrier PLANIFIÉ (le passé consigné vit dans interactions ;
-- un événement réalisé génère une interaction — logique applicative).
create table public.events (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references public.users (id) on delete cascade,
  relationship_id uuid references public.relationships (id) on delete cascade, -- null : événement personnel
  title           text not null,
  description     text,
  location        text,
  starts_at       timestamptz not null,
  ends_at         timestamptz,
  all_day         boolean     not null default false,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  deleted_at      timestamptz,
  constraint events_dates_coherentes check (ends_at is null or ends_at > starts_at)
);

-- Promesses faites à une relation (« réserver un restaurant avec Emma »).
create table public.promises (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references public.users (id) on delete cascade,
  relationship_id uuid not null references public.relationships (id) on delete cascade,
  title           text not null,
  description     text,
  due_date        date,                                  -- échéance facultative
  priority        smallint    not null default 2 check (priority between 1 and 3), -- 1 haute · 2 normale · 3 basse
  status          public.promise_status not null default 'todo',
  completed_at    timestamptz,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  deleted_at      timestamptz,
  constraint promises_completion_coherente check ((status = 'done') = (completed_at is not null))
);

-- ----------------------------------------------------------------------------
-- 6. Tables — souvenirs et médias
-- ----------------------------------------------------------------------------

-- Albums : simples conteneurs de souvenirs.
create table public.albums (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references public.users (id) on delete cascade,
  title       text not null,
  description text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),
  deleted_at  timestamptz
);

-- Souvenirs : photos, notes, albums de moments. La « ligne de vie » n'est pas
-- une table : c'est une vue chronologique construite à partir des souvenirs,
-- des dates importantes et des interactions marquantes.
create table public.memories (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references public.users (id) on delete cascade,
  relationship_id uuid references public.relationships (id) on delete cascade, -- null : souvenir personnel
  album_id        uuid references public.albums (id) on delete set null,
  type            public.memory_type not null,
  title           text,
  body            text,                                  -- texte de la note ou légende
  taken_at        timestamptz not null default now(),    -- date du souvenir (peut être rétroactive)
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  deleted_at      timestamptz
);

-- Fichiers médias d'un souvenir. Le statut d'upload est la clé du hors-ligne :
-- un média créé en montagne est 'pending' jusqu'au retour du réseau, puis
-- envoyé en tâche de fond vers Supabase Storage (bucket privé, URL signées).
create table public.media_assets (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references public.users (id) on delete cascade,
  memory_id       uuid not null references public.memories (id) on delete cascade,
  storage_path    text not null,                         -- chemin dans le bucket (contient l'UUID : unicité garantie)
  thumbnail_path  text,                                  -- miniature (~30 Ko) générée côté client
  mime_type       text,
  file_size_bytes bigint check (file_size_bytes > 0),
  width           integer check (width > 0),
  height          integer check (height > 0),
  upload_status   public.media_upload_status not null default 'pending',
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  deleted_at      timestamptz,
  constraint media_assets_storage_path_unique unique (storage_path)
);

-- ----------------------------------------------------------------------------
-- 7. Tables — moteur serveur (indice, notifications, gamification)
-- ----------------------------------------------------------------------------

-- Instantanés quotidiens de l'indice de présence, calculés par la tâche
-- serveur (jamais par le client). score = valeur AFFICHÉE, après application
-- de la règle de chute plafonnée (−8 points/semaine maximum) ; raw_score =
-- calcul brut de la formule ; components = détail des composantes
-- (dernière interaction, régularité, temps passé, promesses, souvenirs,
-- dates importantes) pour l'historique et le débogage.
create table public.presence_scores (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references public.users (id) on delete cascade,
  relationship_id uuid not null references public.relationships (id) on delete cascade,
  snapshot_date   date not null,
  score           smallint not null check (score between 0 and 100),
  raw_score       smallint not null check (raw_score between 0 and 100),
  components      jsonb    not null default '{}'::jsonb,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  deleted_at      timestamptz,
  constraint presence_scores_un_par_jour unique (relationship_id, snapshot_date)
);

-- Journal des notifications envoyées. Écrit par le moteur serveur ; sert à
-- appliquer les plafonds (2/jour, 6/semaine) et à mesurer l'engagement.
-- Les préférences vivent dans settings (globales) et relationships
-- (notifications_paused, par relation).
create table public.notifications (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references public.users (id) on delete cascade,
  relationship_id uuid references public.relationships (id) on delete set null, -- journal conservé si la relation disparaît
  kind            text not null,                         -- ex. 'reminder', 'birthday', 'promise', 'memory_of_day'
  title           text not null,
  body            text,
  channel         text not null default 'push' check (channel in ('push', 'email')),
  sent_at         timestamptz not null default now(),
  opened_at       timestamptz,                           -- renseigné par le client à l'ouverture
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now()
);

-- Succès débloqués — préparatoire V1.1 (badges, défis). Volontairement
-- minimal : le référentiel des badges et la progression viendront en V1.1.
create table public.achievements (
  id              uuid primary key default gen_random_uuid(),
  user_id         uuid not null references public.users (id) on delete cascade,
  relationship_id uuid references public.relationships (id) on delete set null,
  code            text not null,                         -- identifiant du badge (référentiel V1.1)
  unlocked_at     timestamptz not null default now(),
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  constraint achievements_unique_par_code unique (user_id, code)
);

-- ----------------------------------------------------------------------------
-- 8. Triggers updated_at (horloge serveur qui fait foi)
-- ----------------------------------------------------------------------------

do $$
declare
  t text;
begin
  foreach t in array array[
    'users', 'devices', 'settings', 'subscriptions',
    'relationships', 'preferences', 'important_dates',
    'interactions', 'interaction_participants', 'events', 'promises',
    'albums', 'memories', 'media_assets',
    'presence_scores', 'notifications', 'achievements'
  ]
  loop
    execute format(
      'create trigger %I before update on public.%I
         for each row execute function public.set_updated_at()',
      'trg_' || t || '_updated_at', t
    );
  end loop;
end;
$$;

-- ----------------------------------------------------------------------------
-- 9. Triggers métier
-- ----------------------------------------------------------------------------

-- 9.1 Cadence attendue par défaut : si le client n'envoie pas de cadence
--     (ou envoie null pour « revenir au défaut »), elle est remplie depuis
--     le référentiel des catégories AVANT le contrôle NOT NULL.
create or replace function public.set_default_cadence()
returns trigger
language plpgsql
as $$
begin
  if new.expected_cadence_days is null then
    select rc.default_cadence_days
      into new.expected_cadence_days
      from public.relationship_categories rc
     where rc.code = new.category;
  end if;
  return new;
end;
$$;

create trigger trg_relationships_default_cadence
  before insert or update on public.relationships
  for each row execute function public.set_default_cadence();

-- 9.2 Cascade de suppression logique : supprimer une relation supprime
--     logiquement ses données rattachées, avec le MÊME horodatage (ce qui
--     permet une restauration cohérente pendant le délai de grâce).
--     Cas particulier des interactions multi-personnes : seule la
--     participation de la relation supprimée est retirée ; l'interaction
--     elle-même n'est supprimée que si plus aucun participant actif ne reste.
create or replace function public.cascade_soft_delete_relationship()
returns trigger
language plpgsql
as $$
begin
  update public.preferences
     set deleted_at = new.deleted_at
   where relationship_id = new.id and deleted_at is null;

  update public.important_dates
     set deleted_at = new.deleted_at
   where relationship_id = new.id and deleted_at is null;

  update public.promises
     set deleted_at = new.deleted_at
   where relationship_id = new.id and deleted_at is null;

  update public.events
     set deleted_at = new.deleted_at
   where relationship_id = new.id and deleted_at is null;

  -- Les souvenirs liés partent avec la relation (leurs médias suivent via 9.3).
  update public.memories
     set deleted_at = new.deleted_at
   where relationship_id = new.id and deleted_at is null;

  update public.presence_scores
     set deleted_at = new.deleted_at
   where relationship_id = new.id and deleted_at is null;

  -- Retire les participations de la relation…
  update public.interaction_participants
     set deleted_at = new.deleted_at
   where relationship_id = new.id and deleted_at is null;

  -- …puis supprime logiquement les interactions devenues orphelines.
  update public.interactions i
     set deleted_at = new.deleted_at
   where i.user_id = new.user_id
     and i.deleted_at is null
     and not exists (
       select 1
         from public.interaction_participants ip
        where ip.interaction_id = i.id
          and ip.deleted_at is null
     );

  return null;
end;
$$;

create trigger trg_relationships_cascade_soft_delete
  after update of deleted_at on public.relationships
  for each row
  when (new.deleted_at is not null and old.deleted_at is null)
  execute function public.cascade_soft_delete_relationship();

-- 9.3 Un souvenir supprimé emporte ses médias.
create or replace function public.cascade_soft_delete_memory()
returns trigger
language plpgsql
as $$
begin
  update public.media_assets
     set deleted_at = new.deleted_at
   where memory_id = new.id and deleted_at is null;
  return null;
end;
$$;

create trigger trg_memories_cascade_soft_delete
  after update of deleted_at on public.memories
  for each row
  when (new.deleted_at is not null and old.deleted_at is null)
  execute function public.cascade_soft_delete_memory();

-- 9.4 Une interaction supprimée emporte ses participations.
create or replace function public.cascade_soft_delete_interaction()
returns trigger
language plpgsql
as $$
begin
  update public.interaction_participants
     set deleted_at = new.deleted_at
   where interaction_id = new.id and deleted_at is null;
  return null;
end;
$$;

create trigger trg_interactions_cascade_soft_delete
  after update of deleted_at on public.interactions
  for each row
  when (new.deleted_at is not null and old.deleted_at is null)
  execute function public.cascade_soft_delete_interaction();

-- 9.5 Création automatique du profil et des paramètres à l'inscription
--     (motif standard Supabase : trigger sur auth.users, SECURITY DEFINER).
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.users (id, email) values (new.id, new.email);
  insert into public.settings (user_id) values (new.id);
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ----------------------------------------------------------------------------
-- 10. Purge définitive à J+30 (tâche serveur quotidienne)
-- ----------------------------------------------------------------------------

-- Supprime PHYSIQUEMENT tout ce qui est logiquement supprimé depuis plus de
-- 30 jours. Les FK ON DELETE CASCADE garantissent l'intégrité : la purge d'une
-- relation emporte ses dernières lignes filles (cascadées au même horodatage).
-- IMPORTANT : les objets Supabase Storage des media_assets purgés doivent être
-- supprimés AVANT l'appel (Edge Function : lister les media_assets expirés,
-- effacer les fichiers, puis appeler cette fonction).
create or replace function public.purge_soft_deleted(retention interval default interval '30 days')
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  cutoff timestamptz := now() - retention;
begin
  delete from public.media_assets             where deleted_at < cutoff;
  delete from public.memories                 where deleted_at < cutoff;
  delete from public.interaction_participants where deleted_at < cutoff;
  delete from public.interactions             where deleted_at < cutoff;
  delete from public.preferences              where deleted_at < cutoff;
  delete from public.important_dates          where deleted_at < cutoff;
  delete from public.events                   where deleted_at < cutoff;
  delete from public.promises                 where deleted_at < cutoff;
  delete from public.presence_scores          where deleted_at < cutoff;
  delete from public.albums                   where deleted_at < cutoff;
  delete from public.relationships            where deleted_at < cutoff;
  delete from public.devices                  where deleted_at < cutoff;

  -- Suppression de compte (RGPD/nLPD) : à l'issue du délai de grâce, la
  -- suppression de auth.users cascade sur l'intégralité du schéma public.
  delete from auth.users u
   where u.id in (select id from public.users where deleted_at < cutoff);
end;
$$;

-- Planification quotidienne (à activer avec pg_cron, ou remplacer par une
-- Edge Function planifiée qui gère aussi le nettoyage Storage) :
-- select cron.schedule('amiora-purge-quotidienne', '30 3 * * *',
--                      $$select public.purge_soft_deleted();$$);

-- La purge est réservée au serveur : on révoque l'exécution accordée par
-- défaut à PUBLIC (la fonction est SECURITY DEFINER, prudence obligatoire).
revoke execute on function public.purge_soft_deleted(interval) from public, anon, authenticated;

-- ----------------------------------------------------------------------------
-- 11. Index
-- ----------------------------------------------------------------------------

-- Relations de l'utilisateur (listes filtrées par statut).
create index idx_relationships_user        on public.relationships (user_id) where deleted_at is null;
create index idx_relationships_user_status on public.relationships (user_id, status) where deleted_at is null;

-- Interactions par relation et par date (fiche relation, historique, indice) :
-- jointure participants → interactions triées par occurred_at.
create index idx_interactions_user_date  on public.interactions (user_id, occurred_at desc) where deleted_at is null;
create index idx_participants_relation   on public.interaction_participants (relationship_id, interaction_id) where deleted_at is null;
create index idx_participants_interaction on public.interaction_participants (interaction_id) where deleted_at is null;

-- Événements par date (vues jour/semaine/mois du calendrier).
create index idx_events_user_date on public.events (user_id, starts_at) where deleted_at is null;
create index idx_events_relation  on public.events (relationship_id) where deleted_at is null;

-- Souvenirs par relation et par date (chronologie, ligne de vie).
create index idx_memories_relation_date on public.memories (relationship_id, taken_at desc) where deleted_at is null;
create index idx_memories_user_date     on public.memories (user_id, taken_at desc) where deleted_at is null;
create index idx_memories_album         on public.memories (album_id) where deleted_at is null;

-- Médias : par souvenir, et file d'upload en attente (moteur de synchro).
create index idx_media_memory  on public.media_assets (memory_id) where deleted_at is null;
create index idx_media_pending on public.media_assets (user_id) where upload_status = 'pending' and deleted_at is null;

-- Dates importantes : par relation, et par jour/mois pour le balayage
-- quotidien des anniversaires par le moteur de notifications.
create index idx_important_dates_relation on public.important_dates (relationship_id) where deleted_at is null;
create index idx_important_dates_monthday on public.important_dates
  (user_id, extract(month from date), extract(day from date)) where deleted_at is null;

-- Promesses : listes par statut et échéance, et par relation.
create index idx_promises_user_status on public.promises (user_id, status, due_date) where deleted_at is null;
create index idx_promises_relation    on public.promises (relationship_id) where deleted_at is null;

-- Indice de présence : historique par relation (l'unicité (relationship_id,
-- snapshot_date) sert déjà d'index de parcours) et balayage par utilisateur.
create index idx_scores_user_date on public.presence_scores (user_id, snapshot_date desc) where deleted_at is null;

-- Notifications : journal récent (application des plafonds 2/jour, 6/semaine).
create index idx_notifications_user_sent on public.notifications (user_id, sent_at desc);

-- Unicités partielles (compatibles avec la suppression logique : une ligne
-- supprimée ne bloque pas la re-création).
create unique index uq_preferences_relation_kind on public.preferences (relationship_id, kind) where deleted_at is null;
create unique index uq_participants_interaction_relation on public.interaction_participants (interaction_id, relationship_id) where deleted_at is null;

-- Index de synchronisation : le pull incrémental de chaque appareil lit
-- « mes lignes modifiées depuis mon dernier passage » (user_id, updated_at).
do $$
declare
  t text;
begin
  foreach t in array array[
    'relationships', 'preferences', 'important_dates',
    'interactions', 'interaction_participants', 'events', 'promises',
    'albums', 'memories', 'media_assets',
    'presence_scores', 'notifications', 'achievements'
  ]
  loop
    execute format(
      'create index %I on public.%I (user_id, updated_at)',
      'idx_' || t || '_sync', t
    );
  end loop;
end;
$$;

-- ----------------------------------------------------------------------------
-- 12. Droits d'accès et Row Level Security
-- ----------------------------------------------------------------------------

-- Droits de niveau table (Supabase les pose par défaut ; on les rend
-- explicites pour que le script soit autoporteur). Le filtrage fin par
-- ligne est assuré par la RLS ci-dessous : une table sans politique
-- d'écriture reste ininscriptible même avec ces GRANT.
grant usage on schema public to anon, authenticated, service_role;
grant select, insert, update, delete on all tables in schema public to authenticated, service_role;

-- Activation de la RLS sur TOUTES les tables : aucune ligne n'est lisible ni
-- modifiable sans politique explicite. Le rôle service (tâches serveur,
-- webhooks) contourne la RLS par construction.
alter table public.users                    enable row level security;
alter table public.devices                  enable row level security;
alter table public.settings                 enable row level security;
alter table public.subscriptions            enable row level security;
alter table public.relationship_categories  enable row level security;
alter table public.relationships            enable row level security;
alter table public.preferences              enable row level security;
alter table public.important_dates          enable row level security;
alter table public.interactions             enable row level security;
alter table public.interaction_participants enable row level security;
alter table public.events                   enable row level security;
alter table public.promises                 enable row level security;
alter table public.albums                   enable row level security;
alter table public.memories                 enable row level security;
alter table public.media_assets             enable row level security;
alter table public.presence_scores          enable row level security;
alter table public.notifications            enable row level security;
alter table public.achievements             enable row level security;

-- 12.1 Tables de contenu détenues par l'utilisateur : politiques uniformes
--      select / insert / update / delete restreintes à auth.uid() = user_id.
do $$
declare
  t text;
begin
  foreach t in array array[
    'devices',
    'relationships', 'preferences', 'important_dates',
    'interactions', 'interaction_participants', 'events', 'promises',
    'albums', 'memories', 'media_assets'
  ]
  loop
    execute format(
      'create policy %I on public.%I for select to authenticated using (auth.uid() = user_id)',
      t || '_select_proprietaire', t);
    execute format(
      'create policy %I on public.%I for insert to authenticated with check (auth.uid() = user_id)',
      t || '_insert_proprietaire', t);
    execute format(
      'create policy %I on public.%I for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id)',
      t || '_update_proprietaire', t);
    execute format(
      'create policy %I on public.%I for delete to authenticated using (auth.uid() = user_id)',
      t || '_delete_proprietaire', t);
  end loop;
end;
$$;

-- 12.2 Profil : chacun voit et modifie uniquement sa ligne (id = auth.uid()).
--      Pas de politique delete : la suppression de compte passe par le
--      serveur (délai de grâce, purge auth.users).
create policy users_select_proprietaire on public.users
  for select to authenticated using (auth.uid() = id);
create policy users_insert_proprietaire on public.users
  for insert to authenticated with check (auth.uid() = id);
create policy users_update_proprietaire on public.users
  for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

-- 12.3 Paramètres : lecture/écriture par le propriétaire (la ligne est créée
--      à l'inscription ; l'insert reste permis en filet de sécurité).
create policy settings_select_proprietaire on public.settings
  for select to authenticated using (auth.uid() = user_id);
create policy settings_insert_proprietaire on public.settings
  for insert to authenticated with check (auth.uid() = user_id);
create policy settings_update_proprietaire on public.settings
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- 12.4 Référentiel des catégories : lecture seule pour tout utilisateur
--      connecté ; écriture réservée au rôle service (migrations).
create policy categories_select_authentifie on public.relationship_categories
  for select to authenticated using (true);

-- 12.5 Tables écrites par le serveur uniquement : le client LIT ses lignes,
--      il ne les écrit jamais (l'absence volontaire de politique insert/
--      update/delete vaut interdiction — décision de sécurité documentée).
create policy subscriptions_select_proprietaire on public.subscriptions
  for select to authenticated using (auth.uid() = user_id);      -- écrit par le webhook RevenueCat

create policy scores_select_proprietaire on public.presence_scores
  for select to authenticated using (auth.uid() = user_id);      -- écrit par la tâche quotidienne de l'indice

create policy achievements_select_proprietaire on public.achievements
  for select to authenticated using (auth.uid() = user_id);      -- écrit par le moteur de gamification (V1.1)

-- Notifications : lecture du journal + marquage « ouverte » par le client.
create policy notifications_select_proprietaire on public.notifications
  for select to authenticated using (auth.uid() = user_id);
create policy notifications_update_proprietaire on public.notifications
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- ============================================================================
-- Fin du schéma. Restent à la charge de l'implémentation (voir documentation) :
--   * création du bucket Storage privé « media » et de ses politiques,
--   * Edge Functions (indice quotidien, moteur de notifications, purge + Storage),
--   * webhook RevenueCat → subscriptions,
--   * application du mode lecture seule après expiration de l'abonnement.
-- ============================================================================
