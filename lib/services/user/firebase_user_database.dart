import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_freund/services/date_time.dart/date_time_service.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/services/user/user.dart';

import 'i_user_database.dart';

class FirebaseUserDatabase implements IUserDatabase {
  FirebaseUserDatabase([
    FirebaseFirestore? firebaseFirestore,
    DateTimeService? dateTimeService,
  ])  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _dateTimeService = dateTimeService ?? ServiceLocator.dateTimeService;

  final FirebaseFirestore _firebaseFirestore;
  final DateTimeService _dateTimeService;

  static const _collection = 'users';

  @override
  Future<void> createUser({
    required String id,
    String firstName = 'FirstName',
    String lastName = 'LastName',
  }) async {
    final now = _dateTimeService.nowUtc;
    final user = User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      createdAt: now,
      updatedAt: now,
    );

    await _firebaseFirestore.collection(_collection).doc(id).set(user.toJson());
  }

  @override
  Future<User?> getUser({required String id}) async {
    final snapshot = await _firebaseFirestore.collection(_collection).doc(id).get();
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }

    return null;
  }

  @override
  Future<void> deleteUser({required String id}) => _firebaseFirestore.collection(_collection).doc(id).delete();
}
