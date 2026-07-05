# AMIORA — Rapport d'audit qualité App Store (Phase 1)

Date : 2026-07-05 · Base auditée : commit `1e4087f` · Méthode : trois audits
indépendants et exhaustifs du code réel (async/lifecycle, données/sync/hors-
ligne, navigation/UX/sécurité), chaque finding **vérifié dans le code avant
d'être retenu** (fichier:ligne cités). Les preuves d'exécution (analyze,
tests, CI) sont référencées en fin de document.

Légende statut : ✅ corrigé dans ce lot · 🔜 planifié (raison donnée) ·
📋 côté fondateur (compte/appareil requis).

---

## 1. CRITIQUES (perte de données ou fonction produit inopérante)

### C1 — Pull sans pagination + curseur global : données silencieusement perdues à la restauration — ✅
`lib/data/sync/sync_service.dart:157-182,281`. PostgREST plafonne un select à
1 000 lignes. Un compte avec plus de 1 000 interactions restauré sur un
nouvel appareil : la table est tronquée, le curseur global avance quand même
→ le reste n'est **jamais** tiré, sans erreur. Violation directe de
l'exigence « l'utilisateur ne perd jamais de données ».
**Correction** : pagination par table (`range` + `order updated_at,id`)
jusqu'à épuisement ; curseur avancé seulement après épuisement de toutes les
tables.

