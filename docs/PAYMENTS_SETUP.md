# Configuration des paiements — AMIORA (App Store + RevenueCat + Supabase)

Document opérationnel, à dérouler dans l'ordre A → E.
Prérequis : compte Apple Developer actif et app créée dans App Store Connect
(→ `APP_STORE_CHECKLIST.md` § 1–2).

Modèle (PRD v1.2, source de vérité) :

| Plan | Prix | Essai | ID produit proposé |
|---|---|---|---|
| Mensuel | **5,99 CHF** | 14 jours gratuits | `amiora_monthly_599` |
| Annuel (recommandé) | **44,99 CHF** | 14 jours gratuits | `amiora_yearly_4499` |

Aucun plan gratuit. Après expiration : **mode lecture seule**
(consulter · exporter · supprimer), jamais de confiscation de données.

---

## A. App Store Connect — contrats puis abonnements

### A.1 Accord « Applications payantes » (banque + impôts) — À FAIRE EN PREMIER

⚠️ **Piège majeur** : tant que cet accord n'est pas **actif**, les produits
d'abonnement ne se chargent pas — `offerings()` renvoie une liste vide, même
en sandbox. C'est la cause n°1 des paywalls vides. Délai de validation
possible de plusieurs jours → commencer immédiatement.

- [ ] 1. https://appstoreconnect.apple.com → **Paiements et accords**
      (Business / anciennement « Accords, taxes et opérations bancaires »).
- [ ] 2. Accord **Applications payantes (Paid Apps)** → Afficher et accepter
      les conditions.
- [ ] 3. **Coordonnées bancaires** : ajouter le compte (IBAN suisse accepté,
      devise CHF possible).
- [ ] 4. **Formulaires fiscaux** : remplir au minimum le formulaire américain
      (W-8BEN pour un individu non américain — pré-rempli, à certifier).
- [ ] 5. Attendre que le statut de l'accord passe à **« Actif / Processing
      completed »** avant de continuer.

### A.2 Groupe d'abonnements « AMIORA Premium »

- [ ] 1. Mes apps → AMIORA → **Monétisation → Abonnements**.
- [ ] 2. **Créer** un groupe d'abonnements → Nom de référence : `AMIORA Premium`.
- [ ] 3. Dans le groupe → **Localisations de l'app** → ajouter **Français** →
      Nom affiché du groupe : `AMIORA Premium`.

⚠️ Un utilisateur ne peut avoir qu'**un seul** abonnement actif par groupe :
les deux plans doivent être dans **le même groupe** pour que le passage
mensuel → annuel fonctionne.

### A.3 Création des deux abonnements

Pour **l'annuel** d'abord (rang 1 = le plus haut, cela fait du passage
mensuel → annuel une *montée en gamme immédiate*) :

- [ ] 1. Dans le groupe → **Créer un abonnement** :
      - Nom de référence : `AMIORA Annuel`
      - **ID de produit : `amiora_yearly_4499`** — ⚠️ définitif, jamais réutilisable,
        même après suppression. Recopier exactement.
- [ ] 2. **Durée de l'abonnement** : 1 an.
- [ ] 3. **Disponibilité** : tous les pays (ou restreindre : Suisse, France,
      Belgique, Luxembourg, Canada pour commencer — modifiable ensuite).
- [ ] 4. **Prix** : Ajouter → pays de référence **Suisse : 44,99 CHF** →
      laisser Apple générer les équivalents par pays → valider.
- [ ] 5. **Localisation** (Français) :
      - Nom affiché : `Premium Annuel`
      - Description : `Accès complet à AMIORA pendant un an.`
- [ ] 6. **Offre d'introduction** (l'essai gratuit) : Offres d'introduction →
      Configurer → tous les pays → dates : début immédiat, **sans date de fin** →
      type **Gratuit (Free trial)** → durée **2 semaines** → valider.
- [ ] 7. **Capture d'écran pour la revue** (onglet Revue) : image 640 × 920 px
      du paywall de l'app (une capture du simulateur recadrée suffit).
      ⚠️ Sans elle, le statut reste bloqué et l'abonnement ne peut pas être soumis.
- [ ] 8. Vérifier le statut : **« Prêt à soumettre » (Ready to Submit)**.

Puis **le mensuel** (mêmes étapes) :

- [ ] 9. Créer `AMIORA Mensuel`, **ID produit `amiora_monthly_599`**, durée
      **1 mois**, prix référence **Suisse : 5,99 CHF**, localisation FR
      (Nom : `Premium Mensuel`), offre d'introduction **Gratuit / 2 semaines**,
      capture de revue, statut « Prêt à soumettre ».
