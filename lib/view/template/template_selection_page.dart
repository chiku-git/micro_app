import 'package:micro_memo/importer.dart';

class TemplateSelectionPage extends TemplateListBasePage {
  static const String route = "${TemplateListBasePage.route}/select";
  TemplateSelectionPage({super.key});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close)
      )
    ];
  }

  @override
  bool canBack() => false;

  @override
  Widget? getTrailing(BuildContext context, Memo template) => null;

  @override
  onTapRow(BuildContext context, Memo template) {
    Navigator.pop(context, template);
  }
}