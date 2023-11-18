import 'package:micro_memo/importer.dart';

abstract class PasscodeState<T extends StatefulBaseWidget> extends BaseState<T> {
  static const String keyBackspace = "x";
  late final EditTextController passcodeController;
  String message = "";
  final keys = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    keyBackspace,
    "0",
  ];

  @override
  void initState() {
    super.initState();
    passcodeController = getEditTextController();
    passcodeController.addListener(() {
      _onPasscodeChanged(passcodeController.text);
    });
  }

  @override
  void dispose() {
    passcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (canClose()) {
          finish(context: context);
        }

        return canClose();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.of(context).themeColors.background,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          actions: _getActions(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Margin(height: 50),
              Center(child: Text(message)),
              const Margin(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                    controller: passcodeController,
                    textAlign: TextAlign.center,
                    canRequestFocus: false,
                    obscureText: true,
                    style: const TextStyle(fontSize: 40, letterSpacing: 20),
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    )),
              ),
              const Margin(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: keys.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 13,
                        crossAxisSpacing: 13),
                    itemBuilder: (context, index) {
                      final key = keys[index];
                      return MaterialButton(
                        onPressed: () => _onButtonPressed(key),
                        elevation: 0,
                        shape: const CircleBorder(),
                        color: key == keyBackspace
                              ? Colors.transparent
                              : AppColor.of(context).uiColors.passcodeButtonTint,
                        child: Center(
                          child: key == keyBackspace
                              ? const Icon(Icons.backspace_outlined)
                              : Text(key, style: const TextStyle(fontSize: 25)),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getActions() {
    List<Widget> actions = [];
    if (canClose()) {
      actions.add(
          IconButton(
              onPressed: () {
                finish(context: context);
              },
              icon: const Icon(Icons.close)
          )
      );
    }

    return actions;
  }

  void _onButtonPressed(String key) {
    switch (key) {
      case keyBackspace:
        passcodeController.dropLast();
        break;
      default:
        passcodeController.append(key);
        break;
    }
  }

  void updateMessage(String message) {
    setState(() {
      this.message = message;
    });
  }

  void _onPasscodeChanged(String passcode) {
    passcodeController.onTextChanged(passcode);
    if (passcode.length == AppConfig.passcodeLength) {
      onSubmit();
    }
  }

  void dropPasscode() {
    passcodeController.clear();
  }

  EditTextController getEditTextController();

  void onSubmit();
  bool canClose();
}
