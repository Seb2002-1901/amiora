# Sprint 0 — Livrable 6 : Architecture Supabase définitive

* **Statut : NORMATIF** — ce document fixe l'architecture backend de la V1. Toute dérogation exige une décision écrite et une mise à jour du présent document.
* **Références :** [PRD V1.2](../prd-v1.2.md) · [Audit ch. 7 — Architecture technique](../audit/07-architecture-technique.md) · [Audit ch. 9 — Confidentialité, sécurité, conformité](../audit/09-confidentialite-securite-conformite.md) · Livrable 4 du Sprint 0 (`04-schema.sql`, schéma de données).
* **Rappel de contexte :** AMIORA héberge l'un des contenus les plus intimes qu'une application grand public puisse détenir (journal relationnel, photos de famille, données de tiers non consentants). L'architecture ci-dessous traite cette sensibilité comme une contrainte de premier rang, au même titre que le fonctionnement hors ligne.

---

## 1. Environnements

### 1.1 Trois projets Supabase distincts

| Environnement | Projet | Usage | Plan |
|---|---|---|---|
| Développement | `amiora-dev` | Travail quotidien, données factices uniquement | Gratuit |
| Recette | `amiora-staging` | Validation des migrations et des Edge Functions avant production, tests de bout en bout (TestFlight / piste interne Play) | Gratuit au départ, Pro si les limites gênent la recette |
| Production | `amiora-prod` | Utilisateurs réels | **Pro** dès l'ouverture de la bêta externe |

Règles d'usage :

* **Aucune donnée réelle hors production.** Les jeux de données de dev et de staging sont générés (script de seed versionné). Il est interdit de copier des données de production vers un autre environnement.
* **Promotion unidirectionnelle** : une migration ou une fonction est appliquée à dev, puis à staging, puis à prod, jamais dans un autre ordre. La production n'est modifiée que par la CI (voir § 3.1), jamais à la main dans le tableau de bord (exceptions : incident, documenté a posteriori dans le journal d'exploitation).
* Les trois projets vivent dans la même organisation Supabase, avec accès nominatif (pas de compte partagé) et double authentification obligatoire sur l'organisation.

### 1.2 Région d'hébergement

**Décision : les trois projets sont créés en région `eu-central-2` (Zurich).** Si cette région n'était pas disponible à la création, repli sur `eu-central-1` (Francfort). Justification : l'audit (ch. 9, P0 n° 5) exige un hébergement Suisse ou UE pour des données personnelles sensibles ; Zurich permet en outre l'argument « vos souvenirs restent en Suisse », cohérent avec le positionnement. La région est identique pour les trois environnements afin que les comportements (latence, quotas) soient comparables.

Tout sous-traitant additionnel (e-mail transactionnel, monitoring) est choisi UE/CH ou couvert par un DPA avec clauses de transfert conformes ; la liste des sous-traitants est tenue dans le registre des traitements (livrable conformité).

### 1.3 Gestion des secrets

**Aucun secret ne vit dans le dépôt.** Le fichier `.gitignore` exclut `.env*` ; un fichier `.env.example` documente les variables attendues sans valeur.

| Secret | Où il vit | Qui y accède |
|---|---|---|
| Clé `anon` (publique par conception) | Configuration de build Flutter par environnement (`--dart-define`) | Application mobile — protégée exclusivement par la RLS |
| Clé `service_role` | Secrets des Edge Functions (`supabase secrets set`) et secrets GitHub Actions | Fonctions serveur et CI uniquement. **Jamais dans le client, jamais dans le dépôt.** |
| Compte de service FCM | Secrets des Edge Functions | `daily-notifications` et fonctions d'envoi push |
| Secret du webhook RevenueCat | Secrets des Edge Functions | `revenuecat-webhook` |
| Identifiants SMTP (e-mail transactionnel) | Configuration Auth du projet | Supabase Auth |
| Jetons d'accès Supabase (CI) | Secrets GitHub Actions | Pipeline de déploiement |

Rotation : toute clé exposée par erreur est révoquée immédiatement ; une rotation planifiée des secrets serveur (FCM, webhook, SMTP) est effectuée au minimum une fois par an et à chaque départ d'une personne ayant eu accès.

