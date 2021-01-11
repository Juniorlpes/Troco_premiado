import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/repositories/auth_repository.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_auth.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  IAuth _authRepository = AuthRepository();

  Future<Account> logInGoogle() async {
    final account = await _authRepository.logInGoogle();

    return account;
  }
}
