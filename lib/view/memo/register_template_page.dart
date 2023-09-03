import 'package:micro_memo/importer.dart';

class RegisterTemplatePage extends MemoBasePage {
  static const String route = "${MemoBasePage.templateRoute}/register";

  const RegisterTemplatePage({super.key, required super.ivo});

  @override
  State<StatefulWidget> createState() => _RegisterTemplateState();
}

class _RegisterTemplateState extends MemoBaseState {
  @override
  String getTitle() => Strings.registerTemplateTitle;

  @override
  List<MemoActionsItems> getActions() => [
    MemoActionsItems.save
  ];

  @override
  Future<void> save() async {
    viewModel.update(body: bodyController.text, type: MemoType.template);
  }
}