import 'package:json_annotation/json_annotation.dart';

part 'ticket_raffle.g.dart';

@JsonSerializable()
class TicketRaffle {
  String createdBy;
  String companyId;
  DateTime createdDate;
  DateTime raffleDate;
  DateTime bigLuckyaffleDate;
  int raffleNumber;
  String formattedRaffleNumber;
  double ticketValue;
  String clientPhoneNumber;
  String clientName;

  TicketRaffle(
      {this.companyId,
      this.createdBy,
      this.createdDate,
      this.raffleDate,
      this.raffleNumber,
      this.formattedRaffleNumber,
      this.clientName,
      this.clientPhoneNumber,
      this.ticketValue,
      this.bigLuckyaffleDate});

  factory TicketRaffle.fromJson(Map<String, dynamic> json) =>
      _$TicketRaffleFromJson(json);
  Map<String, dynamic> toJson() => _$TicketRaffleToJson(this);

  @override
  bool operator ==(other) =>
      other is TicketRaffle &&
      other.clientName == this.clientName &&
      other.ticketValue == this.ticketValue &&
      other.clientPhoneNumber == this.clientPhoneNumber &&
      other.raffleDate == this.raffleDate &&
      other.raffleNumber == this.raffleNumber;

  @override
  int get hashCode => super.hashCode;
}
