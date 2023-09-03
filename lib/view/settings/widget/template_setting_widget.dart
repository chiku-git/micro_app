import 'package:micro_memo/importer.dart';

class TemplateSettingsWidget extends StatelessBaseWidget {
  final SettingsViewModel viewModel;

  TemplateSettingsWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, bottom: 5),
          child: Text(Strings.template),
        ),
        SettingRow(
            isTop: true,
            leading: const Text(Strings.createTemplate),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.pushNamed(
                  context, CreateTemplatePage.route, arguments: MemoPageIVO()
              );
            }
        ),
        SettingRow(
            isBottom: true,
            leading: const Text(Strings.editTemplate),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              Navigator.pushNamed(context, TemplateListPage.route);
            }
        ),
      ],
    );
  }

  @override
  initialize(BuildContext context) {
    // NOP
  }
}