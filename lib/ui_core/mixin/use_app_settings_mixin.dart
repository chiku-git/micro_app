import 'package:micro_memo/importer.dart';

mixin class UseAppSettingsMixin {
  late final AppSettings appSettings;
  AppSettingsModel get settings => appSettings.model;
  SettingsNotifier get notifier => appSettings.notifier;
  bool get isEnabledPasscode => appSettings.model.isEnabledPasscode;
  bool get lockOnLaunched => appSettings.model.lockOnLaunched;
  bool get isDark => appSettings.model.isDark;
}