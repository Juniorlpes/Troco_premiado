import 'package:troco_premiado/shared/models/account.dart';

abstract class IAuth {
  Future<Account> logInGoogle();
  Future<Account> logInGoogleSilently();
  Future<Account> getCurrentAccount();
  Future<bool> logOut();
}
