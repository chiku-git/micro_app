import 'package:micro_memo/importer.dart';
class IVO {}

class MemoPageIVO extends IVO {
  final Memo? memo;

  MemoPageIVO({this.memo});
}

class LockPageIVO extends IVO {
  final bool closeable;

  LockPageIVO(this.closeable);
}

class PasscodeRegisterPageIVO extends IVO {
  final bool hasRegisteredPasscode;

  PasscodeRegisterPageIVO(this.hasRegisteredPasscode);
}