---

## 2. Authentification (Supabase Auth)

### 2.1 Fournisseurs

Conformément au PRD : **Sign in with Apple**, **Google Sign-In**, **e-mail + mot de passe**. Aucun autre fournisseur en V1. Apple est obligatoire côté App Store dès lors que Google est proposé. Le lien de plusieurs identités vers un même compte (mêmes adresses e-mail) suit le comportement standard de Supabase Auth (fusion sur e-mail vérifié).

Politique e-mail + mot de passe :

* longueur minimale 12 caractères, vérification contre les mots de passe compromis activée (option HIBP de Supabase Auth) ;
* **confirmation d'e-mail obligatoire** avant toute synchronisation de données ;
* e-mails transactionnels (confirmation, réinitialisation, changement d'adresse) envoyés via un SMTP dédié hébergé UE, avec gabarits aux couleurs d'AMIORA — le SMTP par défaut de Supabase n'est pas utilisé en production.

### 2.2 Mot de passe oublié

Flux standard Supabase : demande depuis l'écran de connexion → e-mail contenant un lien profond (`amiora://reset-password`) → écran in-app de saisie du nouveau mot de passe. Les liens de réinitialisation expirent après 1 heure ; la demande est limitée en fréquence (protection intégrée d'Auth, complétée par le rate limiting § 8.4). La réinitialisation révoque toutes les sessions actives du compte.

### 2.3 Sessions et jetons

* **Jeton d'accès (JWT)** : durée de vie **1 heure**.
* **Refresh token** : **rotation activée** (chaque rafraîchissement émet un nouveau jeton et invalide l'ancien, avec l'intervalle de réutilisation par défaut pour tolérer les rafraîchissements concurrents du mobile) ; **expiration par inactivité : 90 jours** — un utilisateur qui n'ouvre pas l'application pendant 90 jours doit se reconnecter, ce qui est le bon compromis pour une application mobile intime (l'appareil reste la surface d'attaque principale).
* Les jetons sont stockés dans le trousseau sécurisé de la plateforme (Keychain / Keystore via `flutter_secure_storage`), jamais en clair.
* **Déconnexion à distance** : la déconnexion d'un appareil révoque sa session côté serveur ; la table `devices` (livrable 4) permet de lister et de révoquer les appareils depuis les Paramètres.

### 2.4 Mapping vers la table `users`

À l'insertion d'une ligne dans `auth.users`, un **trigger** crée la ligne miroir dans `public.users` (profil applicatif : locale, fuseau horaire, statut d'abonnement dénormalisé…). La fonction est `SECURITY DEFINER`, définie dans les migrations du dépôt :

```sql
create function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = '' as $$
begin
  insert into public.users (id, email, locale, timezone)
  values (new.id, new.email, 'fr', 'Europe/Zurich'); -- valeurs par défaut, mises à jour au premier lancement
  return new;
end $$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
```

Le fuseau horaire réel est envoyé par l'application au premier lancement puis à chaque changement détecté : il conditionne les notifications « 9 h locale » (§ 5.1).

### 2.5 Suppression de compte in-app

Exigence Apple et Google, et exigence RGPD/nLPD. La suppression est **orchestrée exclusivement par la fonction dédiée `account-deletion`** (§ 5.5) : le client n'a aucun droit de suppression directe sur `auth.users`. Le parcours in-app (Paramètres → Supprimer mon compte) demande une ré-authentification récente, affiche clairement le sort des données (délai de grâce de 30 jours, puis purge définitive et irréversible, médias compris), puis appelle la fonction. Un chemin de suppression accessible depuis le web (page d'aide pointant vers une demande authentifiée) est publié pour satisfaire l'exigence Google Play.

---

## 3. Base de données (PostgreSQL)

### 3.1 Le schéma vit dans les migrations du dépôt

Le schéma de données est défini par le **livrable 4 du Sprint 0 (`04-schema.sql`)** et n'est pas redéfini ici. Règles d'exploitation :

