# Guide de publication — AMIORA (de A à Z)

Document opérationnel : du dépôt Git à l'App Store, puis la vie après.
Prérequis : `APP_STORE_CHECKLIST.md` déroulée, `PAYMENTS_SETUP.md` sections
A–C terminées. Tout se fait depuis le Mac, dans le dossier `app/` du dépôt.

---

## 1. Préparer le build

- [ ] 1. Se placer sur la branche principale, à jour et **propre**
      (`git status` sans modification en attente).
- [ ] 2. **Retirer le bloc `hooks:` de fin de `pubspec.yaml`** (liaison sqlite3
      spécifique à l'environnement de dev derrière proxy — jamais dans un
      build officiel) :

      ```bash
      cd app
      sed -i '' '/^# Environnement CI derrière proxy/,$d' pubspec.yaml
      ```

      ⚠️ Ne **pas committer** ce retrait : c'est une modification locale de
      build. Après l'archive, `git checkout pubspec.yaml` pour le restaurer.
- [ ] 3. **Incrémenter la version** dans `app/pubspec.yaml` (ligne `version:`) :
      - Première publication : `0.1.0+1` → **`1.0.0+2`**.
      - Format `X.Y.Z+N` : `X.Y.Z` = version visible (CFBundleShortVersionString),
        `N` = numéro de build (CFBundleVersion).
      - ⚠️ **Chaque envoi** vers App Store Connect exige un `N` strictement
        supérieur au précédent, même pour la même version visible.
      - Ce changement-là **se committe** (contrairement au retrait des hooks).
- [ ] 4. Régénérer et vérifier :

      ```bash
      flutter pub get
      dart run build_runner build --delete-conflicting-outputs
      flutter analyze
      flutter test
      ```
- [ ] 5. Préparer les **trois dart-defines de production** (valeurs sous la main) :
      `SUPABASE_URL`, `SUPABASE_ANON_KEY` (clé publique uniquement),
      `REVENUECAT_API_KEY` (clé `appl_…`).

---

## 2. Construire l'archive signée

### Voie recommandée : ligne de commande

```bash
flutter build ipa --release \
  --dart-define=SUPABASE_URL=https://<PROJET>.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=<clé anon publique> \
  --dart-define=REVENUECAT_API_KEY=appl_xxxxxxxxxxxx
```

Produit :
- l'archive : `app/build/ios/archive/Runner.xcarchive`
- le paquet : `app/build/ios/ipa/amiora.ipa` (nom selon le projet)

Prérequis : signature configurée avec l'équipe payante
(`APP_STORE_CHECKLIST.md` § 3). En cas d'erreur de signature, ouvrir le
workspace dans Xcode et corriger Signing & Capabilities, puis relancer.

### Voie alternative : Xcode

1. ⚠️ **D'abord** injecter les dart-defines (Xcode ne les connaît pas) :

   ```bash
   flutter build ios --config-only --release \
     --dart-define=SUPABASE_URL=... \
     --dart-define=SUPABASE_ANON_KEY=... \
     --dart-define=REVENUECAT_API_KEY=appl_...
   ```
2. Ouvrir **`app/ios/Runner.xcworkspace`** (jamais le `.xcodeproj`).
3. Barre d'appareils : sélectionner **Any iOS Device (arm64)**.
4. Menu **Product → Archive** (le scheme versionné archive en Release).

⚠️ **Piège** : archiver depuis Xcode **sans** l'étape 1 embarque les
dart-defines du dernier `flutter build`/`flutter run` — potentiellement les
clés de dev. La voie `flutter build ipa` évite ce piège entièrement.

---

## 3. Envoyer le build vers App Store Connect

**Option A — Xcode Organizer** (si archive Xcode ou après `flutter build ipa`) :

- [ ] 1. Xcode → **Window → Organizer** → onglet Archives → sélectionner
      l'archive du jour.
- [ ] 2. **Distribute App → App Store Connect → Upload** → suivant partout
      (signature automatique, symboles inclus).

**Option B — Transporter** (plus simple avec un `.ipa`) :

- [ ] 1. Installer **Transporter** (gratuit, Mac App Store).
- [ ] 2. Se connecter avec l'identifiant Apple Developer.
- [ ] 3. Glisser `app/build/ios/ipa/*.ipa` → **Livrer (Deliver)**.

Après l'envoi :

- [ ] 4. App Store Connect → AMIORA → **TestFlight** : le build apparaît
      « En traitement » (5–30 min). E-mail d'Apple quand il est prêt.
      ⚠️ Grâce à `ITSAppUsesNonExemptEncryption=false` déjà déclaré, pas de
      questionnaire chiffrement — le build passe directement à « Prêt à tester ».

---

## 4. TestFlight — interne puis externe

### 4.1 Test interne (immédiat, sans revue Apple)

