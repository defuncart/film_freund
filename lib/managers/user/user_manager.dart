import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/user/i_user_database.dart';

/// A manager which handles user authentication and performs database operations
class UserManager {
  UserManager({
    required IAuthService authService,
    required IUserDatabase userDatabase,
  })  : _authService = authService,
        _userDatabase = userDatabase;

  final IAuthService _authService;
  final IUserDatabase _userDatabase;

  /// Returns whether a user is currently authenicated on the device
  bool get isAuthenticated => _authService.isUserAuthenticated;

  /// Attempts to signing a user with [email] and [password]
  ///
  /// See [IAuthService] for more info
  Future<AuthResult> signin({
    required String email,
    required String password,
  }) async {
    final result = await _authService.signin(
      email: email,
      password: password,
    );

    // if user was created, create user db object
    if (result == AuthResult.createSuccess) {
      final authenicatedUser = _authService.authenicatedUser!;
      await _userDatabase.createUser(
        id: authenicatedUser.id,
        email: authenicatedUser.email,
      );
    }

    return result;
  }

  /// Signs out a user
  Future<void> signout() => _authService.signout();
}