- [ ] 10. Dans la liste du groupe, vérifier l'**ordre (rang)** : Annuel au rang 1,
      Mensuel au rang 2 (glisser-déposer si besoin).
- [ ] 11. Recommandé : Monétisation → Abonnements → **Période de grâce de
      facturation (Billing Grace Period)** → activer (16 jours) — un problème
      de carte bancaire ne coupe pas l'accès instantanément.

⚠️ **Pièges** :
- L'essai gratuit (offre d'introduction) n'est visible et applicable que pour
  les **nouveaux abonnés du groupe** : un utilisateur qui a déjà consommé un
  essai sur `AMIORA Premium` verra directement le prix plein — comportement
  normal, ne pas « déboguer ».
- Pour une **première version d'app**, les abonnements doivent être **soumis
  avec le binaire** : sur la page de la version 1.0, section « Achats intégrés
  et abonnements », sélectionner les deux produits avant de soumettre
  (→ `RELEASE_GUIDE.md` § 6).

---

## B. RevenueCat — projet, produits, entitlement, webhook

### B.1 Projet et app iOS

- [ ] 1. Créer un compte sur https://app.revenuecat.com (offre gratuite jusqu'à
      2 500 USD de revenus mensuels suivis — largement suffisant au départ).
- [ ] 2. Créer un **Project** : `AMIORA`.
- [ ] 3. Project → **Apps** (Project settings) → **+ New app → App Store** :
      - App name : `AMIORA iOS`
      - **Bundle ID : `ch.amiora.amiora`**

### B.2 Clé « In-App Purchase » (liaison Apple ↔ RevenueCat)

- [ ] 1. App Store Connect → **Utilisateurs et accès → Intégrations →
      Achats intégrés (In-App Purchase)** → **Générer une clé** →
      nom `RevenueCat` → télécharger le fichier **`.p8`**.
      ⚠️ Téléchargeable **une seule fois** — le ranger en lieu sûr
      (gestionnaire de mots de passe).
- [ ] 2. Noter le **Key ID** (sur la ligne de la clé) et l'**Issuer ID**
      (en haut de la page Intégrations).
- [ ] 3. RevenueCat → App `AMIORA iOS` → section **In-app purchase key
      configuration** → téléverser le `.p8` + Issuer ID.

### B.3 Produits, entitlement `premium`, offering `default`

- [ ] 1. RevenueCat → **Product catalog → Products → + New** → App Store →
      importer (ou saisir) les deux identifiants :
      `amiora_monthly_599` et `amiora_yearly_4499`.
- [ ] 2. **Product catalog → Entitlements → + New** :
      - Identifier : **`premium`** (exactement, en minuscules — l'app teste
        cette chaîne)
      - Description : `Accès complet AMIORA`
      - Ouvrir l'entitlement → **Attach** → attacher **les deux** produits.
- [ ] 3. **Offerings** → ouvrir l'offering **`default`** (créé d'office ; sinon
      le créer avec l'identifiant `default`) → **+ Add package** :
      - Package **`$rc_monthly`** → produit App Store `amiora_monthly_599`
      - Package **`$rc_annual`** → produit App Store `amiora_yearly_4499`