- [ ] 1. App Store Connect → **Utilisateurs et accès** : inviter les proches
      testeurs (rôle « Développeur » ou « Marketing » suffit) — ils doivent
      accepter l'invitation e-mail.
- [ ] 2. AMIORA → TestFlight → **Tests internes → +** → créer le groupe
      `Bêta privée` → cocher les testeurs (max 100).
- [ ] 3. Sélectionner le build → renseigner **« Informations de test »
      (What to Test / notes de build)** : ce qui a changé, ce qu'il faut
      essayer, comment signaler un problème.
- [ ] 4. Les testeurs installent l'app **TestFlight** depuis l'App Store,
      acceptent l'invitation, installent AMIORA.

⚠️ Rappels TestFlight :
- Les achats y sont **gratuits** et utilisent des reçus de type sandbox avec
  renouvellements accélérés — ne pas s'inquiéter de « paiements » étranges.
- Le compte sandbox de `PAYMENTS_SETUP.md` § D **ne sert pas** en TestFlight
  (environnements différents) : les testeurs utilisent leur vrai identifiant Apple.
- Un build TestFlight expire après **90 jours**.

### 4.2 Test externe (optionnel, revue bêta ~24 h)

- [ ] 1. TestFlight → **Tests externes → +** → groupe `Bêta publique`.
- [ ] 2. Ajouter le build → première fois : **revue bêta Apple** (~24 h,
      plus légère que la revue App Store).
- [ ] 3. Inviter par e-mail ou activer le **lien public** (jusqu'à
      10 000 testeurs).

---

## 5. Vérifications finales avant soumission (checklist courte)

- [ ] Fiche complète : description FR, mots-clés, sous-titre, captures 6,9" et
      6,5" (± iPad selon la décision `APP_STORE_CHECKLIST.md` § 5.4).
- [ ] URL de politique de confidentialité en ligne et renseignée ; fiche
      **Confidentialité de l'app** remplie (e-mail, identifiant, contenu,
      achats — liés à l'identité, **pas de tracking**).
- [ ] Les **2 abonnements** au statut « Prêt à soumettre » et **sélectionnés
      sur la page de la version 1.0** (section Achats intégrés et abonnements).
      ⚠️ Oubli = rejet ou paywall vide en production.
- [ ] Paywall vérifié en TestFlight : prix corrects, essai 14 jours affiché,
      bouton Restaurer, liens Confidentialité + CGU.
- [ ] Compte démo pour la revue : identifiants valides, entitlement `premium`
      actif (via Grant Entitlement RevenueCat), données réalistes.
- [ ] Webhook RevenueCat → Supabase : événement de test à 200 dans les logs.
- [ ] Le build candidat a été **réellement utilisé** sur iPhone (parcours
      complet : inscription → essai → création → export).

---

## 6. Soumettre à la revue App Store

- [ ] 1. App Store Connect → AMIORA → page **1.0** → section Build →
      **+** → sélectionner le build TestFlight validé.
- [ ] 2. **Informations pour la revue** : compte démo (identifiant + mot de
      passe) coché et rempli, notes de revue en anglais
      (texte type dans `APP_STORE_CHECKLIST.md` § 8.4), téléphone joignable.
