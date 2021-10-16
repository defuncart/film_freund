abstract class IAuthService {
  /// Returns whether a user is currently authenicated on the device
  bool get isUserAuthenticated;

  /// When [isUserAuthenticated] is true, returns the user's id, otherwise null
  String? get authenticatedUserId;

  /// Returns a stream of events when a user is authententicated or not
  Stream<bool> get onAuthStateChanged;

  /// Attempts to sign in a user with [email] and [password]
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

  /// Changes the current user's password from [currentPassword] to [newPassword]
  ///
  /// Returns [ChangePasswordResult.success] if an account exists for user's email and [currentPassword] was correct
  ///
  /// Returns [ChangePasswordResult.incorrectPassword] if an account exists for user's email but [currentPassword] was incorrect
  ///
  /// Otherwise returns [ChangePasswordResult.other] (i.e. no internet, no user for user's email, weak new password)
  Future<ChangePasswordResult> changePassword({required String currentPassword, required String newPassword});

  /// Deletes the current user's authentication using [password]
  ///
  /// Returns [DeleteResult.success] if an account exists for user's email and [password] was correct
  ///
  /// Returns [DeleteResult.incorrectPassword] if an account exists for user's email but [password] was incorrect
  ///
  /// Otherwise returns [DeleteResult.other] (i.e. no internet, no user for user's email)
  Future<DeleteResult> delete({required String password});
}

/// An enum describing the types of authenication results for a signin action
enum AuthResult {
  createSuccess,
  signinSuccess,
  signinIncorrectPassword,
  other,
}

/// An enum describing the types of results for a change password action
enum ChangePasswordResult {
  success,
  incorrectPassword,
  other,
}

/// An enum describing the types of results for a delete action
enum DeleteResult {
  success,
  incorrectPassword,
  other,
}
