import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:troco_premiado/app/modules/home/home_controller.dart';
import 'package:troco_premiado/shared/enums/request_status.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';
part 'history_controller.g.dart';

class HistoryController = _HistoryControllerBase with _$HistoryController;

abstract class _HistoryControllerBase with Store {
  FirebaseFirestore _firestore;
  final _homeController = Modular.get<HomeController>();

  _HistoryControllerBase({FirebaseFirestore firestore}) {
    _firestore = firestore == null ? FirebaseFirestore.instance : firestore;
  }

  @observable
  RequestStatus requestStatus = RequestStatus.None;

  @observable
  int period = 0;

  @observable
  List<DateTime> raffleDates = [];

  @observable
  ObservableList<TicketRaffle> ticketList = <TicketRaffle>[].asObservable();

  @action
  void init() {
    period = _getPeriod();
    getDateList();
  }

  @action
  Future<void> getHistoryTickets(DateTime date) async {
    requestStatus = RequestStatus.Loading;

    try {
      final rawDocs = await _firestore
          .collection('raffle_tickets')
          .doc('area_${_homeController.mainCompany.luckyArea}')
          .collection('period_0$period-${date.year}')
          .doc('tickets')
          .collection('raffle_ticket-${DateFormat('dd-MM-yyyy').format(date)}')
          .where('companyId', isEqualTo: _homeController.mainCompany.id)
          .get();

      for (var i = 0; i < rawDocs.size; i++) {
        ticketList.add(TicketRaffle.fromJson(rawDocs.docs[i].data()));
      }
      requestStatus = RequestStatus.Success;
    } catch (e) {
      requestStatus = RequestStatus.Fail;
    }
  }

  @action
  void clearTicketList() {
    ticketList.clear();
  }

  int _getPeriod() {
    //TODO: improve this method (pegar do bigLuck)
    int time;
    if (DateTime.now().month < 5) {
      time = 1;
    } else if (DateTime.now().month < 9) {
      time = 2;
    } else {
      time = 3;
    }
    return time;
  }

  void getDateList() {
    int firstMonth;
    switch (period) {
      case 1:
        firstMonth = DateTime.january;
        break;
      case 2:
        firstMonth = DateTime.may;
        break;
      case 3:
        firstMonth = DateTime.september;
        break;
      default:
        break;
    }
    var count = 0;
    while (count < 4) {
      int wednesdayCount = 0;
      bool hasSecondWen = false;
      bool hasFourthWen = false;

      for (int day = 1; day < 32; day++) {
        var date = DateTime(DateTime.now().year, firstMonth, day);
        //Verifica se é uma quarta
        if (date.weekday == DateTime.wednesday) {
          wednesdayCount++;
        }
        //Verifica se é quarta de sorteio
        if (wednesdayCount == 2 && !hasSecondWen) {
          raffleDates.add(date);
          hasSecondWen = true;
        } else if (wednesdayCount == 4 && !hasFourthWen) {
          raffleDates.add(date);
          hasFourthWen = true;
        }
      }

      firstMonth++;
      count++;
    }
  }

  String getMounthName(int count) {
    if (count == 0) {
      if (period == 1) {
        return 'Janeiro';
      } else if (period == 2) {
        return 'Maio';
      } else {
        return 'Setembro';
      }
    } else if (count == 1) {
      if (period == 1) {
        return 'Fevereiro';
      } else if (period == 2) {
        return 'Junho';
      } else {
        return 'Outubro';
      }
    } else if (count == 2) {
      if (period == 1) {
        return 'Março';
      } else if (period == 2) {
        return 'Julho';
      } else {
        return 'Novembro';
      }
    } else {
      if (period == 1) {
        return 'Abril';
      } else if (period == 2) {
        return 'Agosto';
      } else {
        return 'Dezembro';
      }
    }
  }
}
