// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_raffle.dart';

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
    clientName: json['clientName'] as String,
    clientPhoneNumber: json['clientPhoneNumber'] as String,
    ticketValue: (json['ticketValue'] as num)?.toDouble(),
    bigLuckyaffleDate: json['bigLuckyaffleDate'] == null
        ? null
        : DateTime.parse(json['bigLuckyaffleDate'] as String),
  );
}

Map<String, dynamic> _$TicketRaffleToJson(TicketRaffle instance) =>
    <String, dynamic>{
      'createdBy': instance.createdBy,
      'companyId': instance.companyId,
      'createdDate': instance.createdDate?.toIso8601String(),
      'raffleDate': instance.raffleDate?.toIso8601String(),
      'bigLuckyaffleDate': instance.bigLuckyaffleDate?.toIso8601String(),
      'raffleNumber': instance.raffleNumber,
      'formattedRaffleNumber': instance.formattedRaffleNumber,
      'ticketValue': instance.ticketValue,
      'clientPhoneNumber': instance.clientPhoneNumber,
      'clientName': instance.clientName,
    };