* Le schéma est versionné sous `supabase/migrations/` ; **toute** évolution passe par un fichier de migration horodaté, relu en revue de code. Le tableau de bord SQL de production n'est jamais utilisé pour du DDL.
* La CI (GitHub Actions) applique les migrations : automatiquement sur dev à chaque fusion, sur staging à la demande, sur prod après validation manuelle (environnement GitHub protégé).
* Les migrations sont **additives et réversibles** autant que possible ; toute migration destructrice (suppression de colonne, changement de type) est précédée d'une sauvegarde vérifiée et d'une note d'exploitation.
* Rappels structurants hérités du livrable 4 : identifiants **UUID générés côté client** (création hors ligne), colonnes `created_at` / `updated_at` / `deleted_at` partout (suppression logique, nécessaire à la synchronisation), fuseau horaire sur `users`, table `devices` pour le push.

### 3.2 Row Level Security : tout est privé par défaut

Doctrine unique, sans exception :

1. **RLS activée sur toutes les tables** du schéma `public`, y compris les référentiels. Une table sans politique est illisible et inécrivable : c'est l'état par défaut voulu.
2. **Politique type pour les tables utilisateur** — chaque table porteuse de données personnelles porte une colonne `user_id` (directe ou dénormalisée depuis la table parente, choix acté au livrable 4 précisément pour garder des politiques triviales) :

```sql
alter table public.relationships enable row level security;

create policy "owner_select" on public.relationships
  for select using (auth.uid() = user_id);
create policy "owner_insert" on public.relationships
  for insert with check (auth.uid() = user_id);
create policy "owner_update" on public.relationships
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "owner_delete" on public.relationships
  for delete using (auth.uid() = user_id);
```

3. **Référentiels** (badges, types, défis) : `select` ouvert aux utilisateurs authentifiés, aucune écriture cliente.
4. **Tables gérées par le serveur** (`subscriptions`, `notification_log`, `exports`, `audit_log`) : lecture par le propriétaire quand elle a un sens produit, **aucune écriture cliente** — seules les fonctions serveur écrivent.
5. **Mode lecture seule après expiration de l'abonnement** (PRD : consulter, exporter, supprimer — mais ni créer ni modifier) : appliqué **en base**, pas seulement dans l'interface. Les politiques `insert`/`update` des tables de contenu incluent la condition d'abonnement actif (fonction SQL `public.can_write(auth.uid())` s'appuyant sur le statut dénormalisé de `users`, mis à jour par `revenuecat-webhook`). La suppression et la lecture restent permises.

### 3.3 Rôles de service

* Les Edge Functions qui doivent franchir la RLS (purge, suppression de compte, webhook, notifications) utilisent la clé `service_role` **injectée en secret de fonction**.
* Principe du moindre privilège : les fonctions qui n'ont pas besoin de franchir la RLS (p. ex. `export-data`, qui n'exporte que les données de l'appelant) s'exécutent avec le JWT de l'utilisateur appelant, transmis par l'application.
* Aucune API interne ne s'exécute en `service_role` « par confort » : chaque usage de la clé service est justifié dans l'en-tête du fichier de la fonction et tracé dans `audit_log` (§ 8.6).

---

## 4. Storage

### 4.1 Buckets

Quatre buckets, **tous privés** — aucune URL publique, jamais, pour aucun média :

| Bucket | Contenu | Taille max/objet | Types MIME admis |
|---|---|---|---|
| `media-photos` | Photos compressées côté client (~2048 px de bord long, JPEG/WebP qualité ~80 %) | **5 Mo** (garde-fou ; la cible client est 300-500 Ko) | `image/jpeg`, `image/webp` |
| `media-thumbnails` | Miniatures générées côté client (~300 px, ~30 Ko) | **300 Ko** | `image/jpeg`, `image/webp` |
| `avatars` | Photos de profil des relations et de l'utilisateur (déjà recadrées/compressées) | **1 Mo** | `image/jpeg`, `image/webp` |
| `exports` | Archives d'export (JSON + médias zippés), écrites par la fonction `export-data` | **5 Go** | `application/zip` |

