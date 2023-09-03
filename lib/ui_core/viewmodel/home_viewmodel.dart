import 'package:micro_memo/importer.dart';
import 'package:realm/realm.dart' as realm;

final class HomeViewModel extends UseAppSettingsViewModel {
  realm.RealmResults<Memo>? _fetchedMemos;

  HomeViewModel(super.settings) {
    initialize();
  }

  void initialize() {
    _fetchedMemos = null;
  }

  void loadMemos() async {
    _fetchedMemos = repo.fetchAllMemo();
  }

  Stream<realm.RealmResultsChanges<Memo>>? queryMemos() {
    return _fetchedMemos?.changes;
  }

  void updateMemoPrivacy(Memo memo, bool isPrivate) {
    final newMemo = memo.update(isPrivate: isPrivate);
    repo.upsertMemo(newMemo);
  }

  List<HomeListMenu> getListMenus(Memo memo) {
    final listMenuItems = [HomeListMenu.delete, HomeListMenu.registerTemplate];

    if (isEnabledPasscode) {
      listMenuItems.add(
          memo.isPrivate ? HomeListMenu.opened : HomeListMenu.closed
      );
    }

    return listMenuItems;
  }

  void deleteMemo(Memo memo) => repo.deleteMemo(memo);
}
