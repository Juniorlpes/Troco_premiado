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

  final _$getAccountUpdatedAsyncAction =
      AsyncAction('_HomeControllerBase.getAccountUpdated');

  @override
  Future<void> getAccountUpdated() {
    return _$getAccountUpdatedAsyncAction.run(() => super.getAccountUpdated());
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
  String toString() {
    return '''
mainAccount: ${mainAccount}
    ''';
  }
}
