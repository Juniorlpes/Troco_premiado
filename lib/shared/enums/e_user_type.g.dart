// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'e_user_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EUserTypeAdapter extends TypeAdapter<EUserType> {
  @override
  final int typeId = 4;

  @override
  EUserType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EUserType.DEFAULT;
      case 1:
        return EUserType.COMPANY_OWNER;
      case 2:
        return EUserType.ADMIN;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, EUserType obj) {
    switch (obj) {
      case EUserType.DEFAULT:
        writer.writeByte(0);
        break;
      case EUserType.COMPANY_OWNER:
        writer.writeByte(1);
        break;
      case EUserType.ADMIN:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EUserTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
