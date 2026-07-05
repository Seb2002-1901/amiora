# AMIORA sur iPhone — procédure officielle Profile / Release / TestFlight

Document opérationnel. Référence : commit du projet Xcode versionné
(`app/ios/`), identifiant `ch.amiora.amiora`, cible iOS 13.0.

---

## 1. Le « bug » du mode Debug n'en est pas un

L'écran **« In iOS 14+ debug mode Flutter apps can only be launched from
Flutter tooling, IDEs with Flutter plugins or from Xcode »** est le
comportement **documenté et voulu** de Flutter depuis iOS 14, sur tous les
iOS récents (y compris iOS 26) :

- En **Debug**, Flutter exécute le Dart en JIT. iOS n'autorise le JIT que
  si un débogueur est attaché. Une app Debug lancée **depuis l'icône de
  l'écran d'accueil** (sans `flutter run` ni Xcode) n'a pas ce privilège
  → Flutter affiche cet écran au lieu de planter.
- Référence officielle : https://docs.flutter.dev/testing/build-modes et
  https://github.com/flutter/flutter/issues/62888 (annonce du comportement).

**Conclusion : sur appareil réel, on utilise Profile ou Release.**
Le mode Debug reste réservé au développement avec `flutter run` attaché
(hot reload). Rien à « réparer » — le projet est configuré pour que les
chemins normaux n'y exposent plus.

## 2. Ce que le projet garantit désormais

| Garantie | Mécanisme |
|---|---|
| ▶ dans Xcode installe une app **autonome** | Scheme `Runner` : LaunchAction en **Release** (versionné) |
| Archive TestFlight en Release | Scheme `Runner` : ArchiveAction en Release (défaut conservé) |
| Pods reproductibles (RevenueCat, Firebase…) | `ios/Podfile` versionné, `platform :ios, '13.0'` explicite |
| Le mode Profile compile | Vérifié en CI : job « Compilation iOS » = `flutter build ios --no-codesign --profile` |
| Pas de flash blanc au lancement | LaunchScreen au fond `#0B0B0D` |

## 3. Lancer sur iPhone — deux chemins équivalents

Toujours depuis `app/` après `flutter pub get` (et le retrait du bloc
`hooks:` final de `pubspec.yaml`, spécifique à l'environnement de dev).

### A. En ligne de commande (recommandé pour tester la fluidité)

```bash
flutter devices                    # relever l'UDID de l'iPhone
flutter run --profile -d <UDID>    # AOT + overlay de performance possible
# ou, identique au produit final :
flutter run --release -d <UDID>
```

L'app installée ainsi **se relance ensuite librement depuis l'écran
d'accueil** — plus jamais l'écran Debug.

### B. Depuis Xcode

1. Ouvrir **`ios/Runner.xcworkspace`** (jamais `Runner.xcodeproj` : le
   workspace référence les pods ; le projet seul ne linke pas RevenueCat).
2. Cible Runner → Signing & Capabilities → Team (Personal Team suffit).
3. ▶ — le scheme versionné construit en **Release** : app autonome.

## 4. Contraintes du Personal Team (compte Apple gratuit)

- Profil de provisionnement valable **7 jours** → relancer un build pour
  renouveler. Maximum 3 apps installées ainsi.
- Premier lancement : Réglages → Général → VPN et gestion de l'appareil →
  faire confiance au développeur.
- iPhone : Mode développeur activé (Réglages → Confidentialité et
  sécurité → Mode développeur).

## 5. TestFlight (dès l'adhésion Apple Developer Program, 99 USD/an)

1. App Store Connect → créer l'app avec l'identifiant `ch.amiora.amiora`.
2. Dans Xcode (workspace ouvert, Team = équipe payante) :
   Product → **Archive** (Release automatique) → Distribute App →
   **TestFlight & App Store**.
3. `ITSAppUsesNonExemptEncryption=false` est déjà déclaré dans
   `Info.plist` : pas de questionnaire chiffrement à chaque build.
4. TestFlight → ajouter les testeurs internes (jusqu'à 100, immédiat,
   sans revue) — le canal prévu pour la bêta privée AMIORA.

## 6. Dépannage

| Symptôme | Cause | Remède |
|---|---|---|
| Écran « In iOS 14+ debug mode… » | Build Debug lancé depuis l'icône | Reconstruire en Profile/Release (§ 3) |
| `Runner.xcodeproj` ouvert, erreurs de link RevenueCat | Pods absents du projet seul | Ouvrir `Runner.xcworkspace` |
| Pods incohérents après changement de branche | Cache CocoaPods | `cd ios && pod install --repo-update` |
| L'app expire après une semaine | Profil Personal Team (7 jours) | Relancer un build, ou TestFlight |
| `flutter run --profile` : « Profile mode is not supported on simulator » | Le Simulator ne fait pas d'AOT | Utiliser l'iPhone réel, ou `--debug` sur Simulator |
