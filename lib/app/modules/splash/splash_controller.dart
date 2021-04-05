import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:troco_premiado/shared/cache/cache_adapters_id.dart';
import 'package:troco_premiado/shared/cache/cache_box_enum.dart';
import 'package:troco_premiado/shared/cache/cache_controller.dart';
import 'package:troco_premiado/shared/enums/e_user_type.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/models/company.dart';
import 'package:troco_premiado/shared/repositories/auth_repository.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_auth_facade.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_raffle_dates_facade.dart';
import 'package:troco_premiado/shared/repositories/raffle_date_repository.dart';

part 'splash_controller.g.dart';

@Injectable()
class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  IAuthFacade _authRepository = AuthRepository();

  Account prevAccount;

  Future<void> initHive() async {
    if (Hive.isAdapterRegistered(CacheAdaptersId.CompanyAdapter)) {
      return;
    }
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(CompanyAdapter());
    Hive.registerAdapter(EUserTypeAdapter());
  }

  Future<bool> logInSilentilySuccessFully() async {
    var result = await _authRepository.logInGoogleSilently();

    prevAccount = result;

    return result != null;
  }

  Future<bool> getCurrentAccountSuccessFully() async {
    var result = await _authRepository.getCurrentAccount();

    prevAccount = result;

    return result != null;
  }

  Future<void> verifyAndSetRaffleDatesCache() async {
    IRaffleDateFacade raffleDateFacade = RaffleDatesRepository();
    final cacheDateRaffles =
        CacheController<DateTime>(cacheBoxEnum: CacheBox.DateRaffles);

    var date2 = await cacheDateRaffles.getByKey(2);

    if (date2 == null) {
      await raffleDateFacade.cacheRaffleDates(
          month: DateTime.now().month, year: DateTime.now().year);

      date2 = await cacheDateRaffles.getByKey(2);
    }

    if (DateTime.now().isAfter(date2)) {
      await raffleDateFacade.cacheNextRafflesDates(date2);
    }
  }
}
