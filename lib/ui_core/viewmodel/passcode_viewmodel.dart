import 'package:micro_memo/importer.dart';

base class PasscodeViewModel extends ViewModel {
  void verifyPasscode(String passcode, Callback callback) {
    repo.verifyPassword(Passcode(passcode)).then((isValid) => {
      if (isValid) {
        callback.onSuccess()
      } else {
        callback.onFailure()
      }
    });
  }
}
