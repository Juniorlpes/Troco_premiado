import 'package:flutter/foundation.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/company.dart';

/*
    Rotina:
  A pessoa vai se logar e retornara uma conta inativa. Eu no firebase vou criar
  a entidade da empresa e terminar a configurar o account.

  Ao ele ficar ativo, os dados do account será atualizado e ele usará o app 
  normalmente.

*/

abstract class IAccount {
  Future<Account> getAccount();
  Future<Account> registerAccount(
      {@required String email, @required String name});
  Future<Company> getCompany(String companyId);
  Future<bool> setLocationCompany(); //ver parametros
}
