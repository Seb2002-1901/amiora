import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

/// Web : SQLite compilé en WebAssembly, persistance IndexedDB/OPFS.
/// Nécessite web/sqlite3.wasm et web/drift_worker.js (voir app/README.md).
QueryExecutor openAmioraConnection() {
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'amiora',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );
    return result.resolvedExecutor;
  }));
}
