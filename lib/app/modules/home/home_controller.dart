import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/company.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';
import 'package:troco_premiado/shared/repositories/account_repository.dart';
import 'package:troco_premiado/shared/repositories/auth_repository.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_account.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_auth.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_raffle.dart';
import 'package:troco_premiado/shared/repositories/raffle_repository.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  IAuth _authRepository = AuthRepository();
  IAccount _accountRepository = AccountRepository();
  IRaffle _raffleRepository = RaffleRepository();

  @observable
  Account mainAccount;

  @observable
  Company mainCompany;

  @action
  void setAccount(Account newAccount) => mainAccount = newAccount;

  @action
  Future<void> getMainCompany() async {
    //TODO: Improve this
    do {
      mainCompany = await _accountRepository.getCompany(mainAccount.companyId);
      if (mainCompany == null) {
        await Future<void>.delayed(Duration(milliseconds: 500));
      }
    } while (mainCompany == null);
  }

  @action
  Future<void> getAccountUpdated() async {
    final newAccount = await _accountRepository.getAccount(mainAccount.email);
    if (newAccount != null) {
      mainAccount = newAccount;
    }
  }

  Future<TicketRaffle> createTicketRaffle(
      String clientName, String phone, double ticketValue) async {
    return await _raffleRepository.sortNumber(
        mainAccount, mainCompany, clientName, phone, ticketValue);
  }

  Future<bool> logOut() async {
    return await _authRepository.logOut();
  }
}
