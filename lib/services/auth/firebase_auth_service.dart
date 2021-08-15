import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

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
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(response);
    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        try {
          final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            // TODO ignore
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            // TODO should never happen
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');

        return AuthResult.incorrectPassword;
      }
    }

    return AuthResult.other;
  }
}
