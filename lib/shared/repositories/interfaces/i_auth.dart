abstract class IAuth {
  Future<void> logInGoogle();
  Future<void> logInGoogleSilently();
}
