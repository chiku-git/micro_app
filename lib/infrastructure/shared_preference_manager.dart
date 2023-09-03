import 'package:micro_memo/importer.dart';

class SharedPreferenceManager {
  final String keyPasscode = 'passcode';
  final String keySettings = 'settings';

  static late SharedPreferenceManager instance;

  static void init() {
    instance = SharedPreferenceManager._();
  }

  SharedPreferenceManager._();

  /// passcodeの設定有無を返却する
  Future<bool> hasRegisteredPasscode() {
    return _getStringPreference(keyPasscode).then((passcode) {
      return passcode.isNotEmpty;
    });
  }

  /// passcodeを設定する
  Future<bool> registerPasscode(Passcode passcode) {
    return _setStringPreference(keyPasscode, passcode.digestHex);
  }

  /// passcodeを照合する
  Future<bool> verifyPasscode(Passcode passcode) {
    return _getStringPreference(keyPasscode).then((digestHex) {
      return passcode.digestHex == digestHex;
    });
  }

  Future<AppSettingsModel> fetchAppSettings() {
    return _getStringPreference(keySettings).then((settings) {
      if (settings.isEmpty) {
        return AppSettingsModel.getDefault();
      } else {
        return AppSettingsModel.fromJsonMap(jsonDecode(settings));
      }
    });
  }

  Future<bool> updateAppSettings(AppSettingsModel model) {
    final json = jsonEncode(model.toJsonMap());
    return _setStringPreference(keySettings, json);
  }

  /// String形式のpreferenceを返却する
  Future<String> _getStringPreference(String key) {
    return SharedPreferences.getInstance().then((pref) {
      return pref.getString(key) ?? "";
    });
  }

  /// String形式のpreferenceを設定する
  Future<bool> _setStringPreference(String key, String value) {
    return SharedPreferences.getInstance().then((pref) {
      return pref.setString(key, value);
    });
  }
}
