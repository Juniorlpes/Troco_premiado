// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyAdapter extends TypeAdapter<Company> {
  @override
  final int typeId = 3;

  @override
  Company read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Company(
      address: fields[0] as String,
      id: fields[1] as int,
      latitude: fields[2] as double,
      longitude: fields[3] as double,
      name: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Company obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    address: json['address'] as String,
    id: json['id'] as int,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
    };
