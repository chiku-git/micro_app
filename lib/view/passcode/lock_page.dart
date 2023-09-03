import 'package:micro_memo/importer.dart';

class LockPage extends StatefulBaseWidget {
  static const route = "/passcode/lock";
  static void tryUnlock(
      BuildContext context,
      {required Function onUnlocked, bool closeable = true}) {
    Future(() {
      _tryUnlock(context, closeable).then((isUnlocked) => {
        if (isOK(isUnlocked)) {
          onUnlocked.call()
        }
      });
    });
  }

  static Future<dynamic> _tryUnlock(BuildContext context, bool closeable) {
    return Navigator.push(context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return LockPage(ivo: LockPageIVO(closeable));
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return const FadeUpwardsPageTransitionsBuilder()
              .buildTransitions(
                MaterialPageRoute(builder: (context) {
                  return LockPage(ivo: LockPageIVO(closeable));
                }),
                context,
                animation,
                secondaryAnimation,
                child
          );
        })
    );
  }

  final LockPageIVO ivo;

  const LockPage({super.key, required this.ivo});

  @override
  State<StatefulWidget> createState() => _LockState();
}

class _LockState extends PasscodeState<LockPage> {
  late final PasscodeViewModel _viewModel;
  late final LockPageIVO _ivo;

  @override
  void initState() {
    super.initState();
    _ivo = widget.ivo;
    _viewModel = PasscodeViewModel();
    updateMessage(Strings.inputPasscode);
  }

  @override
  EditTextController getEditTextController() {
    return EditTextController(text: "");
  }

  @override
  void onSubmit() {
    _verify(passcodeController.text);
  }

  void _verify(String passcode) {
    _viewModel.verifyPasscode(passcode, Callback(
        onSuccess: () {
          finishWithResult(context: context, result: true);
        },
        onFailure: () {
          dropPasscode();
          updateMessage(Strings.invalidPasscode);
        })
    );
  }

  @override
  bool canClose() => _ivo.closeable;
}