- [ ] 3. **Publication** : choisir « Publier manuellement cette version »
      (recommandé : on maîtrise l'instant du lancement) plutôt que
      la publication automatique après approbation.
- [ ] 4. **Soumettre pour vérification.**

**Temps de revue typique** : 24–48 h (90 % des apps en moins de 24 h ;
prévoir jusqu'à une semaine en période de fêtes). Statuts visibles dans
App Store Connect ; e-mail à chaque changement.

### Motifs de rejet fréquents pour une app à abonnement — et la réponse AMIORA

| Guideline | Motif fréquent | Réponse AMIORA |
|---|---|---|
| **3.1.1 / 3.1.2** (achats) | Paywall sans prix/durée/mention de renouvellement ; pas de bouton Restaurer ; liens CGU/confidentialité absents | Paywall affiche 5,99 CHF/mois, 44,99 CHF/an, essai 14 jours, renouvellement auto ; `restore()` câblé ; liens présents (vérifié § 5) |
| **3.1.2** | L'utilisateur perd ses données s'il ne paie plus | **Mode lecture seule** : consulter/exporter/supprimer toujours possibles — l'expliquer dans les notes de revue |
| **2.1** (complétude) | Examinateur bloqué au paywall / compte démo invalide / abonnements non joints au binaire | Compte démo premium fourni ; abonnements sélectionnés sur la version (§ 5) |
| **5.1.1** (confidentialité) | Pas de politique de confidentialité ; collecte non déclarée ; pas de suppression de compte dans l'app | URL publiée ; fiche App Privacy exacte ; suppression de compte intégrée (fonction `account-deletion`) |
| **5.1.2** (tracking) | ATT manquant alors que la fiche déclare du tracking | AMIORA ne trace pas (`PrivacyInfo` : tracking=false) → pas d'ATT, fiche cohérente |
| **4.8** (connexion) | Login social tiers sans « Sign in with Apple » | Décision figée avant soumission (`APP_STORE_CHECKLIST.md` § 10.3) |

**En cas de rejet** : répondre dans le **Centre de résolution** (App Store
Connect) — souvent une clarification suffit, sans nouveau build. Rester
factuel, citer la guideline, expliquer le mode lecture seule.

---

## 7. Après la publication — piloter les abonnements

**App Store Connect** :

- **Analyses (App Analytics)** : téléchargements, conversions de la fiche.
- **Tendances des ventes** et **Paiements et accords** : revenus, versements
  bancaires (mensuels, ~33 jours après la fin du mois fiscal Apple).
- **Monétisation → Abonnements** : changer un prix (les abonnés existants sont
  notifiés/consentent selon le cas), ajouter des offres promotionnelles.
- ⚠️ Les remboursements sont décidés par **Apple**, pas par vous : l'événement
  arrive via RevenueCat (`CANCELLATION`) et l'app repasse en lecture seule.

**RevenueCat (dashboard)** :

- **Overview / Charts** : abonnés actifs, essais en cours, conversion
  essai → payant (KPI PRD), MRR, churn.
- **Customers** : rechercher un utilisateur (par UUID Supabase grâce à
  `Purchases.logIn`), voir son historique, **Grant Entitlement** pour un
  geste commercial ou le compte démo.
- Vérifier périodiquement les livraisons du **webhook** (Integrations →
  Webhooks → historique) et les logs Supabase correspondants.

---

## 8. Mises à jour futures

- [ ] 1. Incrémenter dans `app/pubspec.yaml` : correctif `1.0.1+3`,
      fonctionnalités `1.1.0+4`, etc. — le numéro de build (`+N`) augmente
      **toujours**.
- [ ] 2. Refaire §§ 1–3 (mêmes commandes, mêmes dart-defines).
- [ ] 3. App Store Connect → **+ Nouvelle version** → rédiger les
      **« Nouveautés » (changelog)** en français, orienté utilisateur.
- [ ] 4. Joindre le build, soumettre (revue complète à chaque mise à jour,
      généralement plus rapide).
- [ ] 5. **Publication progressive (phased release)** : sur la page de version,
      activer « Publier la mise à jour par étapes » — déploiement automatique
      sur 7 jours (1 % → 100 %), interruptible en cas de bug.
      Disponible pour les mises à jour uniquement, pas pour la 1.0.
- [ ] 6. ⚠️ Si la collecte de données évolue (nouveau SDK, analytics), mettre à
      jour `PrivacyInfo.xcprivacy` **et** la fiche Confidentialité de l'app
      **avant** de soumettre.

---

## 9. Préparation Google Play — *quand un appareil Android sera disponible*

À ne faire que le moment venu ; rien n'est bloquant pour iOS.

- [ ] 1. **Générer le keystore de signature** (une seule fois, à vie) :

      ```bash
      keytool -genkey -v -keystore ~/amiora-release.keystore \
        -alias amiora -keyalg RSA -keysize 2048 -validity 10000
      ```

      ⚠️ **GARDER PRÉCIEUSEMENT** le fichier `.keystore` **et** ses deux mots de
      passe (coffre + sauvegarde hors machine). Perdus = plus aucune mise à
      jour possible de l'app publiée. Ne **jamais** le committer dans Git.
      (Play App Signing, activé par défaut à la création de l'app, atténue ce
      risque : Google garde la clé finale — l'activer.)
- [ ] 2. Créer `app/android/key.properties` (non versionné) pointant vers le
      keystore — **CÔTÉ CODE** : brancher `signingConfigs.release` dans
      `app/android/app/build.gradle` le moment venu.
- [ ] 3. Construire : `flutter build appbundle --release --dart-define=…`
      (mêmes defines qu'iOS **sauf** `REVENUECAT_API_KEY=goog_…`, la clé
      Google du même projet RevenueCat).
- [ ] 4. **Play Console** (https://play.google.com/console, 25 USD une fois) :
      créer l'app AMIORA, remplir la fiche (description FR, captures,
      icône), le questionnaire **Sécurité des données** (mêmes réponses que la
      fiche App Privacy iOS), classification du contenu.
- [ ] 5. Paiements : produits d'abonnement équivalents dans Play Console +
      app Android dans RevenueCat (mêmes entitlement `premium` et offering
      `default` — seuls les produits stores diffèrent).
- [ ] 6. Passer par la piste **Tests internes** avant toute production.
