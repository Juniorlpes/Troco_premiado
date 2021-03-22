import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/shared/cache/cache_box_enum.dart';
import 'package:troco_premiado/shared/cache/cache_controller.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/company.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';
import 'package:troco_premiado/shared/repositories/account_repository.dart';
import 'package:troco_premiado/shared/repositories/auth_repository.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_account_facade.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_auth_facade.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_raffle_facade.dart';
import 'package:troco_premiado/shared/repositories/raffle_repository.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  IAuthFacade _authRepository = AuthRepository();
  IAccountFacade _accountRepository = AccountRepository();
  IRaffleFacade _raffleRepository = RaffleRepository();

  @observable
  Account mainAccount;

  @observable
  Company mainCompany;

  @action
  void setAccount(Account newAccount) => mainAccount = newAccount;

  @action
  Future<void> getMainCompany() async {
    //TODO: put Error mensage and review this method
    final companyCache =
        CacheController<Company>(cacheBoxEnum: CacheBox.Company);

    mainCompany = await companyCache.getByKey('mainCompany');

    if (mainCompany != null) {
      return;
    }
    mainCompany = await _accountRepository.getCompany(mainAccount.companyId);
    companyCache.writeByKey('mainCompany', mainCompany);
    // do {
    //   mainCompany = await _accountRepository.getCompany(mainAccount.companyId);
    //   if (mainCompany == null) {
    //     await Future<void>.delayed(Duration(milliseconds: 500));
    //   }
    // } while (mainCompany == null);
  }

  @action
  Future<void> getAccountUpdated() async {
    final newAccount = await _accountRepository.getAccount(mainAccount.email);
    if (newAccount != null) {
      mainAccount = newAccount;
    }
  }

  Future<TicketRaffle> createRealTicketRaffle(
      String clientName, String phone, double ticketValue) async {
    return await _raffleRepository.generateRealTicket(
        mainAccount, mainCompany, clientName, phone, ticketValue);
  }

  Future<TicketRaffle> createPendingTicketRaffle(
      String clientName, String phone, double ticketValue) async {
    return await _raffleRepository.generatePendingTicket(
        mainAccount, mainCompany, clientName, phone, ticketValue);
  }

  Future<List<TicketRaffle>> getPendingTickets() async {
    return await _raffleRepository.getPendingTickets(mainCompany);
  }

  Future<bool> logOut() async {
    return await _authRepository.logOut();
  }
}
