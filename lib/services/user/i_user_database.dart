import 'package:film_freund/services/user/models/user.dart';

/// A service to perform operations on the [User] database
abstract class IUserDatabase {
  /// Creates a user with [id] and [email]
  Future<void> createUser({
    required String id,
    required String email,
    String firstName,
    String lastName,
  });

  /// Returns a user with [id]. If no such user exists, null is returned.
  Future<User?> getUser({required String id});

  /// Updates a user with given overriden parameters [firstName],
  /// [lastName], [watched], [watchlist] and/or [lists]
  Future<void> updateUser({
    required User user,
    String? firstName,
    String? lastName,
    List<String>? watched,
    List<String>? watchlist,
    List<String>? lists,
  });

  /// Deletes a user by [id].
  ///
  /// Note that if no such user exists, no warning is returned.
  Future<void> deleteUser({required String id});
}