### C2 — « Effacer mes données locales » détruit l'outbox non poussée — ✅
`lib/features/settings/presentation/settings_screen.dart:183-193`. Des
mutations faites hors ligne (encore en file) sont effacées avec le reste :
perte définitive, partout. De plus la boucle de suppression n'était pas
transactionnelle (fermeture à mi-course = base incohérente) et pouvait
s'entrelacer avec un pull en vol (restauration partielle irrécupérable). En
mode connecté, le libellé « irréversible » était trompeur (re-sync serveur
en ≤ 5 min).
**Correction** : sync exigée avant wipe (refus si l'outbox reste non vide),
transaction, libellés honnêtes par mode (connecté : « re-synchronisera » ;
local pur : double confirmation de perte définitive).

### C3 — `restore()` cassé : incohérence de format du curseur — ✅
`lib/data/sync/sync_service.dart:49 vs 156`. Écrit en ISO brut, lu via
`jsonDecode` → `FormatException` **prouvée à l'exécution** par l'audit. La
restauration « nouvel appareil » n'aurait rien tiré et toutes les syncs
suivantes échouaient. Le harnais e2e l'aurait détecté aux premières clés.
**Correction** : format unifié (`jsonEncode`), test unitaire ajouté.

### C4 — Lecture seule contournable partout — ✅
Seul le « + » central passait par `ensureWritable`
(`core/router/router.dart:166`). Créations et modifications libres depuis
tous les autres écrans (`add_relationship:151`, `memories:33`,
`promises:34,136,173`, `relationship_detail:64,185`, `home:147`,
`relationships:34`, `in_memoriam:190`) : le modèle économique (lecture seule
après expiration) était inopérant.
**Correction** : garde posé sur chaque point d'entrée d'écriture (la
suppression reste libre, conformément au PRD : consulter/exporter/supprimer).

### C5 — Permission `INTERNET` absente du manifest Android release — ✅
Le gabarit Flutter ne la déclare qu'en debug/profile : en build release,
Supabase/RevenueCat/FCM échouent silencieusement. Corrigé en versionnant
`app/android/` avec le manifest complété (+ intent-filter OAuth
`ch.amiora.app` qui manquait aussi — connexion OAuth impossible sur Android
sinon, label AMIORA, icônes, lancement sombre, portrait).

### C6 — Paywall en cul-de-sac — ✅
`features/paywall/presentation/paywall_screen.dart:70`. L'utilisateur en
lecture seule était envoyé vers un écran dont le CTA répondait « arrive en
Phase 5 » alors que `SubscriptionService.purchase/offerings/restore`
existent. **Correction** : paywall entièrement câblé (offres réelles du
store, sélection annuel/mensuel, achat avec état de chargement, annulation
silencieuse, restauration avec feedback, erreur réseau élégante avec retry,
squelettes pendant le chargement, retour haptique) — repli statique propre
sans clé RevenueCat.

## 2. MAJEURS

### M1 — L'écho du pull écrase les mutations faites pendant la sync — ✅
`sync_service.dart:162-164,178`. `pendingIds` figé en début de pull : une
mutation pendant le pull (plusieurs allers-retours réseau) était écrasée par
l'écho serveur, puis l'état écrasé était repoussé (outbox sans payload) —
perte définitive reproductible. **Correction** : re-vérification de l'outbox
à l'application de chaque ligne, dans la transaction.

### M2 — `memories.created_at` non poussé : chronologie corrompue — ✅
`sync_service.dart:340-351`. Le serveur posait `now()` au push, l'écho
réécrivait la date locale : timeline des souvenirs et composante S de
l'Indice faussées ; après restauration, tous les souvenirs dataient du jour
du restore. **Correction** : `created_at` fait l'aller-retour.

### M3 — Réglages jamais tirés + poussés avec des défauts — ✅
`sync_service.dart:287-301`. Un nouvel appareil écrasait les préférences
serveur avec les valeurs par défaut (bataille infinie entre appareils) ; le
fuseau envoyé (`timeZoneName` → « CEST ») était inutilisable pour les
notifications. **Correction** : push des seules clés réellement définies
localement, pull des clés absentes, fuseau IANA ou offset minutes (fonction
`daily-notifications` adaptée avec repli Europe/Zurich).

### M4 — Dernier *sync* gagne (pas dernière *écriture*) — 🔜
`sync_service.dart:58-147`. Un appareil resté hors ligne des jours pousse sa
ligne entière et écrase des modifications plus récentes faites ailleurs
(le trigger serveur estampille `now()`). Correction propre = concurrence
optimiste par ligne (push conditionnel sur l'`updated_at` serveur connu +
résolution de conflit) : chantier structurel, planifié **avant la bêta
publique**, risque faible en bêta privée (un utilisateur = ses appareils,
fenêtre de conflit étroite). Documenté comme limite connue.

### M5 — Changement d'identité sans nettoyage : fusion de comptes — ✅
`auth_repository.dart:60-68` + `app.dart:51-56`. Si un second utilisateur se
connectait sur le même appareil, l'outbox de l'ancien partait dans le compte
du nouveau et les données fusionnaient. Latent (aucune UI de déconnexion
n'existait) mais la déconnexion est précisément câblée dans ce lot.
**Correction** : `last_user_id` mémorisé ; à la connexion d'un utilisateur
différent, purge locale transactionnelle avant première sync.

### M6 — Session Supabase stockée en clair — 🔜
`supabase_service.dart:25`. Le refresh token persiste en SharedPreferences/
NSUserDefaults. Correction = `flutter_secure_storage` (Keychain/Keystore)
branché via `authOptions.localStorage` : ajoutée au chantier « clés réelles »
(Phase services) pour être testée avec de vraies sessions — sans clés
Supabase, aucun token n'existe aujourd'hui, risque actuel nul.

### M7 — Hors ligne : exceptions asynchrones non gérées toutes les 5 min — ✅
`app.dart:30,47,54` + `sync_service.dart` (`_pull`/`_pushSettings` sans
try/catch, futurs non attendus). Aucune perte, mais contrat « silencieuse,
jamais bloquante » violé. **Correction** : capture et log warning sur tout
le cycle ; relance immédiate si une mutation arrive pendant une sync en vol
(`_rerunRequested`) au lieu d'attendre le tick suivant.

### M8 — « Mot de passe oublié ? » inopérant + exception non gérée — ✅
`login_screen.dart:173-186`. Bouton jamais activé pendant la frappe (aucun
rebuild) ; `NetworkException` non attrapée. **Correction** : rebuild sur
saisie, passage par le chemin d'action commun avec feedback succès/échec.
Également : suppression de la navigation prématurée après OAuth (le routeur
navigue à l'arrivée réelle de la session).

### M9 — Bottom sheets sans défilement : débordement garanti — ✅
`add_interaction_sheet:98`, feuilles souvenir/promesse. Clavier ouvert +
texte à 130 % → RenderFlex overflow. **Correction** : contenu défilant ;
et passage de l'app en **portrait uniquement sur iPhone** (classe entière de
débordements paysage éliminée ; conforme au produit, l'iPad reste libre).

### M10 — Profil : état d'abonnement en dur, déconnexion factice — ✅
`profile_screen.dart:46,84`. Chip « Essai » codé en dur, « Se déconnecter »
stub. **Correction** : chip dérivé d'`accessStateProvider`, déconnexion
réelle avec confirmation (visible seulement en mode connecté).

## 3. MINEURS (tous ✅ sauf mention)

- **Deep link inconnu = écran d'erreur go_router anglais sans sortie**
  (`router.dart:30`) → route `/` + `errorBuilder` thémé « Retour à
  l'accueil ». ✅
- **Calendrier sans états chargement/erreur** (faux « Rien de prévu » sur
  erreur DB) + message transitoire erroné dans la feuille d'interaction. ✅
- **Aucune limite de saisie** (collage de plusieurs Mo accepté) → maxLength
  50/120/2000, vraie regex e-mail à l'inscription. ✅
- **Perte de saisie silencieuse au retour arrière** (add_relationship) →
  PopScope avec confirmation. ✅
- **Double-tap non protégé** (deux écrans détail empilés, deux sheets) →
  TapGuard 600 ms sur les navigations. ✅
- **Listeners FCM accumulés** (`push_service.dart:49`) → abonnement unique +
  try/catch. ✅
- **Providers `.family` sans autoDispose** (rétention mémoire par id
  visité) → `.autoDispose.family`. ✅
- **Entrée outbox inconnue évacuée silencieusement** → `StateError` explicite
  (défense pour les futures entités). ✅
- **Entrée outbox empoisonnée** (erreur serveur durable) : file bloquée sans
  alerte → télémétrie à 20 tentatives ✅ ; quarantaine/dead-letter 🔜 (bêta).
- **`archivedAt` perdu à la restauration** (aucune colonne serveur) →
  colonne `archived_at` ajoutée à la migration (jamais déployée = modifiable),
  aller-retour câblé. ✅
- **Garde `pendingIds` inopérante sur les tables de liaison** : sans scénario
  de perte atteignable aujourd'hui (aucune suppression client de liens) ;
  couvert de fait par M1 (re-vérification outbox à l'application). 🔜 revue
  au chantier M4.
- **Schéma URL OAuth détournable** (`Info.plist`) : PKCE protège l'échange du
  code ; Universal Links/App Links 🔜 (nécessite domaine + compte Developer).
  📋
- **`memories.albumId`/table Albums non synchronisés** : fonctionnalité
  dormante (aucune UI) — à câbler avec le chantier médias. 🔜

## 4. Sains — vérifiés explicitement (aucune action)

- **Secrets** : aucun en dur ; exclusivement `String.fromEnvironment`
  (clés publiques seules) ; les 14 appels de log ne journalisent aucun
  contenu utilisateur.
- **BuildContext après await** : `mounted`/`context.mounted` systématiques
  (vérifié écran par écran).
- **Dispose** : contrôleurs, timers, listeners RevenueCat — tous libérés.
- **Double-tap sur boutons de sauvegarde** : gardes `_saving`/`_busy`
  présentes sur tous les chemins d'écriture.
- **Transactions locales** : chaque mutation UI journalise dans l'outbox
  dans la même transaction que l'écriture (y compris multi-tables).
- **Reprise après fermeture en pleine sync** : at-least-once + upserts
  idempotents ; curseur avancé en fin de pull seulement.
- **Horloge locale fausse** : sans effet sur le LWW (estampille exclusivement
  serveur).
- **Navigation** : détail de relation inexistante géré ; pas de boucle de
  redirection auth ; états vides/erreur présents sur les écrans principaux.

## 5. Hors de portée de cet environnement — 📋 côté fondateur

- Mesures réelles FPS/mémoire/temps de lancement sur iPhone (build profile
  prêt ; procédure : `flutter run --profile` + overlay de performance).
- Scénarios d'achat sandbox (compte Apple Developer + App Store Connect +
  RevenueCat requis — procédure complète dans `docs/PAYMENTS_SETUP.md`).
- Captures App Store sur vrais gabarits (6.9" / 6.5").
- Politique de confidentialité et CGU hébergées (URLs exigées par Apple).

## 6. Preuves d'exécution

- `flutter analyze` : No issues found — avant ET après corrections.
- `flutter test` : 20 verts + 7 e2e en attente de clés — avant ET après
  (tests ajoutés dans ce lot inclus).
- CI GitHub Actions : runs verts sur chaque poussée (qualité + APK + iOS
  profile) — voir l'onglet Actions du dépôt pour le run du commit de ce lot.
- Findings vérifiés à la source : chaque entrée ci-dessus cite fichier:ligne
  de la base auditée `1e4087f`.
