import 'package:micro_memo/importer.dart';

abstract class MemoBaseState extends BaseState<MemoBasePage> {
  late final MemoViewModel viewModel;
  late final EditTextController bodyController;
  late final UndoHistoryController undoController;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    viewModel = MemoViewModel(widget.ivo);
    bodyController = EditTextController(
        text: viewModel.body,
        validator: MemoBodyValidator(viewModel.body)
    );
    bodyController.addListener(() {
      bodyController.onTextChanged(bodyController.text);
    });
    undoController = UndoHistoryController();
  }

  @override
  void dispose() {
    bodyController.dispose();
    undoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(95),
        child: AppBar(
          title: Text(
            getTitle(),
            overflow: TextOverflow.ellipsis,
          ),
          actions: _getActions(),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: _onClickClose,
              icon: const Icon(Icons.close)
          ),
          leadingWidth: 70,
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onLongPress: _onLongPressedUndo,
                    child: IconButton(
                      onPressed: _onClickUndo,
                      icon: const Icon(Icons.undo),
                    ),
                  ),
                  const Margin(width: 5),
                  OutlinedButton(
                      onPressed: _onClickTemplate,
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          minimumSize: const Size(0, 30),
                          padding: const EdgeInsets.symmetric(horizontal: 10)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(6, 2, 0, 0),
                        child: Text(Strings.template),
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: bodyController,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: Strings.writeMemo),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: viewModel.isNew,
            undoController: undoController,
          ),
        ),
      ),
    );
  }

  List<Widget> _getActions() {
    List<Widget> actions = [];

    getActions().forEach((item) {
      switch(item) {
        case MemoActionsItems.delete:
          actions.add(
              IconButton(
                  onPressed: _onClickDelete,
                  icon: const Icon(Icons.delete)
              )
          );
          break;
        case MemoActionsItems.save:
          actions.add(
              TextButton(
                onPressed: () {
                  _onClickSave();
                  finish(context: context);
                },
                child: const Text(
                  Strings.save,
                  style: TextStyle(
                      fontSize: 14.0
                  ),),
              )
          );
          break;
      }
    });

    return actions;
  }

  _onClickSave() async {
    primaryFocus?.unfocus();
    if (bodyController.isValid()) {
      await save();
    }
  }

  _onClickUndo() {
    undoController.undo();
  }

  _onLongPressedUndo() {
    bodyController.reset();
    bodyController.selectEnd();
  }

  _onClickDelete() {
    primaryFocus?.unfocus();
    showConfirmDialog(
        context: context,
        title: Strings.deleteMemoTitle,
        body: Strings.deleteMemoBody,
        onPositiveAction: () {
          viewModel.delete();
          finish(context: context);
        });
  }

  _onClickClose() {
    finish(context: context);
  }

  _onClickTemplate() async {
    final result = await showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: getScreenHeight(context) * 0.9,
            child: TemplateSelectionPage(),
          );
        });

    if (result != null && result.runtimeType == Memo) {
      _selectOverwriteMethod((result as Memo));
    }
  }

  _selectOverwriteMethod(Memo template) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        builder: (context) {
          return ChoicesWidget(
              height: 200,
              width: getScreenWidth(context) * 0.9,
              spacing: 10,
              buttonAttrs: [
                ChoicesButtonAttr(
                    text: Strings.overwrite,
                    onClicked: () {
                      setState(() {
                        bodyController.text = template.body;
                      });
                    }
                ),
                ChoicesButtonAttr(
                    text: Strings.addToEnd,
                    onClicked: () {
                      setState(() {
                        bodyController.text += template.body;
                      });
                    }
                ),
                ChoicesButtonAttr(
                    text: Strings.cancel,
                    textColor: AppColor.of(context).themeColors.error
                )
              ]
          );
        }
    );
  }
  
  String getTitle();
  List<MemoActionsItems> getActions();
  Future<void> save();
}