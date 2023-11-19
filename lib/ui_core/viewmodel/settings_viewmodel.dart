import 'package:micro_memo/importer.dart';

final class SettingsViewModel extends UseAppSettingsViewModel {
  ValueNotifier<bool> hasRegisteredPasscodeNotifier = ValueNotifier(false);
  bool get hasRegisteredPasscode => hasRegisteredPasscodeNotifier.value;

  SettingsViewModel(super.settings){
    initialize();
  }

  void initialize() {
    repo.hasRegisteredPasscode().then((flag) => {
      hasRegisteredPasscodeNotifier.value = flag
    });
  }

  void switchEnablePasscode(bool isEnabled) {
    appSettings.model.isEnabledPasscode = isEnabled;
    appSettings.notifyPropertyChanged();
  }

  void switchLockOnLaunch(bool lockOnLaunched) {
    appSettings.model.lockOnLaunched = lockOnLaunched;
    appSettings.notifyPropertyChanged();
  }

  void onSuccessRegisterPasscode(bool alsoSwitchEnable) {
    hasRegisteredPasscodeNotifier.value = true;
    if (alsoSwitchEnable) {
      switchEnablePasscode(true);
    }
  }

  void saveAppSettings() async {
    await repo.updateAppSettings(appSettings.model);
  }

  switchTheme(bool isDark) {
    appSettings.model.isDark = isDark;
    appSettings.notifyPropertyChanged();
  }
}