- [ ] 4. Vérifier que `default` est marqué **Current** (offering servi par
      `offerings()` dans l'app).

### B.4 Clé API publique (pour le build de l'app)

- [ ] 1. Project settings → **API keys** → section **Public app-specific
      API keys** → copier la clé de l'app iOS : elle commence par **`appl_`**.
- [ ] 2. C'est la valeur du `--dart-define=REVENUECAT_API_KEY=…` (section C).

⚠️ Ne **jamais** mettre une clé secrète (`sk_…`) dans l'app ni dans le dépôt.
La clé `appl_` est publique par conception — elle peut vivre dans le build.

### B.5 Webhook → Supabase (la vérité serveur)

Côté Supabase (une fois le projet prod créé, région **eu-central-2 Zurich**) :

- [ ] 1. Générer un secret fort : `openssl rand -hex 32` (garder la valeur).
- [ ] 2. Le déclarer : `supabase secrets set RC_WEBHOOK_SECRET="<valeur>"`
      (ou Dashboard Supabase → Edge Functions → Secrets).
- [ ] 3. Déployer la fonction : `supabase functions deploy revenuecat-webhook`.

Côté RevenueCat :

- [ ] 4. Project → **Integrations → Webhooks → + New** :
      - **Webhook URL** : `https://<PROJET>.supabase.co/functions/v1/revenuecat-webhook`
        (remplacer `<PROJET>` par la référence du projet Supabase prod)
      - **Authorization header value** : **exactement la même valeur** que
        `RC_WEBHOOK_SECRET`
      - Événements : tous (par défaut).
- [ ] 5. Bouton **Send test event** → vérifier dans Supabase (Dashboard →
      Edge Functions → `revenuecat-webhook` → Logs) une réponse **200**.
      Un **401** = les deux secrets ne correspondent pas.

⚠️ **Piège** : les événements sandbox arrivent avec `environment: "SANDBOX"` —
normal pendant les tests ; la table `subscriptions` de prod doit les distinguer
(la fonction s'en charge), ne pas s'étonner de les voir dans les logs.

### B.6 Liaison utilisateur

Rien à configurer : l'app appelle `Purchases.logIn(<userId Supabase>)` après
connexion — l'identifiant client RevenueCat = l'UUID Supabase, ce qui permet
au webhook de mettre à jour la bonne ligne `subscriptions`.

---

## C. Injection des clés dans le build

Les clés sont fournies **au moment du build**, jamais écrites dans le code :

```bash
flutter build ipa --release \
  --dart-define=SUPABASE_URL=https://<PROJET>.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=<clé anon/publishable publique> \
  --dart-define=REVENUECAT_API_KEY=appl_xxxxxxxxxxxx
```

Règles absolues :

- `SUPABASE_ANON_KEY` = la clé **anon/publishable publique** uniquement.
  **Jamais** la clé `service_role` dans l'app, un build, ou le dépôt.
- `REVENUECAT_API_KEY` = la clé **`appl_`** (iOS). ⚠️ Android aura **sa propre
  clé `goog_`** — une clé par plateforme, ne pas réutiliser la clé Apple.

---

## D. Procédure de test Sandbox (bout en bout)

### D.1 Préparation

- [ ] 1. Créer un **testeur sandbox** : App Store Connect → **Utilisateurs et
      accès → Sandbox → Comptes de test (Testers) → +** :
      e-mail **jamais utilisé** comme identifiant Apple
      (astuce : `sebastien.golay+sandbox1@hotmail.com`), mot de passe, pays **Suisse**.
      ⚠️ Ne **jamais** se connecter à iCloud avec ce compte — il ne sert
      qu'aux achats.
- [ ] 2. Installer l'app sur l'iPhone en **Release** avec les dart-defines de
      prod (`flutter run --release -d <UDID> --dart-define=…` — les trois clés).
- [ ] 3. Sur l'iPhone : **Réglages → App Store** → tout en bas, section
      **COMPTE SANDBOX** → se connecter avec le testeur sandbox.
      (La section n'apparaît qu'après l'installation d'un build de développement.)
- [ ] 4. Dans le dashboard RevenueCat, activer l'affichage des données sandbox
      (interrupteur **View sandbox data** en haut à gauche).

### D.2 Durées accélérées du sandbox (référence)

Le sandbox compresse le temps — c'est voulu, pour tester des mois en minutes :

| Durée réelle | Durée sandbox |
|---|---|
| 1 semaine | 3 minutes |
| 1 mois | 5 minutes |
| 1 an | 1 heure |

- L'**essai gratuit de 14 jours** est compressé de la même façon (quelques
  minutes) avant le premier « prélèvement » simulé.
- Un abonnement sandbox se **renouvelle automatiquement ~12 fois** puis expire
  tout seul — pratique pour tester l'expiration sans rien faire.
- iOS 15.4+ : la vitesse est réglable — Réglages → App Store → compte sandbox →
  toucher le compte → **Gestion** (renouvellement accéléré, effacer l'historique
  d'achat, tester les interruptions).

⚠️ **Piège** : Sandbox et TestFlight sont des **environnements différents**.
En TestFlight, on utilise son **vrai** identifiant Apple, les achats sont
gratuits et également accélérés — mais le compte sandbox n'y sert à rien.
Les scénarios ci-dessous se font en build local (Xcode/`flutter run --release`),
pas en TestFlight.

### D.3 Scénarios à dérouler un par un

**Scénario 1 — Achat mensuel (avec essai)**

- [ ] Ouvrir le paywall → vérifier l'affichage : `Premium Mensuel 5,99 CHF` et
      `Premium Annuel 44,99 CHF`, mention « 14 jours gratuits ».
- [ ] Acheter le mensuel → feuille de paiement Apple `[Environment: Sandbox]` →
      confirmer avec le mot de passe du testeur sandbox.
- **Résultat attendu** : entitlement `premium` actif **immédiatement**
  (accès complet, création possible) ; événement `INITIAL_PURCHASE`
  (`period_type: TRIAL`) dans RevenueCat → webhook reçu dans les logs Supabase →
  ligne `subscriptions` à jour.

**Scénario 2 — Annulation → lecture seule à l'expiration**

- [ ] Réglages → App Store → compte sandbox → Gestion → **Abonnements** →
      résilier le renouvellement (ou simplement attendre les ~12
      renouvellements accélérés).
- [ ] Attendre l'expiration (quelques minutes), rouvrir l'app.
- **Résultat attendu** : événements `CANCELLATION` puis `EXPIRATION` dans
  RevenueCat/Supabase ; l'app passe en **mode lecture seule** — consulter,
  exporter, supprimer fonctionnent ; créer/modifier est bloqué avec un
  message clair ; **aucune donnée perdue**.

**Scénario 3 — Restauration après réinstallation**

- [ ] Avec un abonnement actif : supprimer l'app de l'iPhone → réinstaller
      (`flutter run --release …`) → se reconnecter au compte Supabase →
      paywall → **Restaurer les achats**.
- **Résultat attendu** : entitlement `premium` restauré **sans nouveau
  paiement** ; accès complet immédiat.

**Scénario 4 — Passage mensuel → annuel**

- [ ] Avec le mensuel actif : ouvrir le paywall (ou Réglages → Abonnements) →
      choisir l'annuel.
- **Résultat attendu** : l'annuel étant de rang supérieur dans le groupe,
  c'est une **montée en gamme immédiate** — l'annuel démarre tout de suite ;
  événement `PRODUCT_CHANGE` dans RevenueCat ; l'entitlement `premium` reste
  actif sans interruption.

**Scénario 5 — Renouvellements accélérés**

- [ ] Reprendre un abonnement mensuel et laisser tourner ~1 heure.
- **Résultat attendu** : une série d'événements `RENEWAL` (~toutes les
  5 minutes) puis `EXPIRATION` après ~12 renouvellements ; l'app reste en
  accès complet pendant les renouvellements, puis bascule en lecture seule.

**Scénario 6 — Second essai refusé (comportement normal)**

- [ ] Après une expiration, racheter avec le **même** testeur sandbox.
- **Résultat attendu** : **pas de nouvel essai gratuit** (déjà consommé dans
  le groupe) — prix plein directement. Pour retester l'essai : Réglages →
  App Store → compte sandbox → Gestion → **Effacer l'historique d'achats**,
  ou créer un nouveau testeur sandbox.

---

## E. Correspondance état RevenueCat → comportement AMIORA

La **vérité serveur** est le webhook (table `subscriptions` Supabase) ; le
client utilise `CustomerInfo` (SDK) pour réagir immédiatement. Les deux
doivent produire le même verdict :

| Situation (événement webhook) | Entitlement `premium` | Comportement de l'app |
|---|---|---|
| Essai en cours (`INITIAL_PURCHASE`, `period_type: TRIAL`) | Actif | **Accès complet** |
| Abonnement payé actif (`RENEWAL`, `period_type: NORMAL`) | Actif | **Accès complet** |
| Changement de plan (`PRODUCT_CHANGE`) | Actif (nouveau produit) | **Accès complet**, sans interruption |
| Renouvellement désactivé mais période payée en cours (`CANCELLATION`) | Actif jusqu'à la date d'expiration | **Accès complet** jusqu'à l'échéance (rappel discret possible) |
| Problème de paiement, période de grâce (`BILLING_ISSUE`, grâce active) | Actif (grâce) | **Accès complet** + inviter à mettre à jour le moyen de paiement |
| Expiration (`EXPIRATION`) | Inactif | **Lecture seule** : consulter · exporter · supprimer ; création/modification bloquées |
| Remboursement (`CANCELLATION` motif remboursement) | Inactif immédiatement | **Lecture seule** immédiate |
| Restauration / reconnexion (`Purchases.logIn` + restore) | Actif si abonnement valide | **Accès complet** |
| Jamais abonné (aucun événement) | Absent | **Paywall** (démarrer l'essai 14 jours) ; aucune création possible |

Invariant produit, à vérifier dans **chaque** état : les données restent
consultables, exportables et supprimables. **Jamais de confiscation.**
