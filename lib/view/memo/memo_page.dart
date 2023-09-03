import 'package:micro_memo/importer.dart';

class MemoPage extends MemoBasePage {
  static const String route = MemoBasePage.memoRoute;

  const MemoPage({super.key, required super.ivo});

  @override
  State<StatefulWidget> createState() => _MemoState();
}

class _MemoState extends MemoBaseState {
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