import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:troco_premiado/shared/cache/cache_box_enum.dart';
import 'package:troco_premiado/shared/cache/cache_controller.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/company.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_raffle_facade.dart';

class RaffleRepository implements IRaffleFacade {
  FirebaseFirestore _firestore;
  final cacheDateRaffles =
      CacheController<DateTime>(cacheBoxEnum: CacheBox.DateRaffles);

  RaffleRepository({FirebaseFirestore firestore}) {
    _firestore = firestore == null ? FirebaseFirestore.instance : firestore;
  }

  @override
  Future<void> cacheRaffleDates({int month, int year}) async {
    //Toda segunda e quarta quarta-feira do mês tem sorteio. numeros de 0 a 99.999

    int wednesdayCount = 0;
    DateTime secondWendnesday;
    DateTime fourthWendnesday;
    bool hasSecondWen = false;
    bool hasFourthWen = false;

    //for pelas datas do mês
    try {
      for (int day = 1; day < 32; day++) {
        var date = DateTime(year, month, day, 18);
        //Verifica se é uma quarta
        if (date.weekday == DateTime.wednesday) {
          wednesdayCount++;
        }
        //Verifica se é quarta de sorteio
        if (wednesdayCount == 2 && !hasSecondWen) {
          secondWendnesday = date;
          hasSecondWen = true;
        } else if (wednesdayCount == 4 && !hasFourthWen) {
          fourthWendnesday = date;
          hasFourthWen = true;
        }
      }
      await cacheBigLuckyWendnesday(month: month, year: year);
    } catch (e) {
      print('ERROR!!');
      print(e);
    }
    await cacheDateRaffles.writeByKey(1, secondWendnesday);
    await cacheDateRaffles.writeByKey(2, fourthWendnesday);
  }

  Future<void> cacheBigLuckyWendnesday({int month, int year}) async {
    DateTime luckyWendnesday;
    int luckyMonth;
    int wednesdayCount = 0;

    if (month < 5) {
      luckyMonth = 4;
    } else if (month < 9) {
      luckyMonth = 8;
    } else {
      luckyMonth = 12;
    }
    for (int day = 1; day < 32; day++) {
      var date = DateTime(year, luckyMonth, day, 18);
      //Verifica se é uma quarta
      if (date.weekday == DateTime.wednesday) {
        wednesdayCount++;
      }
      if (wednesdayCount == 4) {
        luckyWendnesday = date;
        break;
      }
    }
    await cacheDateRaffles.writeByKey(3, luckyWendnesday);
  }

  @override
  Future<void> cacheNextRaffleDates(DateTime date) async {
    if (date.month == 12) {
      await cacheRaffleDates(
        month: 1,
        year: date.year + 1,
      );
    } else {
      await cacheRaffleDates(
        month: date.month + 1,
        year: date.year,
      );
    }
  }

  @override
  Future<TicketRaffle> generateRealTicket(
      Account mainAccount,
      Company mainCompany,
      String clientName,
      String phone,
      double ticketValue) async {
    //TODO: Review this method

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
      raffleDate = await _getNextRaffleDate();
      bigLuckyaffleDate = await cacheDateRaffles.getByKey(3);
      // *********

      final CollectionReference raffleCollectionFirestore = _firestore
          .collection('raffle_tickets')
          .doc('area_${mainCompany.luckyArea}')
          .collection(
              'raffle_tickets-${DateFormat('dd-MM-yyyy').format(raffleDate)}');

      final CollectionReference bigLuckyRaffleCollectionFirestore = _firestore
          .collection('raffle_tickets')
          .doc('area_${mainCompany.luckyArea}')
          .collection(
              'raffle_tickets-${DateFormat('dd-MM-yyyy').format(bigLuckyaffleDate)}');

      //raffle
      raffleNumber = await _getTheRaffleNumber(raffleCollectionFirestore);
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

  Future<DateTime> _getNextRaffleDate() async {
    if (DateTime.now().isBefore(await cacheDateRaffles.getByKey(1))) {
      return await cacheDateRaffles.getByKey(1);
    } else if (DateTime.now().isBefore(await cacheDateRaffles.getByKey(2))) {
      return await cacheDateRaffles.getByKey(2);
    } else {
      await cacheNextRaffleDates(DateTime.now());
      return await cacheDateRaffles.getByKey(1);
    }
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
