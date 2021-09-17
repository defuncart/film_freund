abstract class IAuthService {
  /// Returns whether a user is currently authenicated on the device
  bool get isUserAuthenticated;

  // TODO This could be part of an AuthResult model
  /// When [isUserAuthenticated] is true, returns the user's id, otherwise null
  String? get authenicatedUserId;

  /// Attempts to signing a user with [email] and [password]
  ///
  /// Returns [AuthResult.createSuccess] if no account exists for [email] but one was successfully created
  ///
  /// Returns [AuthResult.signinSuccess] if an account exists for [email] and [password] was correct
  ///
  /// Returns [AuthResult.signinIncorrectPassword] if an account exists for [email] but [password] was incorrect
  ///
  /// Otherwise returns [AuthResult.other] (i.e. no internet, password too weak on account creation)
  Future<AuthResult> signin({required String email, required String password});

  /// Signs a user out
  ///
  /// [isUserAuthenticated] will thereafter be false
  Future<void> signout();
}

/// An enum describing the types of authenication results for a signin action
enum AuthResult {
  createSuccess,
  signinSuccess,
  signinIncorrectPassword,
  other,
}
