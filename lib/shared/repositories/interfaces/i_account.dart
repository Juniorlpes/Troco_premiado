import 'package:troco_premiado/shared/models/account.dart';

abstract class IAccount {
  Future<Account> getAccount(); //O cache faz nessa funcao ou cria outra
}
