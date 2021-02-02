import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/repositories/account_repository.dart';
import 'package:troco_premiado/shared/repositories/auth_repository.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_account.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_auth.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  IAuth _authRepository = AuthRepository();
  IAccount _accountRepository = AccountRepository();

  @observable
  Account mainAccount;

  @action
  void setAccount(Account newAccount) => mainAccount = newAccount;

  @action
  Future<void> getAccountUpdated() async {
    final newAccount = await _accountRepository.getAccount(mainAccount.email);
    if (newAccount != null) {
      mainAccount = newAccount;
    }
  }

  Future<bool> logOut() async {
    return await _authRepository.logOut();
  }
}
