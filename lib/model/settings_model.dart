class AppSettingsModel {
  bool isEnabledPasscode;
  bool lockOnLaunched;

  AppSettingsModel._(this.isEnabledPasscode, this.lockOnLaunched);

  AppSettingsModel.getDefault()
    : isEnabledPasscode = false,
      lockOnLaunched = false;

  AppSettingsModel.fromJsonMap(Map<String, dynamic> jsonMap)
    : isEnabledPasscode = jsonMap['isEnabledPasscode'],
      lockOnLaunched = jsonMap['lockOnLaunched'];

  Map<String, dynamic> toJsonMap() => {
    'isEnabledPasscode': isEnabledPasscode,
    'lockOnLaunched': lockOnLaunched
  };

  @override
  String toString() {
    return toJsonMap().toString();
  }
}
