import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/company.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';

abstract class IRaffleFacade {
  Future<TicketRaffle> generateRealTicket(Account mainAccount,
      Company mainCompany, String clientName, String phone, double ticketValue);
  Future<TicketRaffle> generatePendingTicket(Account mainAccount,
      Company mainCompany, String clientName, String phone, double ticketValue);
  Future<void> savePendingTicketAsReal(TicketRaffle ticket, Company company);
  Future<List<TicketRaffle>> getPendingTickets(Company company);
  Future<void> deletePendingTicket({TicketRaffle ticket, Company company});
  //Future<bool> cacheRaffle(TicketRaffle raffle);
}