Les limites de taille et de type MIME sont configurées **au niveau du bucket** (appliquées par Supabase à l'upload), pas seulement dans le client.

### 4.2 Chemins et politiques d'accès

Convention de chemin unique : **`{user_id}/{uuid}.{ext}`** — le premier segment est l'UUID du propriétaire, le nom de fichier est l'UUID de la ligne `media_assets` correspondante (jamais le nom de fichier d'origine, jamais d'information personnelle dans le chemin).

Politiques RLS sur `storage.objects`, mêmes principes qu'en base :

```sql
create policy "media_owner_all" on storage.objects
  for all using (
    bucket_id in ('media-photos','media-thumbnails','avatars')
    and (storage.foldername(name))[1] = auth.uid()::text
  ) with check (
    bucket_id in ('media-photos','media-thumbnails','avatars')
    and (storage.foldername(name))[1] = auth.uid()::text
  );
-- exports : lecture seule pour le propriétaire, écriture réservée au serveur
create policy "exports_owner_read" on storage.objects
  for select using (
    bucket_id = 'exports'
    and (storage.foldername(name))[1] = auth.uid()::text
  );
```

L'upload de médias est soumis à la même règle de lecture seule que la base (§ 3.2, point 5) : un abonnement expiré ne peut plus téléverser.

### 4.3 Accès exclusivement par URL signées

Le client n'accède **jamais** aux objets par URL directe : il demande des **URL signées à durée courte** — **15 minutes** pour les photos, miniatures et avatars (avec signature par lots pour les grilles), **1 heure** pour les archives d'export (téléchargement volumineux). Les URL signées ne sont jamais persistées côté client au-delà de leur durée de vie ; le cache local d'images de l'application (chiffré, voir livrable sécurité mobile) est indexé par l'UUID du média, pas par l'URL.

### 4.4 Stratégie de miniatures

Décision (audit ch. 7, R4) : **les miniatures sont générées côté client au moment de la capture**, en même temps que la compression de l'original, et téléversées séparément dans `media-thumbnails`. Les grilles (écran Souvenirs, fiches) n'affichent que des miniatures ; l'original n'est téléchargé qu'à l'ouverture plein écran. Les transformations d'images serveur de Supabase ne sont pas utilisées en V1 (coût et dépendance évitables puisque le client produit déjà les deux variantes) ; la décision sera revue si des tailles supplémentaires deviennent nécessaires.

### 4.5 Quotas et nettoyage des orphelins

* **Quotas appliqués côté serveur** : l'espace consommé par utilisateur est suivi via `media_assets.taille` ; le plafond (défini par la politique produit du PRD — pas de plan gratuit, quota généreux anti-abus de l'ordre de plusieurs dizaines de Go, à fixer au livrable monétisation) est vérifié à l'enregistrement du média. Le quota est un garde-fou contre l'abus (vidéos hors périmètre V1, scripts), pas une frontière commerciale.
* **Nettoyage des orphelins** : la tâche `purge-deleted` (§ 5.2) supprime chaque jour (1) les objets Storage dont la ligne `media_assets` est purgée, (2) les lignes `media_assets` en statut « en attente d'upload » depuis plus de 30 jours sans objet correspondant, (3) les archives du bucket `exports` de plus de 7 jours.

---

## 5. Edge Functions

Six principes communs : code TypeScript (Deno) versionné sous `supabase/functions/`, déployé par la CI ; secrets injectés par l'environnement ; idempotence (une exécution rejouée ne produit pas de doublon) ; journalisation minimale dans `audit_log` (§ 8.6) ; aucune donnée personnelle dans les logs techniques ; rate limiting (§ 8.4).

### 5.1 `daily-notifications`

* **Déclencheur :** cron **horaire** (`pg_cron` → invocation HTTP de la fonction), à la minute 0.
* **Rôle :** moteur des rappels bienveillants — sélectionne à chaque passage les utilisateurs dont l'heure locale est 9 h, calcule les notifications candidates, applique la politique du PRD, envoie via FCM.

