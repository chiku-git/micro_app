import 'package:micro_memo/importer.dart';
import 'package:realm/realm.dart';

final class MemoViewModel extends ViewModel {
  final MemoPageIVO ivo;
  late final Memo? memo;

  MemoViewModel(this.ivo) : super() {
    memo = ivo.memo;
  }

  bool get isNew => isNull(memo);

  String get body => isNew ? "" : memo!.body;

  String get title {
    final firstLine = memo!.firstLine;
    final length = min(firstLine.length, 5);
    var res = firstLine.substring(0, length);
    if (res.length >= 5) {
      res += Strings.ellipsis;
    }

    return res;
  }

  void createMemo(String body) {
    _create(body, MemoType.memo);
  }

  void createTemplate(String body) {
    _create(body, MemoType.template);
  }

  void _create(String body, MemoType type) {
    final newMemo = Memo(
        ObjectId(), DateTime.now(), body: body, typeValue: type.value
    );
    repo.upsertMemo(newMemo);
  }

  void update({required String body, MemoType? type}) {
    Memo newMemo;
    if (isNull(type)) {
      newMemo = memo!.update(body: body);
    } else {
      newMemo = memo!.copyWith(body: body, type: type);
    }
    repo.upsertMemo(newMemo);
  }

  void delete() {
    if (!isNew) {
      repo.deleteMemo(memo!);
    }
  }
}
