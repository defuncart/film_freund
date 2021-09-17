import 'package:film_freund/services/user/user.dart';

/// A service to perform operations on the [User] database
abstract class IUserService {
  /// Creates a user with [id]
  Future<void> createUser({
    required String id,
    String firstName,
    String lastName,
  });

  /// Returns a user with [id]. If no such user exists, null is returned.
  Future<User?> getUser({required String id});

  /// Deletes a user by [id].
  ///
  /// Note that if no such user exists, no warning is returned.
  Future<void> deleteUser({required String id});
}
