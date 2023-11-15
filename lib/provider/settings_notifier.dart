import 'package:micro_memo/importer.dart';

class SettingsNotifier extends ValueNotifier<AppSettingsModel> {
  SettingsNotifier(super.value);

  update(AppSettingsModel model) {
    value = model;
    notifyListeners();
  }
}

class ThemeNotifier extends ValueNotifier<bool> {
  ThemeNotifier(super.value);

  bool get isDark => value;

  switchTheme(bool isDark) {
    value = isDark;
  }
}