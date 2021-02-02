import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:troco_premiado/shared/models/account.dart';
import 'package:troco_premiado/shared/repositories/account_repository.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_account.dart';
import 'package:troco_premiado/shared/repositories/interfaces/i_auth.dart';

class AuthRepository implements IAuth {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email' //,
    //'https://www.googleapis.com/auth/contacts.readonly',
  ]);
  FirebaseAuth _auth;

  AuthRepository({FirebaseAuth auth, GoogleSignIn googleSignIn}) {
    _auth = (auth == null) ? FirebaseAuth.instance : auth;
    _googleSignIn = (googleSignIn == null) ? _googleSignIn : googleSignIn;
  }

  @override
  Future<Account> logInGoogle() async {
    IAccount accountRepository = AccountRepository();
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);

      var account = await accountRepository.registerAccount(
        email: authResult.user.email,
        name: authResult.user.displayName,
      );

      return account;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Account> logInGoogleSilently() async {
    IAccount accountRepository = AccountRepository();
    try {
      final GoogleSignInAccount googleUser =
          await _googleSignIn.signInSilently();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);

      var account = await accountRepository.getAccount(authResult.user.email);

      return account;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Account> getCurrentAccount() async {
    IAccount accountRepository = AccountRepository();
    try {
      var user = _auth.currentUser;

      if (user == null) {
        return null;
      }

      var account = await accountRepository.getAccount(user.email);

      return account;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> logOut() async {
    // final accountCache =
    //     CacheController<Account>(cacheBoxEnum: CacheBox.Account);
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      // accountCache.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}