```text
pour chaque user où heure_locale(user.timezone) == 9h
    et push activé et abonnement ≠ supprimé :
  candidates = []
  candidates += anniversaires à J-7, J-3, J0        # priorité 1
  candidates += promesses échues ou échéance J0      # priorité 2
  candidates += relations « à entretenir »           # priorité 3 (indice de présence, livrable 5)
  exclure : relations archivées, statut « En mémoire »
  filtrer par plafonds (notification_log) :
      envoyées_aujourdhui < 2  ET  envoyées_7_derniers_jours < 6
  garde-fou heures silencieuses : n'envoyer qu'entre 8h et 22h locales
  retenir au plus (2 - envoyées_aujourdhui) candidates, par priorité décroissante
  envoyer via FCM (jeton(s) de la table devices) ; consigner dans notification_log
```

Le passage horaire (et non quotidien) est ce qui permet le « 9 h locale » pour tous les fuseaux. Les plafonds **2/jour et 6/semaine** et les **heures silencieuses 22 h → 8 h** sont appliqués ici, côté serveur, quelle que soit l'origine de la notification. La formule de l'Indice de présence et les seuils « à entretenir » sont normés par le livrable 5 du Sprint 0.

### 5.2 `purge-deleted`

* **Déclencheur :** cron **quotidien** (4 h UTC).
* **Rôle :** purge définitive différée — la contrepartie du délai de grâce de 30 jours.

```text
# 1. Contenus supprimés logiquement (deleted_at) depuis > 30 jours
pour chaque table de contenu :
    delete définitif where deleted_at < now() - 30 jours
    (les médias liés sont supprimés du Storage avant la ligne)
# 2. Comptes en attente de suppression depuis > 30 jours
pour chaque user marqué deletion_requested_at < now() - 30 jours :
    supprimer tous les objets Storage {user_id}/*  (4 buckets)
    supprimer les lignes de toutes les tables (cascade)
    auth.admin.deleteUser(user_id)
    consigner l'achèvement dans audit_log (id pseudonymisé)
# 3. Orphelins (voir § 4.5)
```

### 5.3 `export-data`

* **Déclencheur :** appel authentifié depuis l'application (Paramètres → Exporter mes données). Exécution avec le **JWT de l'appelant** (pas de clé service : la RLS garantit qu'on n'exporte que ses propres données).
* **Rôle :** droit d'accès et de portabilité — export **gratuit et complet**, y compris en mode lecture seule (exigence de l'audit ch. 9).

```text
vérifier rate limit (1 export / 24 h / utilisateur)
créer ligne exports (statut : en cours)
extraire toutes les tables de l'utilisateur → JSON structuré
streamer les objets media-photos + avatars de l'utilisateur dans un ZIP
écrire le ZIP dans exports/{user_id}/{uuid}.zip
mettre à jour exports (statut : prêt, expiration : now() + 7 jours)
notifier : push « Votre export est prêt » + e-mail avec lien in-app
```

L'export PDF « éditorial » du PRD est un rendu client en V1 ; seul l'export réglementaire JSON + médias est un travail serveur.

### 5.4 `revenuecat-webhook`

* **Déclencheur :** HTTP POST de RevenueCat (URL de production uniquement), authentifié par **secret partagé** dans l'en-tête `Authorization` — toute requête sans secret valide est rejetée en 401 sans traitement.
* **Rôle :** source de vérité de l'état d'abonnement côté serveur.

```text
vérifier le secret ; vérifier l'app_user_id (= user_id Supabase)
selon event.type :
  INITIAL_PURCHASE / TRIAL_STARTED / RENEWAL / UNCANCELLATION :
      upsert subscriptions ; users.subscription_status = 'active'
  CANCELLATION : noter la résiliation (l'accès court jusqu'à l'échéance)
  EXPIRATION / BILLING_ISSUE (après relances) :
      subscriptions.état = expiré ; users.subscription_status = 'read_only'
répondre 200 (idempotent : event.id déjà traité → 200 sans effet)
```

La bascule `read_only` prend effet immédiatement dans les politiques RLS (§ 3.2, point 5) : c'est le serveur qui fait respecter le mode lecture seule, l'interface ne fait que l'expliquer.

### 5.5 `account-deletion`

