class AppSettingsModel {
  bool isEnabledPasscode;
  bool lockOnLaunched;
  bool isDark;

  AppSettingsModel._(
      this.isEnabledPasscode,
      this.lockOnLaunched,
      this.isDark
  );

  AppSettingsModel.getDefault()
    : isEnabledPasscode = false,
      lockOnLaunched = false,
      isDark = false;

  AppSettingsModel.fromJsonMap(Map<String, dynamic> jsonMap)
    : isEnabledPasscode = jsonMap['isEnabledPasscode'],
      lockOnLaunched = jsonMap['lockOnLaunched'],
      isDark = jsonMap['isDark'];

  Map<String, dynamic> toJsonMap() => {
    'isEnabledPasscode': isEnabledPasscode,
    'lockOnLaunched': lockOnLaunched,
    'isDark': isDark
  };

  @override
  String toString() {
    return toJsonMap().toString();
  }
}
