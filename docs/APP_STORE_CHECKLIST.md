# Checklist App Store — AMIORA

Document opérationnel. À dérouler **dans l'ordre**. Chaque item est marqué :

- **✅ DÉJÀ FAIT** — présent dans le dépôt, à vérifier une fois, ne rien refaire.
- **CÔTÉ FONDATEUR** — action dans un navigateur ou sur l'iPhone, sans développeur.
- **CÔTÉ CODE** — nécessite une modification du projet (à demander/planifier).

Références projet : identifiant `ch.amiora.amiora` · nom affiché **AMIORA** ·
version `0.1.0+1` · iOS 13.0 minimum · portrait uniquement sur iPhone.

---

## 0. Déjà en place dans le code (vérification unique)

- [x] Identifiant d'app (Bundle ID) : `ch.amiora.amiora` (`app/ios/Runner.xcodeproj`)
- [x] Nom affiché sous l'icône : **AMIORA** (`CFBundleDisplayName`, `app/ios/Runner/Info.plist`)
- [x] Icône d'app fournie (`Assets.xcassets/AppIcon`)
- [x] Écran de lancement sombre `#0B0B0D` (pas de flash blanc)
- [x] Portrait uniquement sur iPhone (`UISupportedInterfaceOrientations`)
- [x] Manifeste de confidentialité `PrivacyInfo.xcprivacy` (tracking = false ;
      e-mail, identifiant utilisateur, contenu utilisateur, historique d'achats —
      finalité « App Functionality »)
- [x] Déclaration chiffrement `ITSAppUsesNonExemptEncryption = false` dans `Info.plist`
      → **aucun questionnaire d'export à remplir à chaque build**
- [x] Schéma d'URL OAuth `ch.amiora.app` déclaré (callback `ch.amiora.app://login-callback`)

---

## 1. Compte Apple Developer Program — CÔTÉ FONDATEUR

Prérequis absolu : rien d'autre n'est possible sans lui. Inscription en cours → finaliser.

- [ ] 1. Vérifier que l'identifiant Apple utilisé a la **validation en deux étapes activée**
      (obligatoire) : iPhone → Réglages → [votre nom] → Connexion et sécurité.
- [ ] 2. Terminer l'inscription sur https://developer.apple.com/programs/enroll/
      (99 USD/an). Choisir **Individuel** (le plus simple ; « Organisation » exige un
      numéro D-U-N-S et des semaines de délai — inutile pour lancer).
- [ ] 3. Payer, puis attendre l'e-mail de confirmation d'Apple (généralement 24–48 h).
- [ ] 4. Vérifier l'accès à https://appstoreconnect.apple.com (le compte App Store
      Connect est créé automatiquement avec l'adhésion — rien à créer séparément).

⚠️ **Piège** : ne pas s'inscrire avec un identifiant Apple « jetable ». Ce compte
détiendra l'app, les contrats bancaires et les certificats pour des années.

---

## 2. App Store Connect — enregistrer l'identifiant et créer l'app — CÔTÉ FONDATEUR