* **Déclencheur :** appel authentifié depuis l'application, après ré-authentification récente (< 5 minutes).
* **Rôle :** orchestration complète et conforme de la suppression de compte (exigence stores + RGPD/nLPD).

```text
vérifier la fraîcheur de la session
users.deletion_requested_at = now() ; users.subscription_status = 'deleted'
révoquer toutes les sessions et refresh tokens du compte
supprimer les jetons push (table devices)
envoyer l'e-mail de confirmation : « suppression effective sous 30 jours,
    reconnexion avant ce terme = annulation de la demande »
consigner dans audit_log
# la purge effective est réalisée par purge-deleted à J+30 (§ 5.2)
```

Une reconnexion pendant le délai de grâce annule la demande (`deletion_requested_at` remis à NULL) — c'est le filet contre la suppression impulsive d'un contenu irremplaçable, explicitement annoncé à l'utilisateur.

---

## 6. Notifications push

* **Canal unique d'envoi : FCM** (API HTTP v1, compte de service en secret de fonction) — directement pour Android, **via FCM pour APNs** côté iOS (clé APNs déposée dans la console Firebase). Firebase n'est utilisé que pour le push : aucun SDK Firebase Analytics, Crashlytics ou autre n'est embarqué.
* **Table `devices`** (livrable 4) : un enregistrement par installation — `user_id`, plateforme, jeton FCM, locale, version d'app, `last_seen_at`. Le jeton est enregistré/rafraîchi à chaque lancement et à chaque rotation notifiée par le SDK ; il est supprimé à la déconnexion de l'appareil et à la suppression du compte.
* **Jetons expirés :** toute réponse FCM `UNREGISTERED` ou `INVALID_ARGUMENT` entraîne la suppression immédiate de la ligne `devices` correspondante. Les appareils sans activité (`last_seen_at`) depuis 180 jours sont purgés par `purge-deleted`.
* **Notifications silencieuses de synchronisation :** lorsqu'un événement serveur modifie des données répliquées localement (bascule lecture seule, export prêt, purge), une notification **data-only** (sans affichage) est envoyée pour déclencher une synchronisation en arrière-plan. Best effort assumé : iOS et Android peuvent throttler ces messages, la synchronisation à l'ouverture reste le mécanisme de vérité.
* **Contenu minimal à l'écran verrouillé :** conformément à l'audit (ch. 9), un mode « notifications discrètes » (texte générique, détail après déverrouillage) est proposé dans les Paramètres ; le contenu des push transite par FCM et ne doit donc jamais contenir plus que le nécessaire (prénom, type de rappel — jamais de note ni de contenu de souvenir).

---

## 7. Sauvegardes et restauration

* **Production :** sauvegardes **quotidiennes automatiques** incluses dans le plan Pro (rétention 7 jours) dès l'ouverture de la bêta. Le **PITR (Point-in-Time Recovery)** est activé **au plus tard au lancement public** : pour un produit dont la promesse est « ne jamais perdre les souvenirs », la granularité quotidienne est insuffisante en régime réel (24 h de souvenirs perdus est un scénario inacceptable). Son coût est intégré au budget (§ 10).
* **Test de restauration trimestriel, documenté :** chaque trimestre, une sauvegarde de production est restaurée vers un projet jetable (ou vers staging vidé), et une liste de contrôle est déroulée : intégrité du schéma, comptage d'un échantillon de tables, ouverture d'objets Storage, exécution des tests RLS. Le résultat (date, opérateur, durée de restauration, anomalies) est consigné dans `docs/exploitation/tests-restauration.md`. **Une sauvegarde non testée n'est pas une sauvegarde.**
* **Export de secours hebdomadaire du schéma :** un travail CI hebdomadaire exécute `supabase db dump --schema-only` (plus le contenu des seuls référentiels non personnels) et archive le résultat en artefact chiffré. **Schéma seulement** : aucune donnée personnelle ne sort du projet Supabase par ce canal — l'objectif est de pouvoir reconstruire l'infrastructure, pas de dupliquer les données.
* **Storage :** les objets ne sont pas couverts par les sauvegardes base de données. La stratégie V1 repose sur la durabilité de l'object storage managé et sur la règle « jamais de suppression physique sans délai de grâce de 30 jours » (§ 5.2), qui fait office de corbeille. Une réplication secondaire des buckets sera réévaluée après le lancement.

