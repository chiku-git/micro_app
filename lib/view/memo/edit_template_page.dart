import 'package:micro_memo/importer.dart';

class EditTemplatePage extends MemoBasePage {
  static const String route = "${MemoBasePage.templateRoute}/edit";

  const EditTemplatePage({super.key, required super.ivo});

  @override
  State<StatefulWidget> createState() => _EditTemplateState();
}

class _EditTemplateState extends MemoBaseState {
  @override
  String getTitle() => viewModel.title;

  @override
  List<MemoActionsItems> getActions() => [
    MemoActionsItems.delete,
    MemoActionsItems.save
  ];

  @override
  Future<void> save() async {
    viewModel.update(body: bodyController.text);
  }
}