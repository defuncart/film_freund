import 'package:film_freund/services/auth/models/authenticated_user.dart';

abstract class IAuthService {
  /// Returns whether a user is currently authenicated on the device
  bool get isUserAuthenticated;

  /// When [isUserAuthenticated] is true, returns [AuthenticatedUser], otherwise null
  AuthenticatedUser? get authenicatedUser;

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
}

/// An enum describing the types of authenication results for a signin action
enum AuthResult {
  createSuccess,
  signinSuccess,
  signinIncorrectPassword,
  other,
}
