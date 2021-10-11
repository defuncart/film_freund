import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/user/i_user_database.dart';
import 'package:film_freund/services/user/models/user.dart';

/// A manager which handles user authentication and performs user database operations
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

  /// Returns the current user
  ///
  /// Throws an error if no user is authenticated
  Future<User> get currentUser async {
    assert(isAuthenticated, 'User should be authenticated');

    final id = _authService.authenticatedUserId;
    if (id != null) {
      final user = await _userDatabase.getUser(id: id);

      if (user != null) {
        return user;
      }
    }

    throw ArgumentError('User should be authenticated');
  }

  /// Watches the current user
  ///
  /// Throws an error if no user is authenticated
  Stream<User?> get watchCurrentUser {
    assert(isAuthenticated, 'User should be authenticated');

    final id = _authService.authenticatedUserId;
    if (id != null) {
      return _userDatabase.watchUser(id: id);
    }

    throw ArgumentError('User should be authenticated');
  }

  /// Returns a user with [id]. If no such user exists, null is returned.
  Future<User?> getUser({required String id}) => _userDatabase.getUser(id: id);

  /// Attempts to sign in a user with [email] and [password]
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
      await _userDatabase.createUser(
        id: _authService.authenticatedUserId!,
        email: email,
      );
    }

    return result;
  }

  /// Signs out a user
  Future<void> signout() => _authService.signout();

  /// Updates [displayName] for the current user
  Future<void> updateDisplayName(
    String displayName,
  ) async =>
      _userDatabase.updateUser(
        user: await currentUser,
        displayName: displayName,
      );

  /// Changes the current user's password from [currentPassword] to [newPassword]
  ///
  /// See [IAuthService] for more info
  Future<ChangePasswordResult> changePassword({required String currentPassword, required String newPassword}) =>
      _authService.changePassword(currentPassword: currentPassword, newPassword: newPassword);

  /// Deletes the current user's authentication using [email] and [password]
  ///
  /// See [IAuthService] for more info
  Future<DeleteResult> deleteUser({required String password}) async {
    final userId = _authService.authenticatedUserId;

    final result = await _authService.delete(password: password);

    // if user was deleted, remove user db object
    if (result == DeleteResult.success) {
      await _userDatabase.deleteUser(
        id: userId!,
      );
    }

    return result;
  }
}