- [ ] 1. Enregistrer le Bundle ID : https://developer.apple.com →
      **Certificates, Identifiers & Profiles → Identifiers → +** →
      « App IDs » → type « App » → Description : `AMIORA` →
      Bundle ID **Explicit** : `ch.amiora.amiora` → Continue → Register.
      (Aucune « Capability » à cocher pour l'instant ; les achats intégrés
      sont inclus d'office.)
- [ ] 2. Créer l'app : https://appstoreconnect.apple.com → **Mes apps → +
      → Nouvelle app** :
      - Plateforme : **iOS**
      - Nom : **AMIORA** — ⚠️ le nom doit être **unique sur tout l'App Store**.
        Si « AMIORA » est pris, prévoir un repli du type « AMIORA — Présence »
        (le nom sous l'icône, lui, reste AMIORA).
      - Langue principale : **Français**
      - Identifiant de lot (Bundle ID) : sélectionner `ch.amiora.amiora`
      - SKU : `amiora-ios-001` (interne, invisible du public)
      - Accès utilisateur : accès complet.
- [ ] 3. Noter l'**Apple ID numérique de l'app** (fiche App Information) — utile
      pour RevenueCat et Transporter.

⚠️ **Piège** : le Bundle ID est **définitif** après le premier build envoyé.
Vérifier deux fois `ch.amiora.amiora` avant de créer l'app.

---

## 3. Signature — passer du Personal Team à l'équipe payante — CÔTÉ FONDATEUR (sur le Mac)

Aujourd'hui le projet se signe avec un « Personal Team » (profil 7 jours).
Dès l'adhésion validée :

- [ ] 1. Xcode → **Settings… → Accounts** → sélectionner l'identifiant Apple →
      vérifier que l'équipe payante apparaît (nom + « Individual »/rôle Agent).
      Sinon : bouton **+** pour ajouter le compte.
- [ ] 2. Ouvrir **`app/ios/Runner.xcworkspace`** (jamais le `.xcodeproj` seul).
- [ ] 3. Cible **Runner → Signing & Capabilities** → pour **Release** (et Debug) :
      - « Automatically manage signing » : coché
      - **Team** : sélectionner l'équipe payante (remplace le Personal Team)
- [ ] 4. Vérifier que « Provisioning Profile » affiche « Xcode Managed Profile »
      sans erreur rouge.
- [ ] 5. Lancer une fois l'app sur l'iPhone (▶) pour valider la nouvelle signature —
      l'app n'expirera plus au bout de 7 jours.

⚠️ **Piège** : si Xcode propose deux équipes au nom identique (Personal Team +
équipe payante), la payante est celle **sans** la mention « (Personal Team) ».

---

## 4. Métadonnées de la fiche App Store — CÔTÉ FONDATEUR

Dans App Store Connect → Mes apps → AMIORA → **Distribution App Store** (page de version 1.0) :

- [ ] 1. **Nom** (30 caractères max) : `AMIORA`
- [ ] 2. **Sous-titre** (30 caractères max) — proposition : `Cultivez vos relations`
      ou `La présence au quotidien` (choisir, vérifier ≤ 30 caractères).
- [ ] 3. **Description** (français, 4000 caractères max) : rédiger à partir du PRD.
      Doit mentionner clairement : abonnement requis, essai gratuit 14 jours,
      prix (5,99 CHF/mois ou 44,99 CHF/an), et qu'après expiration les données
      restent consultables/exportables (jamais confisquées).
- [ ] 4. **Mots-clés** (100 caractères max, séparés par des virgules, sans espaces
      superflus) — proposition : `relations,couple,famille,amis,souvenirs,journal,présence,liens,proches`
- [ ] 5. **Catégorie principale** : **Style de vie (Lifestyle)**. Catégorie
      secondaire (facultatif) : Productivité.
- [ ] 6. **Tranche d'âge** : remplir le questionnaire (App Information →
      Classification par âge) honnêtement — aucun contenu choquant, pas de jeu
      d'argent, pas d'accès web non restreint → résultat attendu **4+**.
      ⚠️ Le contenu créé par l'utilisateur reste **privé** (non partagé entre
      utilisateurs) : répondre « non » aux questions sur le contenu généré par
      les utilisateurs *visible par d'autres*.
- [ ] 7. **URL d'assistance** (obligatoire) : page support/contact (voir § 6).
      **URL marketing** : facultative.
- [ ] 8. **Copyright** : `© 2026 <nom du fondateur>`.
- [ ] 9. **Coordonnées pour la revue** (App Review → Informations de contact) :
      nom, e-mail, **numéro de téléphone joignable**.

---

## 5. Captures d'écran — CÔTÉ FONDATEUR

Obligatoires avant toute soumission. Prises depuis le **Simulateur iOS**
(Xcode → Open Developer Tool → Simulator ; capture : Cmd+S) ou depuis un iPhone réel
puis redimensionnées exactement.

- [ ] 1. **6,9 pouces (obligatoire)** — iPhone 16 Pro Max ou équivalent :
      **1320 × 2868 px** (portrait). 3 à 10 captures.
- [ ] 2. **6,5 pouces (obligatoire)** — iPhone 11 Pro Max / XS Max :
      **1284 × 2778 px** (portrait). 3 à 10 captures.
