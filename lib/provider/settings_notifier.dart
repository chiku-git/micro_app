import 'package:micro_memo/importer.dart';

class SettingsNotifier extends ValueNotifier<AppSettingsModel> {
  SettingsNotifier(super.value);

  update(AppSettingsModel model) {
    value = model;
    notifyListeners();
  }
}