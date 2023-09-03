import 'package:micro_memo/importer.dart';
import 'package:realm/realm.dart';

part 'memo.g.dart';

// クラスを編集したらdart run realm generateを実行する

@RealmModel()
class _Memo {
  @PrimaryKey()
  late ObjectId id;
  String body = "";
  bool isPrivate = false;
  @MapTo('type')
  int typeValue = 0;
  late DateTime createdAt;
  late DateTime? updatedAt;

  String get firstLine => body.split("\n")[0];

  MemoType get type => MemoType.valueOf(typeValue);

  Memo update({String? body, bool? isPrivate, MemoType? type}) {
    return copyWith(
        id: id,
        body: body,
        isPrivate: isPrivate,
        type: type,
        updatedAt: DateTime.now()
    );
  }

  Memo copyWith({ObjectId? id, String? body, bool? isPrivate, MemoType? type,
                 DateTime? updatedAt}) {
    return Memo(
        id ?? ObjectId(),
        createdAt,
        body: body ?? this.body,
        isPrivate: isPrivate ?? this.isPrivate,
        typeValue: type?.value ?? typeValue,
        updatedAt: updatedAt ?? this.updatedAt
    );
  }

  @override
  String toString() {
    return "id: $id, "
        "body: $body, "
        "isPrivate: $isPrivate, "
        "type: ${type.name}, "
        "createdAt: $createdAt, "
        "updatedAt: $updatedAt"
    ;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Memo) return false;

    return id == (other as Memo).id;
  }
}