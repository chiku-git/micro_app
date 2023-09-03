import 'package:micro_memo/importer.dart';
import 'package:realm/realm.dart';

class Repository {
  static late Repository instance;

  static void init() {
    instance = Repository._(MemoDao(), SharedPreferenceManager.instance);
  }

  late final MemoDao _memoDao;
  late final SharedPreferenceManager _prefManager;

  Repository._(this._memoDao, this._prefManager);

  RealmResults<Memo> fetchAllMemo() {
    return _memoDao.fetchAllMemo();
  }

  RealmResults<Memo> fetchAllTemplate() {
    return _memoDao.fetchAllTemplate();
  }

  void upsertMemo(Memo memo) {
    _memoDao.upsert(memo);
  }

  void upsertTemplate(Memo memo) => upsertMemo(memo);

  void deleteMemo(Memo memo) {
    _memoDao.delete(memo);
  }

  void deleteTemplate(Memo template) => deleteMemo(template);

  Future<AppSettingsModel> fetchAppSettings() async {
    return _prefManager.fetchAppSettings();
  }

  Future<bool> updateAppSettings(AppSettingsModel model) {
    return _prefManager.updateAppSettings(model);
  }

  Future<bool> hasRegisteredPasscode() async {
    return await _prefManager.hasRegisteredPasscode();
  }

  Future<bool> registerPasscode(Passcode passcode) async {
    return await _prefManager.registerPasscode(passcode);
  }

  Future<bool> verifyPassword(Passcode passcode) async {
    return await _prefManager.verifyPasscode(passcode);
  }
}
