import 'package:micro_memo/importer.dart';

enum HomeListMenu {
  delete(name: Strings.homeListMenuDelete, icon: Icon(Icons.delete)),
  closed(name: Strings.homeListMenuClosed, icon: Icon(Icons.lock_outlined)),
  opened(name: Strings.homeListMenuOpened, icon: Icon(Icons.lock_open_outlined)),
  registerTemplate(
      name: Strings.homeListMenuRegisterTemplate,
      icon: Icon(Icons.content_copy)
  ),
  ;

  final String name;
  final Icon icon;
  const HomeListMenu({required this.name, required this.icon});
}

enum MemoActionsItems {
  delete,
  save
}

enum PasscodeRegisterStep {
  step1,
  step2,
  step3
}

enum MemoType implements Comparable<MemoType> {
  memo(value: 0),
  template(value: 1)
  ;

  final int value;
  const MemoType({required this.value});

  @override
  int compareTo(MemoType other) => value - other.value;

  static MemoType valueOf(int value) {
    return MemoType.values.firstWhere((type) => type.value == value);
  }
}