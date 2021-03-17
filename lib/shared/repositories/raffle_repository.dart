import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/company.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_raffle_dates_facade.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_raffle_facade.dart';
import 'package:troco_premiado/shared/repositories/raffle_date_repository.dart';

class RaffleRepository implements IRaffleFacade {
  FirebaseFirestore _firestore;
  IRaffleDateFacade datesRepository = RaffleDatesRepository();

  RaffleRepository({FirebaseFirestore firestore}) {
    _firestore = firestore == null ? FirebaseFirestore.instance : firestore;
  }

  @override
  Future<TicketRaffle> generateRealTicket(
      Account mainAccount,
      Company mainCompany,
      String clientName,
      String phone,
      double ticketValue) async {
    try {
      //Ticket Raffle Fields
      int raffleNumber;
      DateTime raffleDate;
      DateTime bigLuckyaffleDate;

      final String createdBy = mainAccount?.id;
      final String companyId = mainAccount?.companyId;
      final DateTime createdDate =
          DateTime.now(); //DateFormat('dd-MM-yyyy').format(DateTime.now());
      if (companyId == null) {
        return null;
      }
      // ********

      //Next RaffleDate
      raffleDate = await datesRepository.getNextRaffleDate();
      bigLuckyaffleDate = await datesRepository.getBigLuckyRaffleDate();
      var periodString = _getPeriodString(bigLuckyaffleDate);
      // *********

      final CollectionReference raffleCollectionFirestore = _firestore
          .collection('raffle_tickets')
          .doc('area_${mainCompany.luckyArea}')
          .collection(periodString)
          .doc('tickets')
          .collection(
              'raffle_ticket-${DateFormat('dd-MM-yyyy').format(raffleDate)}');

      final CollectionReference bigLuckyRaffleCollectionFirestore = _firestore
          .collection('raffle_tickets')
          .doc('area_${mainCompany.luckyArea}')
          .collection(periodString)
          .doc('tickets')
          .collection(
              'raffle_ticket-${DateFormat('dd-MM-yyyy').format(bigLuckyaffleDate)}');

      //raffle
      raffleNumber =
          await _getTheRaffleNumber(bigLuckyRaffleCollectionFirestore);
      // ****

      final completedTicketRaffle = TicketRaffle(
        companyId: companyId,
        createdBy: createdBy,
        createdDate: createdDate,
        raffleDate: raffleDate,
        raffleNumber: raffleNumber,
        formattedRaffleNumber:
            NumberFormat('000000').format(raffleNumber).replaceAll('', ' '),
        clientPhoneNumber: phone,
        clientName: clientName,
        ticketValue: ticketValue,
      );

      await raffleCollectionFirestore.add(completedTicketRaffle.toJson());
      await bigLuckyRaffleCollectionFirestore
          .add(completedTicketRaffle.toJson());

      return completedTicketRaffle;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<TicketRaffle> generatePendingTicket(
      Account mainAccount,
      Company mainCompany,
      String clientName,
      String phone,
      double ticketValue) {
    // TODO: implement generatePendingTicket
    throw UnimplementedError();
  }

  @override
  Future<List<TicketRaffle>> getPendingTickets(Company company) async {
    List<TicketRaffle> pendingTickets = [];
    var rawPendingList = await _firestore
        .collection('companies')
        .doc(company.id)
        .collection('pending_tickets')
        .get();

    for (int i = 0; i < rawPendingList.docs.length; i++) {
      if (rawPendingList.docs[i].exists) {
        pendingTickets
            .add(TicketRaffle.fromJson(rawPendingList.docs[i].data()));
      }
    }
    return pendingTickets;
  }

  @override
  Future<void> savePendingTicketAsReal(TicketRaffle ticket) {
    // TODO: implement savePendingTicketAsReal
    throw UnimplementedError();
  }

  String _getPeriodString(DateTime date) {
    int time;
    int year = date.year;
    if (date.month < 5) {
      time = 1;
    } else if (date.month < 9) {
      time = 2;
    } else {
      time = 3;
    }
    return 'period_${NumberFormat('00').format(time)}-$year';
  }

  Future<int> _getTheRaffleNumber(
      CollectionReference raffleFirebaseCollection) async {
    var random = Random();
    int raffleNumber;
    bool containsThisRaffleNumber = false;
    do {
      raffleNumber = random.nextInt(99999);

      var dbRaffles = await raffleFirebaseCollection
          .where('raffleNumber', isEqualTo: raffleNumber)
          .get();

      if (dbRaffles.docs.isEmpty) {
        containsThisRaffleNumber = false;
      } else {
        containsThisRaffleNumber = true;
      }
    } while (containsThisRaffleNumber);
    return raffleNumber;
  }
}
