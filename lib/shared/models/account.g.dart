// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 1;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      active: fields[0] as bool,
      company: fields[1] as String,
      email: fields[3] as String,
      id: fields[4] as String,
      idCompany: fields[2] as String,
      name: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.active)
      ..writeByte(1)
      ..write(obj.company)
      ..writeByte(2)
      ..write(obj.idCompany)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    active: json['active'] as bool,
    company: json['company'] as String,
    email: json['email'] as String,
    id: json['id'] as String,
    idCompany: json['idCompany'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'active': instance.active,
      'company': instance.company,
      'idCompany': instance.idCompany,
      'email': instance.email,
      'id': instance.id,
      'name': instance.name,
    };
