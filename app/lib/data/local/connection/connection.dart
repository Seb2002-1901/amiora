/// Ouverture de la base locale selon la plateforme (offline-first).
library;
export 'connection_native.dart' if (dart.library.js_interop) 'connection_web.dart';