- [ ] 3. Contenu conseillé (dans l'ordre) : écran d'accueil avec l'Indice ·
      une relation avec photos · création d'un souvenir · l'écran Premium
      (montrant clairement essai 14 jours et les deux prix) · réglages/export.
      Utiliser des **données de démonstration** (jamais de vraies personnes).
- [ ] 4. ⚠️ **iPad** : le projet Xcode supporte actuellement l'iPad
      (`TARGETED_DEVICE_FAMILY = 1,2`). Deux options — **décider avant la soumission** :
      - **Option A (recommandée pour la v1)** — CÔTÉ CODE : restreindre à
        l'iPhone (device family « iPhone » uniquement dans Xcode) →
        aucune capture iPad requise, pas de revue sur iPad.
      - **Option B** : garder l'iPad → captures **iPad 13 pouces 2064 × 2752 px**
        obligatoires **et** l'app doit être irréprochable sur iPad pendant la revue.

⚠️ **Piège** : des captures aux mauvaises dimensions sont refusées à l'upload ;
des captures montrant un autre appareil que celui du gabarit (cadre iPhone
dans un gabarit iPad) sont un motif de rejet.

---

## 6. Politique de confidentialité et conditions d'utilisation — CÔTÉ FONDATEUR

- [ ] 1. Rédiger et **héberger** une politique de confidentialité en français
      (URL publique stable, p. ex. `https://amiora.ch/confidentialite`).
      Doit couvrir : données collectées (e-mail, identifiant, contenu, achats),
      hébergement Supabase (Zurich, Suisse), sous-traitants (Apple, RevenueCat,
      Supabase), droits (accès, export, suppression — l'app propose export et
      suppression de compte intégrés), contact.
- [ ] 2. Rédiger des **conditions d'utilisation** (URL publique) : abonnement
      auto-renouvelable, essai 14 jours, résiliation via Réglages iOS,
      mode lecture seule après expiration, propriété des données par l'utilisateur.
- [ ] 3. Renseigner l'**URL de politique de confidentialité** dans App Store
      Connect → App → **Confidentialité de l'app** (champ URL obligatoire).
- [ ] 4. Renseigner l'URL des conditions d'utilisation dans le champ
      « Contrat de licence » ou dans la description (lien visible).
- [ ] 5. **CÔTÉ CODE** : vérifier que le **paywall de l'app** affiche des liens
      cliquables vers la politique de confidentialité ET les conditions
      d'utilisation, plus prix, durée et mention du renouvellement automatique.
      ⚠️ Exigence stricte de la guideline **3.1.2** — motif de rejet n°1 des
      apps à abonnement.

---

## 7. Fiche « Confidentialité de l'app » (App Privacy) — CÔTÉ FONDATEUR

App Store Connect → App → **Confidentialité de l'app** → Commencer.
Répondre **exactement** ceci, pour rester cohérent avec `PrivacyInfo.xcprivacy` :

- [ ] 1. « Collectez-vous des données ? » → **Oui**.
- [ ] 2. Types de données collectées :
      - **Coordonnées → Adresse e-mail**
      - **Identifiants → Identifiant utilisateur**
      - **Contenu utilisateur → Photos ou vidéos** et **Autre contenu utilisateur**
      - **Achats → Historique des achats**
- [ ] 3. Pour **chacun** des quatre types : finalité = **Fonctionnalité de l'app**
      (App Functionality) uniquement · **liées à l'identité de l'utilisateur : Oui** ·
      **utilisées pour le suivi (tracking) : Non**.
- [ ] 4. Ne rien déclarer d'autre (pas de localisation, pas de diagnostic, pas
      de données publicitaires).

⚠️ **Pièges** :
- Tracking = **Non** partout → l'app n'a **pas besoin d'ATT** (App Tracking
  Transparency). N'ajouter aucune demande d'autorisation de suivi dans l'app.
- Toute incohérence entre cette fiche et `PrivacyInfo.xcprivacy` est détectable
  par Apple → répondre exactement comme ci-dessus.
- Si un jour un SDK d'analytics est ajouté, cette fiche **doit** être mise à jour
  avant la soumission suivante.

