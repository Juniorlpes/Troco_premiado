import 'package:json_annotation/json_annotation.dart';

part 'ticket_raffle.g.dart';

@JsonSerializable()
class TicketRaffle {
  String createdBy;
  String companyId;
  String createdDate;
  String raffleDate;
  int raffleNumber;

  TicketRaffle();

  factory TicketRaffle.fromJson(Map<String, dynamic> json) =>
      _$TicketRaffleFromJson(json);
  Map<String, dynamic> toJson() => _$TicketRaffleToJson(this);
}
