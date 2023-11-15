import 'package:micro_memo/importer.dart';

sealed class SharedData<V> {
  final BuildContext context;

  SharedData(this.context);

  V getSharedData(String key, Function init) {
    return SharedAppData.getValue(context, key, () => init());
  }

  setSharedData(String key, V value) {
    SharedAppData.setValue(context, key, value);
  }
}

class AppSettings extends SharedData<ValueNotifier> {
  AppSettings(super.context);

  static String keySettings = 'settings';

  SettingsNotifier get notifier {
    SettingsNotifier getDefault() => SettingsNotifier(AppSettingsModel.getDefault());
    return getSharedData(keySettings, getDefault) as SettingsNotifier;
  }

  set notifier(SettingsNotifier notifier) {
    setSharedData(keySettings, notifier);
  }

  AppSettingsModel get model => notifier.value;

  notifyPropertyChanged() {
    notifier.update(model);
  }
}