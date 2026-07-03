// Point d'entrée staging : flutter run -t lib/main_staging.dart
// (équivaut à --dart-define=AMIORA_ENV=staging).
import 'main.dart' as base;

Future<void> main() => base.main();
