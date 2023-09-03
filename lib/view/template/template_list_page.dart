import 'package:micro_memo/importer.dart';

class TemplateListPage extends TemplateListBasePage {
  static const String route = TemplateListBasePage.route;
  TemplateListPage({super.key});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  bool canBack() => true;

  @override
  Widget? getTrailing(BuildContext context, Memo template) {
    return IconButton(
        onPressed: () {
          showConfirmDialog(
              context: context,
              title: Strings.confirmDeleteTemplateTitle,
              body: Strings.confirmDeleteTemplateBody,
              onPositiveAction: () {
                viewModel.delete(template);
              });
        },
        icon: const Icon(Icons.delete)
    );
  }

  @override
  onTapRow(BuildContext context, Memo template) {
    final ivo = MemoPageIVO(memo: template);
    Navigator.pushNamed(context, EditTemplatePage.route, arguments: ivo);
  }
}