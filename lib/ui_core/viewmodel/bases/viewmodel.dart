import 'package:micro_memo/importer.dart';

base class ViewModel {
  final repo = Repository.instance;
}

base class UseAppSettingsViewModel extends ViewModel with UseAppSettingsMixin {
  UseAppSettingsViewModel(AppSettings settings) {
    appSettings = settings;
  }
}