---

## 8. Sécurité

1. **Transit :** TLS 1.2+ exigé sur toutes les liaisons (API, Storage, fonctions) — comportement par défaut de Supabase, vérifié en recette. Le certificate pinning côté application est traité au livrable sécurité mobile.
2. **Repos :** chiffrement au repos des volumes Postgres et de l'object storage, inclus dans l'offre managée. Le chiffrement de la base locale (SQLCipher) et du trousseau relève du livrable sécurité mobile.
3. **RLS systématique et testée :** une suite de **tests SQL de non-fuite** vit dans le dépôt (`supabase/tests/rls/`) et s'exécute en CI sur chaque migration : elle crée deux utilisateurs de test A et B, insère des données pour chacun, puis vérifie, table par table et bucket par bucket, que A ne peut ni lire, ni modifier, ni supprimer, ni compter les lignes de B — y compris via les fonctions SQL exposées. Elle vérifie aussi que le rôle `anon` ne lit rien et que le mode `read_only` bloque bien les écritures. **Aucune migration ne part en production si cette suite échoue.**
4. **Rate limiting des fonctions :** limites applicatives par utilisateur consignées en base — `export-data` : 1/24 h ; `account-deletion` : 1/24 h ; enregistrement d'appareil : 10/jour — en plus des limites de plateforme d'Auth (envoi d'e-mails, tentatives de connexion). Le webhook RevenueCat rejette toute requête non authentifiée avant tout travail.
5. **Pas de clé service côté client — jamais :** la clé `service_role` n'apparaît que dans les secrets des fonctions et de la CI (§ 1.3). Une vérification automatique en CI (analyse de la configuration de build Flutter et recherche de motifs de clés) échoue si une clé à privilèges est détectée dans le code applicatif.
6. **Journal d'audit minimal des fonctions serveur :** table `audit_log` (insert-only, écrite uniquement par les fonctions) consignant : fonction, action, `user_id` concerné, horodatage, résultat. Y figurent au minimum : demandes et achèvements de suppression de compte, exports, bascules d'état d'abonnement, exécutions de purge (volumes), erreurs d'envoi push en masse. Aucune donnée de contenu (notes, photos) n'y est jamais écrite ; rétention 12 mois puis purge.
7. **Accès humain à la production :** restreint aux personnes nommées, avec double authentification ; toute intervention manuelle en production est consignée dans le journal d'exploitation. Personne ne consulte les données d'un utilisateur sans demande de support explicite de sa part, tracée.

---

## 9. Analytics produit

**Décision tranchée : pas d'outil tiers au lancement — une table Postgres simple, un tableau de bord SQL hebdomadaire.**

* **Aucun SDK publicitaire ni de tracking tiers** dans l'application, jamais : c'est un engagement de positionnement (« vos données ne sont ni vendues ni analysées à des fins publicitaires ») autant qu'une simplification des déclarations stores.
* Les événements produits (inscription, essai démarré, relation créée, interaction créée, souvenir créé, conversion, résiliation — la liste exacte suit le livrable KPI) sont écrits dans une table **`events_analytics`** : `id`, `user_id`, `event_type`, `properties jsonb` (propriétés techniques minimales, **jamais de contenu utilisateur**), `created_at`.
* **RLS insert-only via la clé anonyme** : politique `insert` avec `check (auth.uid() = user_id)`, **aucune politique `select`/`update`/`delete`** pour les clients — un utilisateur peut émettre ses événements mais personne ne peut lire la table depuis l'application. La lecture se fait uniquement par les personnes autorisées via le SQL Editor.
* **Exploitation :** un jeu de requêtes versionné dans le dépôt (`docs/exploitation/kpi.sql`) produit la revue hebdomadaire des KPI du PRD (inscriptions, essais, conversions, rétention J7/J30, churn). Rétention des événements : 24 mois, puis agrégation et purge par `purge-deleted`.
* **Évolution :** si le volume ou le besoin d'exploration dépasse le SQL hebdomadaire, la cible est un outil **auto-hébergeable dans l'UE** (type PostHog auto-hébergé) alimenté par la même table — jamais un SDK tiers côté client.

---

## 10. Coûts — ordre de grandeur mensuel au lancement

Estimation prudente, arrondie, aux tarifs publics connus mi-2026 ; à revalider trimestriellement dans la revue de coûts (audit ch. 7, R10).

| Poste | Ordre de grandeur | Remarques |
|---|---|---|
| Supabase Pro (prod) | ~25 USD/mois | Inclut sauvegardes quotidiennes (7 j), ~8 Go de base, ~100 Go de Storage, ~250 Go d'egress — très au-delà des besoins des premiers milliers d'utilisateurs (~0,2 Go de photos/an pour un utilisateur très actif, audit ch. 7 R4) |
| PITR (prod) | ~100 USD/mois | Activé au plus tard au lancement public (§ 7) ; c'est le premier poste d'infrastructure, assumé comme prix de la promesse « ne jamais perdre les souvenirs » |
| Projets dev + staging | 0 | Plans gratuits ; passer staging en Pro (~25 USD/mois) seulement si la recette l'exige |
| Stockage et egress au-delà des quotas inclus | ~0 au lancement | Facturation à l'usage (ordre de 0,02 USD/Go/mois de stockage) ; ne devient visible qu'avec plusieurs milliers d'utilisateurs actifs |
| FCM / APNs | 0 | Gratuits |
| RevenueCat | 0 au lancement | Gratuit sous le seuil de revenus suivis de l'offre d'entrée ; devient payant avec la traction — coût heureux |
| E-mail transactionnel (SMTP UE) | 0-15 USD/mois | Volumes faibles au lancement |
| **Total infrastructure backend** | **~25-40 USD/mois à la bêta ; ~130-165 USD/mois au lancement public (PITR inclus)** | Hors comptes développeur (Apple 99 USD/an, Google 25 USD une fois), monitoring et commission des stores, traités dans le budget global |

Ces montants confirment l'analyse de l'audit : le coût variable est marginal tant que le pipeline média (compression client, miniatures, quotas) est respecté ; les postes réels sont le PITR et, de très loin, la commission des stores — qui relève du chapitre monétisation, pas de l'infrastructure.

---

## Récapitulatif des décisions normatives

| # | Décision |
|---|---|
| D1 | Trois projets Supabase (dev/staging/prod), région Zurich `eu-central-2` (repli Francfort), aucune donnée réelle hors prod |
| D2 | Secrets hors dépôt : clé `service_role` exclusivement en secrets de fonctions/CI ; clé `anon` seule embarquée, protégée par RLS |
| D3 | Auth Apple + Google + e-mail/mot de passe ; JWT 1 h, refresh tokens en rotation, expiration d'inactivité 90 jours ; trigger `auth.users` → `public.users` |
| D4 | Schéma uniquement via migrations versionnées (livrable 4) ; RLS partout, `auth.uid() = user_id` ; lecture seule post-abonnement appliquée en base |
| D5 | Quatre buckets privés, chemins `{user_id}/{uuid}`, URL signées 15 min (1 h pour les exports), miniatures générées côté client |
| D6 | Cinq Edge Functions : `daily-notifications` (cron horaire, 9 h locale, plafonds 2/6, priorités anniversaire > promesse > relation), `purge-deleted`, `export-data`, `revenuecat-webhook`, `account-deletion` |
| D7 | Push via FCM uniquement (APNs relayé) ; table `devices` ; purge des jetons invalides ; pas d'autre SDK Firebase |
| D8 | Sauvegardes quotidiennes dès la bêta, PITR au lancement public, test de restauration trimestriel documenté, dump hebdomadaire du schéma seul |
| D9 | Tests SQL de non-fuite RLS bloquants en CI ; rate limiting des fonctions ; journal d'audit serveur insert-only |
| D10 | Analytics : table `events_analytics` insert-only en interne, tableau de bord SQL hebdomadaire ; aucun SDK publicitaire ni de tracking tiers |
