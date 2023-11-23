import 'package:micro_memo/importer.dart';
import 'package:realm/realm.dart' as realm;

final class HomeViewModel extends UseAppSettingsViewModel {
  late StreamController<realm.RealmResultsChanges<Memo>> memos;

  HomeViewModel(super.settings) {
    initialize();
  }

  void initialize() {
    memos = StreamController();
  }

  void loadMemos() async {
    Future(() {
      final fetched = repo.fetchAllMemo();
      memos.sink.addStream(fetched.changes);
    });
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
