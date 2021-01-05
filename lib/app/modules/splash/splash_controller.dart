import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/repositories/auth_repository.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_auth.dart';

part 'splash_controller.g.dart';

@Injectable()
class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  IAuth _authRepository;

  Account prevAccount;

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
}
