import 'package:micro_memo/importer.dart';

final class RegisterPasscodeViewModel extends PasscodeViewModel {
  late PasscodeRegisterStep _currentStep;
  late String passcode;
  final StepChangeListener listener;
  final bool hasRegisteredPasscode;

  PasscodeRegisterStep get currentStep => _currentStep;

  RegisterPasscodeViewModel(this.listener, this.hasRegisteredPasscode) : super() {
    initializeStep();
  }

  void initializeStep() async {
    if (hasRegisteredPasscode) {
      _currentStep = PasscodeRegisterStep.step1;
    } else {
      _currentStep = PasscodeRegisterStep.step2;
    }
    _notifyStepChanged();
  }

  void registerPasscode(Callback callback) {
    repo.registerPasscode(Passcode(passcode)).then((isSuccessful) => {
      if (isSuccessful) {
        callback.onSuccess()
      } else {
        callback.onFailure()
      }
    });
  }

  void _notifyStepChanged() {
    listener.onStepChanged(_currentStep);
  }

  void transitionNextStep() {
    switch (_currentStep) {
      case PasscodeRegisterStep.step1:
        _currentStep = PasscodeRegisterStep.step2;
        break;
      case PasscodeRegisterStep.step2:
        _currentStep = PasscodeRegisterStep.step3;
        break;
      case PasscodeRegisterStep.step3:
        break;
    }

    _notifyStepChanged();
  }
}
