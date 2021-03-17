import 'package:flutter/foundation.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/company.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

abstract class IRaffleFacade {
  Future<TicketRaffle> generateRealTicket(Account mainAccount,
      Company mainCompany, String clientName, String phone, double ticketValue);
  Future<TicketRaffle> generatePendingTicket(Account mainAccount,
      Company mainCompany, String clientName, String phone, double ticketValue);
  Future<void> savePendingTicketAsReal(TicketRaffle ticket);
  Future<List<TicketRaffle>> getPendingTickets(Company company);
  Future<void> cacheRaffleDates({@required int month, @required int year});
  Future<void> cacheNextRaffleDates(DateTime date);
  //Future<bool> cacheRaffle(TicketRaffle raffle);
}
