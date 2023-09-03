// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Memo extends _Memo with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Memo(
    ObjectId id,
    DateTime createdAt, {
    String body = "",
    bool isPrivate = false,
    int typeValue = 0,
    DateTime? updatedAt,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Memo>({
        'body': "",
        'isPrivate': false,
        'type': 0,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'body', body);
    RealmObjectBase.set(this, 'isPrivate', isPrivate);
    RealmObjectBase.set(this, 'type', typeValue);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'updatedAt', updatedAt);
  }

  Memo._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get body => RealmObjectBase.get<String>(this, 'body') as String;
  @override
  set body(String value) => RealmObjectBase.set(this, 'body', value);

  @override
  bool get isPrivate => RealmObjectBase.get<bool>(this, 'isPrivate') as bool;
  @override
  set isPrivate(bool value) => RealmObjectBase.set(this, 'isPrivate', value);

  @override
  int get typeValue => RealmObjectBase.get<int>(this, 'type') as int;
  @override
  set typeValue(int value) => RealmObjectBase.set(this, 'type', value);

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  DateTime? get updatedAt =>
      RealmObjectBase.get<DateTime>(this, 'updatedAt') as DateTime?;
  @override
  set updatedAt(DateTime? value) =>
      RealmObjectBase.set(this, 'updatedAt', value);

  @override
  Stream<RealmObjectChanges<Memo>> get changes =>
      RealmObjectBase.getChanges<Memo>(this);

  @override
  Memo freeze() => RealmObjectBase.freezeObject<Memo>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Memo._);
    return const SchemaObject(ObjectType.realmObject, Memo, 'Memo', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('body', RealmPropertyType.string),
      SchemaProperty('isPrivate', RealmPropertyType.bool),
      SchemaProperty('typeValue', RealmPropertyType.int, mapTo: 'type'),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
      SchemaProperty('updatedAt', RealmPropertyType.timestamp, optional: true),
    ]);
  }
}
