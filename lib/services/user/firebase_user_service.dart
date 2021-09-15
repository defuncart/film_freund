import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:film_freund/services/user/user.dart';

import 'i_user_service.dart';

class FirebaseUserService implements IUserService {
  FirebaseUserService([
    FirebaseFirestore? firebaseFirestore,
  ]) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  static const _collection = 'users';

  @override
  Future<void> createUser({
    required String id,
    String firstName = 'FirstName',
    String lastName = 'LastName',
  }) async {
    final now = DateTime.now().toUtc();
    final user = User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      createdAt: now,
      updatedAt: now,
    );

    await _firebaseFirestore.collection(_collection).doc(id).set(user.toJson());
  }
}
