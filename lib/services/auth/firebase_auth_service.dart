import 'dart:developer';

import 'package:film_freund/services/auth/models/authenticated_user.dart';
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
  AuthenticatedUser? get authenicatedUser => _firebaseAuth.currentUser != null
      ? AuthenticatedUser(
          id: _firebaseAuth.currentUser!.uid,
          email: _firebaseAuth.currentUser!.email!,
        )
      : null;

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
}

extension on String {
  static const _userNotFound = 'user-not-found';
  static const _wrongPassword = 'wrong-password';

  @visibleForTesting
  bool get userNotFound => this == _userNotFound;

  @visibleForTesting
  bool get wrongPassword => this == _wrongPassword;
}
