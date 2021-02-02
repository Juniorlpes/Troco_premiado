import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:troco_premiado/shared/cache/cache_adapters_id.dart';

part 'ticket_raffle.g.dart';

@JsonSerializable()
@HiveType(typeId: CacheAdaptersId.RaffleAdapter)
class TicketRaffle {
  @HiveField(0)
  String createdBy;
  @HiveField(1)
  String companyId;
  @HiveField(2)
  DateTime createdDate;
  @HiveField(3)
  DateTime raffleDate;
  @HiveField(4)
  int raffleNumber;
  @HiveField(5)
  String formattedRaffleNumber;
  @HiveField(6)
  double ticketValue;
  @HiveField(7)
  String clientPhoneNumber;
  @HiveField(8)
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
      this.ticketValue});

  factory TicketRaffle.fromJson(Map<String, dynamic> json) =>
      _$TicketRaffleFromJson(json);
  Map<String, dynamic> toJson() => _$TicketRaffleToJson(this);
}
