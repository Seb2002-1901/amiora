import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// iOS / Android / desktop : base SQLite dans le répertoire de support
/// applicatif (créé si nécessaire — indispensable sur desktop).
QueryExecutor openAmioraConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    await dir.create(recursive: true);
    return NativeDatabase.createInBackground(
      File(p.join(dir.path, 'amiora.sqlite')),
    );
  });
}
