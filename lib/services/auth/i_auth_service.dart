abstract class IAuthService {
  /// Returns whether a user is currently authenicated on the device
  bool get isUserAuthenticated;

  /// When [isUserAuthenticated] is true, returns the user's id, otherwise null
  String? get authenticatedUserId;

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

  /// Signs out a user
  ///
  /// [isUserAuthenticated] will thereafter be false
  Future<void> signout();

  /// Deletes the current user's authentication using [email] and [password]
  ///
  /// Returns [DeleteResult.success] if an account exists for [email] and [password] was correct
  ///
  /// Returns [DeleteResult.incorrectPassword] if an account exists for [email] but [password] was incorrect
  ///
  /// Otherwise returns [DeleteResult.other] (i.e. no internet, no user for [email])
  Future<DeleteResult> delete({required String email, required String password});
}

/// An enum describing the types of authenication results for a signin action
enum AuthResult {
  createSuccess,
  signinSuccess,
  signinIncorrectPassword,
  other,
}

/// An enum describing the types of results for a delete action
enum DeleteResult {
  success,
  incorrectPassword,
  other,
}
