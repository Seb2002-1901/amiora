-- ----------------------------------------------------------------------------
-- Migration : souvenirs multi-personnes.
-- Le client permet de lier un souvenir à PLUSIEURS proches (une photo du
-- repas de famille concerne papa, maman et grand-maman). La colonne
-- memories.relationship_id (mono-relation) est conservée comme premier lien
-- pour compatibilité ; la vérité complète vit ici.
-- ----------------------------------------------------------------------------

create table public.memory_links (
  id              uuid primary key,                      -- UUID v5 déterministe (client)
  user_id         uuid not null references public.users (id) on delete cascade,
  memory_id       uuid not null references public.memories (id) on delete cascade,
  relationship_id uuid not null references public.relationships (id) on delete cascade,
  created_at      timestamptz not null default now(),
  updated_at      timestamptz not null default now(),
  deleted_at      timestamptz,
  constraint memory_links_unique unique (memory_id, relationship_id)
);

create index memory_links_memory_idx on public.memory_links (memory_id);
create index memory_links_relationship_idx on public.memory_links (relationship_id);
create index memory_links_user_updated_idx on public.memory_links (user_id, updated_at);

-- Horloge serveur : updated_at posé par le serveur (même trigger que le
-- reste du schéma — fonction définie dans la migration initiale).
create trigger memory_links_updated_at
  before insert or update on public.memory_links
  for each row execute function public.set_updated_at();

-- RLS : privé par utilisateur, comme partout.
alter table public.memory_links enable row level security;

create policy memory_links_select on public.memory_links
  for select using (auth.uid() = user_id);
create policy memory_links_insert on public.memory_links
  for insert with check (auth.uid() = user_id);
create policy memory_links_update on public.memory_links
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy memory_links_delete on public.memory_links
  for delete using (auth.uid() = user_id);
