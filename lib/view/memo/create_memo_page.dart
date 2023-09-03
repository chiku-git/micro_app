import 'package:micro_memo/importer.dart';

class CreateMemoPage extends MemoBasePage {
  static const String route = "${MemoBasePage.memoRoute}/create";

  const CreateMemoPage({super.key, required super.ivo});

  @override
  State<StatefulWidget> createState() => _CreateMemoState();
}

class _CreateMemoState extends MemoBaseState {
  @override
  String getTitle() => Strings.createMemoTitle;

  @override
  List<MemoActionsItems> getActions() => [
    MemoActionsItems.save
  ];

  @override
  Future<void> save() async {
    viewModel.createMemo(bodyController.text);
  }
}