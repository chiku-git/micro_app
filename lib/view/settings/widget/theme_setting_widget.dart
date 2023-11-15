import 'package:micro_memo/importer.dart';

class ThemeSettingWidget extends StatefulBaseWidget {
  final SettingsViewModel viewModel;

  const ThemeSettingWidget({super.key, required this.viewModel});

  @override
  State<StatefulWidget> createState() => _ThemeSettingState();
}

class _ThemeSettingState extends BaseState<ThemeSettingWidget> {
  late final SettingsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingTitle(
            title: "テーマ"
        ),
        SettingRow(
            isTop: true,
            isBottom: true,
            leading: const Text("ダークテーマを使用する"),
            trailing: ListenableBuilder(
                listenable: _viewModel.appSettings.notifier,
                builder: (context, child) {
                  return Switch(
                      value: _viewModel.isDark,
                      onChanged: (isDark) {
                        _viewModel.switchTheme(isDark);
                      }
                  );
                }
            )
        )
      ],
    );
  }
}