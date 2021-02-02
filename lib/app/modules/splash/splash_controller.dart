import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:troco_premiado/shared/cache/cache_box_enum.dart';
import 'package:troco_premiado/shared/cache/cache_controller.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/company.dart';
import 'package:troco_premiado/shared/models/ticket_raffle.dart';
import 'package:troco_premiado/shared/repositories/auth_repository.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_auth.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_raffle.dart';
import 'package:troco_premiado/shared/repositories/raffle_repository.dart';

part 'splash_controller.g.dart';

@Injectable()
class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  IAuth _authRepository;

  Account prevAccount;

  Future<void> initHive() async {
    if (Hive.isAdapterRegistered(1)) {
      return;
    }
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(AccountAdapter());
    Hive.registerAdapter(CompanyAdapter());
    Hive.registerAdapter(TicketRaffleAdapter());
  }

  Future<bool> logInSilentilySuccessFully() async {
    _authRepository = AuthRepository();
    var result = await _authRepository.logInGoogleSilently();

    prevAccount = result;

    return result != null;
  }

  Future<bool> getCurrentAccountSuccessFully() async {
    _authRepository = AuthRepository();
    var result = await _authRepository.getCurrentAccount();

    prevAccount = result;

    return result != null;
  }

  Future<void> verifyAndSetRaffleDatesCache() async {
    IRaffle raffleRepository = RaffleRepository();
    final cacheDateRaffles =
        CacheController<DateTime>(cacheBoxEnum: CacheBox.DateRaffles);

    var date2 = await cacheDateRaffles.getByKey(2);

    if (date2 == null) {
      await raffleRepository.cacheRaffleDates(
          month: DateTime.now().month, year: DateTime.now().year);

      date2 = await cacheDateRaffles.getByKey(2);
    }

    if (DateTime.now().isAfter(date2)) {
      await raffleRepository.cacheNextRaffleDates(date2);
    }
  }
}
