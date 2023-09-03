import 'package:micro_memo/importer.dart';

abstract class TextValidator {
  late String value;

  TextValidator(this.value);

  bool isValid();
}

class MemoBodyValidator extends TextValidator {
  MemoBodyValidator(super.value);

  @override
  bool isValid() {
    return _isNotEmptyWithoutSpace();
  }

  bool _isNotEmptyWithoutSpace() {
    return value.replaceAll(RegExp(r'[\s\n\t]'), "").isNotEmpty;
  }
}

class PasscodeValidator extends TextValidator {
  PasscodeValidator() : super("");

  @override
  bool isValid() {
    return isValidLength();
  }

  bool isValidLength() => value.length == AppConfig.passcodeLength;
}
