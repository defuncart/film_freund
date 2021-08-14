import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'i_auth_service.dart';

class FirebaseAuthService implements IAuthService {
  FirebaseAuthService(FirebaseAuth? firebaseAuth) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance {
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
}
