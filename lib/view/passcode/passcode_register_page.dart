import 'package:micro_memo/importer.dart';

abstract class StepChangeListener {
  void onStepChanged(PasscodeRegisterStep step);
}

class PasscodeRegisterPage extends StatefulBaseWidget {
  static const route = "/passcode/register";
  final PasscodeRegisterPageIVO ivo;

  const PasscodeRegisterPage({super.key, required this.ivo});

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends PasscodeState<PasscodeRegisterPage>
    implements StepChangeListener {
  late final RegisterPasscodeViewModel _viewModel;
  late final PasscodeRegisterPageIVO _ivo;

  @override
  void initState() {
    super.initState();
    _ivo = widget.ivo;
    _viewModel = RegisterPasscodeViewModel(this, _ivo.hasRegisteredPasscode);
  }

  @override
  EditTextController getEditTextController() {
    return EditTextController(text: "", validator: PasscodeValidator());
  }

  @override
  void onSubmit() {
    switch (_viewModel.currentStep) {
      case PasscodeRegisterStep.step1:
        _verifyCurrentPasscode();
        break;
      case PasscodeRegisterStep.step2:
        _validatePasscode();
        break;
      case PasscodeRegisterStep.step3:
        _confirmPasscode();
        break;
    }
  }

  void _verifyCurrentPasscode() {
    final passcode = passcodeController.text;
    _viewModel.verifyPasscode(passcode, Callback(
        onSuccess: () {
          _viewModel.transitionNextStep();
        },
        onFailure: () {
          dropPasscode();
          updateMessage(Strings.invalidPasscode);
        })
    );
  }

  void _validatePasscode() {
    if (passcodeController.isValid()) {
      _viewModel.passcode = passcodeController.text;
      _viewModel.transitionNextStep();
    } else {
      dropPasscode();
      updateMessage(Strings.invalidLengthPasscode);
    }
  }

  void _confirmPasscode() {
    if (passcodeController.isValid()) {
      if (_viewModel.passcode == passcodeController.text) {
        _viewModel.registerPasscode(Callback(
            onSuccess: () {
              finishWithResult(context: context, result: true);
            },
            onFailure: () {
              // TODO error
            }));
      } else {
        dropPasscode();
        updateMessage(Strings.noMatchPasscode);
      }
    } else {
      dropPasscode();
      updateMessage(Strings.invalidLengthPasscode);
    }
  }

  @override
  void onStepChanged(PasscodeRegisterStep step) {
    switch(step) {
      case PasscodeRegisterStep.step1:
        passcodeController.clear();
        updateMessage(Strings.inputCurrentPasscode);
        break;
      case PasscodeRegisterStep.step2:
        passcodeController.clear();
        updateMessage(Strings.inputNewPasscode);
        break;
      case PasscodeRegisterStep.step3:
        passcodeController.clear();
        updateMessage(Strings.confirmPasscode);
        break;
      default:
        break;
    }
  }

  @override
  bool canClose() => true;
}
