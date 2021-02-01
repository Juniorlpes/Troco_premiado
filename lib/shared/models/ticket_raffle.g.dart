// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_raffle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketRaffleAdapter extends TypeAdapter<TicketRaffle> {
  @override
  final int typeId = 2;

  @override
  TicketRaffle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketRaffle(
      companyId: fields[1] as String,
      createdBy: fields[0] as String,
      createdDate: fields[2] as DateTime,
      raffleDate: fields[3] as DateTime,
      raffleNumber: fields[4] as int,
      formattedRaffleNumber: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TicketRaffle obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.createdBy)
      ..writeByte(1)
      ..write(obj.companyId)
      ..writeByte(2)
      ..write(obj.createdDate)
      ..writeByte(3)
      ..write(obj.raffleDate)
      ..writeByte(4)
      ..write(obj.raffleNumber)
      ..writeByte(5)
      ..write(obj.formattedRaffleNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketRaffleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketRaffle _$TicketRaffleFromJson(Map<String, dynamic> json) {
  return TicketRaffle(
    companyId: json['companyId'] as String,
    createdBy: json['createdBy'] as String,
    createdDate: json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
    raffleDate: json['raffleDate'] == null
        ? null
        : DateTime.parse(json['raffleDate'] as String),
    raffleNumber: json['raffleNumber'] as int,
    formattedRaffleNumber: json['formattedRaffleNumber'] as String,
  );
}

Map<String, dynamic> _$TicketRaffleToJson(TicketRaffle instance) =>
    <String, dynamic>{
      'createdBy': instance.createdBy,
      'companyId': instance.companyId,
      'createdDate': instance.createdDate?.toIso8601String(),
      'raffleDate': instance.raffleDate?.toIso8601String(),
      'raffleNumber': instance.raffleNumber,
      'formattedRaffleNumber': instance.formattedRaffleNumber,
    };
