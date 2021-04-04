// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoryController on _HistoryControllerBase, Store {
  final _$requestStatusAtom =
      Atom(name: '_HistoryControllerBase.requestStatus');

  @override
  RequestStatus get requestStatus {
    _$requestStatusAtom.reportRead();
    return super.requestStatus;
  }

  @override
  set requestStatus(RequestStatus value) {
    _$requestStatusAtom.reportWrite(value, super.requestStatus, () {
      super.requestStatus = value;
    });
  }

  final _$periodAtom = Atom(name: '_HistoryControllerBase.period');

  @override
  int get period {
    _$periodAtom.reportRead();
    return super.period;
  }

  @override
  set period(int value) {
    _$periodAtom.reportWrite(value, super.period, () {
      super.period = value;
    });
  }

  final _$raffleDatesAtom = Atom(name: '_HistoryControllerBase.raffleDates');

  @override
  List<DateTime> get raffleDates {
    _$raffleDatesAtom.reportRead();
    return super.raffleDates;
  }

  @override
  set raffleDates(List<DateTime> value) {
    _$raffleDatesAtom.reportWrite(value, super.raffleDates, () {
      super.raffleDates = value;
    });
  }

  final _$ticketListAtom = Atom(name: '_HistoryControllerBase.ticketList');

  @override
  ObservableList<TicketRaffle> get ticketList {
    _$ticketListAtom.reportRead();
    return super.ticketList;
  }

  @override
  set ticketList(ObservableList<TicketRaffle> value) {
    _$ticketListAtom.reportWrite(value, super.ticketList, () {
      super.ticketList = value;
    });
  }

  final _$getHistoryTicketsAsyncAction =
      AsyncAction('_HistoryControllerBase.getHistoryTickets');

  @override
  Future<void> getHistoryTickets(DateTime date) {
    return _$getHistoryTicketsAsyncAction
        .run(() => super.getHistoryTickets(date));
  }

  final _$_HistoryControllerBaseActionController =
      ActionController(name: '_HistoryControllerBase');

  @override
  void init() {
    final _$actionInfo = _$_HistoryControllerBaseActionController.startAction(
        name: '_HistoryControllerBase.init');
    try {
      return super.init();
    } finally {
      _$_HistoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearTicketList() {
    final _$actionInfo = _$_HistoryControllerBaseActionController.startAction(
        name: '_HistoryControllerBase.clearTicketList');
    try {
      return super.clearTicketList();
    } finally {
      _$_HistoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
requestStatus: ${requestStatus},
period: ${period},
raffleDates: ${raffleDates},
ticketList: ${ticketList}
    ''';
  }
}
