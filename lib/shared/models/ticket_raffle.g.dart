// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_raffle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketRaffle _$TicketRaffleFromJson(Map<String, dynamic> json) {
  return TicketRaffle(
    companyId: json['companyId'] as String,
    createdBy: json['createdBy'] as String,
    createdDate: json['createdDate'] as String,
    raffleDate: json['raffleDate'] as String,
    raffleNumber: json['raffleNumber'] as int,
  );
}

Map<String, dynamic> _$TicketRaffleToJson(TicketRaffle instance) =>
    <String, dynamic>{
      'createdBy': instance.createdBy,
      'companyId': instance.companyId,
      'createdDate': instance.createdDate,
      'raffleDate': instance.raffleDate,
      'raffleNumber': instance.raffleNumber,
    };
