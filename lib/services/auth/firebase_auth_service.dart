import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'i_auth_service.dart';

class FirebaseAuthService implements IAuthService {
  FirebaseAuthService([
    FirebaseAuth? firebaseAuth,
  ]) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  bool get isUserAuthenticated => _firebaseAuth.currentUser != null;

  @override
  String? get authenticatedUserId => _firebaseAuth.currentUser?.uid;

  @override
  Future<AuthResult> signin({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log('Signed in');
      return AuthResult.signinSuccess;
    } on FirebaseAuthException catch (authException) {
      if (authException.code.userNotFound) {
        log('No user found for that email.');

        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          log('Created user account');
          return AuthResult.createSuccess;
        } catch (e) {
          log(e.toString());
        }
      } else if (authException.code.wrongPassword) {
        log('Wrong password provided for that user.');
        return AuthResult.signinIncorrectPassword;
      }
    }

    return AuthResult.other;
  }

  @override
  Future<void> signout() => _firebaseAuth.signOut();

  @override
  Future<DeleteResult> delete({required String email, required String password}) async {
    assert(isUserAuthenticated, 'No signed-in user to delete');

    final user = _firebaseAuth.currentUser;
    final credentials = EmailAuthProvider.credential(email: email, password: password);

    try {
      final result = await user?.reauthenticateWithCredential(credentials);

      await result?.user?.delete();

      return DeleteResult.success;
    } on FirebaseAuthException catch (authException) {
      if (authException.code.wrongPassword) {
        log('FirebaseAuthService.delete: Wrong password provided for user.');
        return DeleteResult.incorrectPassword;
      }
    }

    return DeleteResult.other;
  }
}

extension on String {
  static const _userNotFound = 'user-not-found';
  static const _wrongPassword = 'wrong-password';

  @visibleForTesting
  bool get userNotFound => this == _userNotFound;

  @visibleForTesting
  bool get wrongPassword => this == _wrongPassword;
}
