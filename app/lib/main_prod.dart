// Point d'entrée prod : flutter run -t lib/main_prod.dart
// (équivaut à --dart-define=AMIORA_ENV=prod).
import 'main.dart' as base;

Future<void> main() => base.main();
