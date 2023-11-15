import 'package:micro_memo/importer.dart';

class SettingsPage extends StatefulBaseWidget {
  static const String route = "/settings";

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends BaseState<SettingsPage> {
  late final SettingsViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = SettingsViewModel(appSettings);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        viewModel.saveAppSettings();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.settingsTitle),
          centerTitle: true,
          elevation: 1,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Margin(height: 20),
                PasscodeSettingWidget(
                  viewModel: viewModel,
                ),
                const Margin(height: 20),
                TemplateSettingsWidget(
                    viewModel: viewModel
                ),
                const Margin(height: 20),
                ThemeSettingWidget(
                    viewModel: viewModel
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}