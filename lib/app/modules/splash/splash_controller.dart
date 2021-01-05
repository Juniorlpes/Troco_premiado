import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/repositories/account_repository.dart';
import 'package:troco_premiado/shared/repositories/auth_repository.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_account.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_auth.dart';

part 'splash_controller.g.dart';

@Injectable()
class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  IAuth _authRepository;
  IAccount _accountRepository;

  String email;

  Future<bool> logInSilentilySuccessFully() async {
    _authRepository = AuthRepository();
    var result = await _authRepository.logInGoogleSilently();

    email = result?.email;

    return result != null;
  }

  Future<Account> getAccount() async {
    _accountRepository = AccountRepository();
    print(email);
    return await _accountRepository.getAccount(email);
  }
}
