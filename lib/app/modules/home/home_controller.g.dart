// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$pendingRequestStatusAtom =
      Atom(name: '_HomeControllerBase.pendingRequestStatus');

  @override
  RequestStatus get pendingRequestStatus {
    _$pendingRequestStatusAtom.reportRead();
    return super.pendingRequestStatus;
  }

  @override
  set pendingRequestStatus(RequestStatus value) {
    _$pendingRequestStatusAtom.reportWrite(value, super.pendingRequestStatus,
        () {
      super.pendingRequestStatus = value;
    });
  }

  final _$pendingTicketListAtom =
      Atom(name: '_HomeControllerBase.pendingTicketList');

  @override
  ObservableList<TicketRaffle> get pendingTicketList {
    _$pendingTicketListAtom.reportRead();
    return super.pendingTicketList;
  }

  @override
  set pendingTicketList(ObservableList<TicketRaffle> value) {
    _$pendingTicketListAtom.reportWrite(value, super.pendingTicketList, () {
      super.pendingTicketList = value;
    });
  }

  final _$mainAccountAtom = Atom(name: '_HomeControllerBase.mainAccount');

  @override
  Account get mainAccount {
    _$mainAccountAtom.reportRead();
    return super.mainAccount;
  }

  @override
  set mainAccount(Account value) {
    _$mainAccountAtom.reportWrite(value, super.mainAccount, () {
      super.mainAccount = value;
    });
  }

  final _$mainCompanyAtom = Atom(name: '_HomeControllerBase.mainCompany');

  @override
  Company get mainCompany {
    _$mainCompanyAtom.reportRead();
    return super.mainCompany;
  }

  @override
  set mainCompany(Company value) {
    _$mainCompanyAtom.reportWrite(value, super.mainCompany, () {
      super.mainCompany = value;
    });
  }

  final _$getMainCompanyAsyncAction =
      AsyncAction('_HomeControllerBase.getMainCompany');

  @override
  Future<void> getMainCompany() {
    return _$getMainCompanyAsyncAction.run(() => super.getMainCompany());
  }

  final _$getAccountUpdatedAsyncAction =
      AsyncAction('_HomeControllerBase.getAccountUpdated');

  @override
  Future<void> getAccountUpdated() {
    return _$getAccountUpdatedAsyncAction.run(() => super.getAccountUpdated());
  }

  final _$getPendingTicketsAsyncAction =
      AsyncAction('_HomeControllerBase.getPendingTickets');

  @override
  Future<void> getPendingTickets() {
    return _$getPendingTicketsAsyncAction.run(() => super.getPendingTickets());
  }

  final _$saveTicketAsRealAsyncAction =
      AsyncAction('_HomeControllerBase.saveTicketAsReal');

  @override
  Future<void> saveTicketAsReal(TicketRaffle ticket, double oldValue) {
    return _$saveTicketAsRealAsyncAction
        .run(() => super.saveTicketAsReal(ticket, oldValue));
  }

  final _$removeTicketFromPendingListAsyncAction =
      AsyncAction('_HomeControllerBase.removeTicketFromPendingList');

  @override
  Future<void> removeTicketFromPendingList(TicketRaffle ticket) {
    return _$removeTicketFromPendingListAsyncAction
        .run(() => super.removeTicketFromPendingList(ticket));
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void setAccount(Account newAccount) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setAccount');
    try {
      return super.setAccount(newAccount);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearPendingList() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.clearPendingList');
    try {
      return super.clearPendingList();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pendingRequestStatus: ${pendingRequestStatus},
pendingTicketList: ${pendingTicketList},
mainAccount: ${mainAccount},
mainCompany: ${mainCompany}
    ''';
  }
}
