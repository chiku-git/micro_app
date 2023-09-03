import 'package:micro_memo/importer.dart';

class CreateTemplatePage extends MemoBasePage {
  static const String route = "${MemoBasePage.templateRoute}/create";

  const CreateTemplatePage({super.key, required super.ivo});

  @override
  State<StatefulWidget> createState() => _CreateTemplateState();
}

class _CreateTemplateState extends MemoBaseState {
  @override
  String getTitle() => Strings.createTemplateTitle;

  @override
  List<MemoActionsItems> getActions() => [
    MemoActionsItems.save
  ];

  @override
  Future<void> save() async {
    viewModel.createTemplate(bodyController.text);
  }
}