---

## 8. Notes pour la revue Apple — compte démo — CÔTÉ FONDATEUR

Apple **doit** pouvoir tester l'app entière. AMIORA n'a pas de plan gratuit :
sans préparation, l'examinateur reste bloqué au paywall → rejet quasi certain.

- [ ] 1. Créer un compte de démonstration dans Supabase (prod) :
      e-mail `demo.review@amiora.ch` (ou équivalent) + mot de passe robuste dédié.
- [ ] 2. Remplir ce compte de **données réalistes** (2–3 relations, photos
      libres de droits, souvenirs, historique) — l'examinateur juge l'app remplie.
- [ ] 3. Donner l'accès premium au compte démo **sans paiement** : dashboard
      RevenueCat → Customers → rechercher l'identifiant du compte démo →
      **Grant Entitlement** → `premium`, durée longue (voir `PAYMENTS_SETUP.md`).
- [ ] 4. App Store Connect → page de version → **Informations pour la revue** :
      - Cocher « Un compte de connexion est requis » et renseigner
        identifiant + mot de passe du compte démo.
      - Notes (en anglais, l'équipe de revue est anglophone) — inclure :
        « AMIORA is a private relationship journal. A subscription is required
        (14-day free trial). The provided demo account already has premium
        access. Purchases can also be tested: the review environment uses
        sandbox billing. After subscription expiry the app switches to a
        read-only mode: users can always view, export and delete their data. »
- [ ] 5. Vérifier le compte démo **la veille de chaque soumission** (mot de passe
      valide, entitlement actif, données présentes).

⚠️ **Piège** : compte démo expiré ou vide = rejet « Guideline 2.1 — Information
Needed », qui coûte un aller-retour complet de revue.

---

## 9. Conformité export (chiffrement) — ✅ DÉJÀ FAIT

- [x] `ITSAppUsesNonExemptEncryption = false` est dans `Info.plist` : l'app
      n'utilise que le chiffrement standard (HTTPS). Aucune question à l'upload,
      aucune déclaration annuelle. **Ne rien faire.**

---

## 10. Points de code restants avant soumission — CÔTÉ CODE

- [ ] 1. **Paywall conforme 3.1.2** : prix, durée, mention du renouvellement
      automatique, bouton **Restaurer les achats**, liens Confidentialité + CGU
      (voir § 6.5). L'app appelle déjà `offerings()/purchase()/restore()` —
      vérifier que « Restaurer » est visible sans achat préalable.
- [ ] 2. **Suppression de compte dans l'app** (guideline 5.1.1(v)) : la fonction
      Supabase `account-deletion` existe — vérifier que le bouton est accessible
      depuis les réglages de l'app.
- [ ] 3. **Connexion** : si un fournisseur social tiers (Google, etc.) est proposé
      via Supabase OAuth, **« Sign in with Apple » devient obligatoire**
      (guideline 4.8). E-mail/mot de passe seul = pas d'obligation.
      ⚠️ Décision à figer avant soumission.
- [ ] 4. **Décision iPad** (voir § 5.4) : restreindre à l'iPhone ou assumer l'iPad.
- [ ] 5. Version de release : passer `0.1.0+1` → `1.0.0+2` dans `app/pubspec.yaml`
      (voir `RELEASE_GUIDE.md` § 1).

---

## 11. Ordre de bataille récapitulatif

1. § 1 Compte Developer (24–48 h de délai Apple) — **commencer maintenant**.
2. § 2 Bundle ID + création de l'app dans App Store Connect.
3. **En parallèle** : accords bancaires + abonnements (→ `PAYMENTS_SETUP.md`,
   sections A puis B) — ⚠️ le plus long à débloquer, ne pas attendre.
4. § 3 Signature payante sur le Mac.
5. § 6 Politique de confidentialité + CGU en ligne.
6. § 4–5 Métadonnées + captures.
7. § 7 Fiche App Privacy.
8. § 10 Derniers points de code.
9. § 8 Compte démo + notes de revue.
10. Build, TestFlight, soumission (→ `RELEASE_GUIDE.md`).
