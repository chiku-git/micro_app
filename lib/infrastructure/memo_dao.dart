import 'package:micro_memo/importer.dart';
import 'package:realm/realm.dart';

final class MemoDao extends Dao {
  RealmResults<Memo> fetchAllMemo() {
    return _query("type == \$0", [MemoType.memo.value]);
  }

  RealmResults<Memo> fetchAllTemplate() {
    return _query("type == \$0", [MemoType.template.value]);
  }

  RealmResults<Memo> _query(String query, List<Object> args) {
    return realm.query(query, args);
  }

  Memo? findById(ObjectId id) {
    return realm.find(id);
  }

  void upsert(Memo memo) {
    bool isUpdated = memo.updatedAt != null;
    realm.write(() => {realm.add(memo, update: isUpdated)});
  }

  void delete(Memo memo) {
    realm.write(() => {realm.delete(memo)});
  }
}
