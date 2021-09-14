import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'i_auth_service.dart';

class FirebaseAuthService implements IAuthService {
  FirebaseAuthService([FirebaseAuth? firebaseAuth]) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        _isUserAuthenicated = false;
        log('User is currently signed out!');
      } else {
        _isUserAuthenicated = true;
        log('User is signed in!');
      }
    });
  }

  final FirebaseAuth _firebaseAuth;
  var _isUserAuthenicated = false;

  bool get isUserAuthenicated => _isUserAuthenicated;

  @override
  Future<AuthResult> signin({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log('Signed in');
      return AuthResult.success;
    } on FirebaseAuthException catch (authException) {
      if (authException.code.userNotFound) {
        log('No user found for that email.');

        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          log('Created user account');
          return AuthResult.success;
        } catch (e) {
          log(e.toString());
        }
      } else if (authException.code.wrongPassword) {
        log('Wrong password provided for that user.');
        return AuthResult.incorrectPassword;
      }
    }

    return AuthResult.other;
  }

  @override
  Future<void> signout() => _firebaseAuth.signOut();
}

extension FirebaseErrorExtensions on String {
  static const _userNotFound = 'user-not-found';
  static const _wrongPassword = 'wrong-password';

  @visibleForTesting
  bool get userNotFound => this == _userNotFound;

  @visibleForTesting
  bool get wrongPassword => this == _wrongPassword;
}
