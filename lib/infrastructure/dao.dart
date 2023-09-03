import 'package:realm/realm.dart';
import 'package:micro_memo/importer.dart';

base class Dao {
  late final Realm realm;

  Dao() {
    _initRealm();
  }

  void _initRealm() {
    var config = Configuration.local([Memo.schema],
        // options
        initialDataCallback: null,
        schemaVersion: 1,
        fifoFilesFallbackPath: null,
        path: null,
        encryptionKey: null,
        disableFormatUpgrade: false,
        isReadOnly: false,
        shouldCompactCallback: null,
        migrationCallback: null,
        maxNumberOfActiveVersions: null,
        shouldDeleteIfMigrationNeeded: false);

    realm = Realm(config);
  }
}
