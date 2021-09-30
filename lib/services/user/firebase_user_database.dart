import 'dart:developer' show log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_freund/services/date_time/date_time_service.dart';
import 'package:film_freund/services/service_locator.dart';

import 'i_user_database.dart';
import 'models/user.dart';

class FirebaseUserDatabase implements IUserDatabase {
  FirebaseUserDatabase([
    FirebaseFirestore? firebaseFirestore,
    DateTimeService? dateTimeService,
  ])  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _dateTimeService = dateTimeService ?? ServiceLocator.dateTimeService;

  final FirebaseFirestore _firebaseFirestore;
  final DateTimeService _dateTimeService;

  static const _collection = 'users';

  /// Saves a user to db
  ///
  /// If the user does not exist, it is created, otherwise existing user overwritten
  Future<void> _saveUser(User user) async {
    await _firebaseFirestore.collection(_collection).doc(user.id).set(user.toJson());
    log('FirebaseUserDatabase saved user ${user.toString()}');
  }

  @override
  Future<User> createUser({
    required String id,
    required String email,
    String? displayName,
  }) async {
    final now = _dateTimeService.nowUtc;
    final user = User(
      id: id,
      email: email,
      displayName: displayName ?? email.split('@').first,
      createdAt: now,
      updatedAt: now,
    );

    await _saveUser(user);
    return user;
  }

  /// Maps [DocumentSnapshot] to [User]
  User? _snapshotToUser(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }

    return null;
  }

  @override
  Future<User?> getUser({required String id}) async {
    final snapshot = await _firebaseFirestore.collection(_collection).doc(id).get();
    return _snapshotToUser(snapshot);
  }

  @override
  Stream<User?> watchUser({required String id}) =>
      _firebaseFirestore.collection(_collection).doc(id).snapshots().map(_snapshotToUser);

  @override
  Future<void> updateUser({
    required User user,
    String? displayName,
    List<String>? watched,
    List<String>? watchlist,
    List<String>? lists,
  }) async {
    var updatedUser = user.copyWith(
      displayName: displayName,
      watched: watched,
      watchlist: watchlist,
      lists: lists,
    );

    if (updatedUser == user) {
      log('Warning! FirebaseUserDatabase.update nothing to update!');
      log('displayName: $displayName, watched: $watched, watchlist: $watchlist, lists: $lists');

      return;
    }

    updatedUser = updatedUser.setUpdatedAt(_dateTimeService.nowUtc);

    await _saveUser(updatedUser);
  }

  @override
  Future<void> deleteUser({required String id}) => _firebaseFirestore.collection(_collection).doc(id).delete();
}
