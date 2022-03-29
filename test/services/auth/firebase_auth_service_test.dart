import 'package:film_freund/services/auth/firebase_auth_service.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() async {
  MethodChannelMocks.setupFirebase((call) {});
  await Firebase.initializeApp();

  group('$FirebaseAuthService', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late FirebaseAuthService service;

    group('isUserAuthenticated', () {
      group('when no user is authenticated', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(signedIn: false);
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect isFalse', () {
          expect(service.isUserAuthenticated, isFalse);
        });
      });

      group('when user is authenticated', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(signedIn: true);
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect isTrue', () {
          expect(service.isUserAuthenticated, isTrue);
        });
      });
    });

    group('authenticatedUserId', () {
      group('when no user is authenticated', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(signedIn: false);
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect isNull', () {
          expect(service.authenticatedUserId, isNull);
        });
      });

      group('when user is authenticated', () {
        const id = 'id';

        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(
            signedIn: true,
            mockUser: MockUser(uid: id),
          );
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect $id', () {
          expect(service.authenticatedUserId, id);
        });
      });
    });

    group('onAuthStateChanged', () {
      setUp(() {
        mockFirebaseAuth = MockFirebaseAuth(signedIn: false);
        service = FirebaseAuthService(mockFirebaseAuth);
      });

      test('when user signs in and out, expect correct events', () async {
        await mockFirebaseAuth.signInAnonymously();
        await mockFirebaseAuth.signOut();

        expect(
            service.onAuthStateChanged,
            emitsInOrder([
              false,
              true,
              false,
            ]));
      });
    });

    group('signin', () {
      group('when user exists and user is signed out', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(signedIn: false);
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect user is signed in correctly', () async {
          expect(
            await service.signin(email: 'email', password: 'password'),
            AuthResult.signinSuccess,
          );
          expect(service.isUserAuthenticated, isTrue);
        });
      });
    });

    group('signout', () {
      setUp(() {
        mockFirebaseAuth = MockFirebaseAuth();
        service = FirebaseAuthService(mockFirebaseAuth);
      });

      test('description', () async {
        await service.signout();

        expect(service.isUserAuthenticated, isFalse);
      });
    });

    group('changePassword', () {
      group('when no user is authenticated', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(signedIn: false);
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect changePassword throws assertion', () {
          expect(
            () => service.changePassword(currentPassword: 'currentPassword', newPassword: 'newPassword'),
            throwsAssertionError,
          );
        });
      });

      group('when user is authenticated', () {
        group('and user is null', () {
          setUp(() async {
            mockFirebaseAuth = MockFirebaseAuth(signedIn: true);
            service = FirebaseAuthService(mockFirebaseAuth);
          });

          test('expect ${ChangePasswordResult.other}', () async {
            expect(
              await service.changePassword(currentPassword: 'currentPassword', newPassword: 'newPassword'),
              ChangePasswordResult.other,
            );
          });
        });

        group('and user email is null', () {
          setUp(() {
            mockFirebaseAuth = MockFirebaseAuth(
              signedIn: true,
              mockUser: MockUser(),
            );
            service = FirebaseAuthService(mockFirebaseAuth);
          });

          test('expect ${ChangePasswordResult.other}', () async {
            expect(
              await service.changePassword(currentPassword: 'currentPassword', newPassword: 'newPassword'),
              ChangePasswordResult.other,
            );
          });
        });
      });

      group('and currentPassword is incorrect', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(
            signedIn: true,
            mockUser: MockUser(email: 'email')..exception = FirebaseAuthException(code: 'wrong-password'),
          );
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect ${ChangePasswordResult.incorrectPassword}', () async {
          expect(
            await service.changePassword(currentPassword: 'currentPassword', newPassword: 'newPassword'),
            ChangePasswordResult.incorrectPassword,
          );
        });
      });

      group('and another exception occurs', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(
            signedIn: true,
            mockUser: MockUser(email: 'email')..exception = FirebaseAuthException(code: 'bla'),
          );
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect ${ChangePasswordResult.other}', () async {
          expect(
            await service.changePassword(currentPassword: 'currentPassword', newPassword: 'newPassword'),
            ChangePasswordResult.other,
          );
        });
      });

      group('and user email is not null', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(signedIn: true, mockUser: MockUser(email: 'email'));
          service = FirebaseAuthService(mockFirebaseAuth);
          MethodChannelMocks.setupFirebase();
        });

        test('expect ${ChangePasswordResult.success}', () async {
          expect(
            await service.changePassword(currentPassword: 'currentPassword', newPassword: 'newPassword'),
            ChangePasswordResult.success,
          );
        });
      });
    });

    group('delete', () {
      group('when no user is authenticated', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(signedIn: false);
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect changePassword throws assertion', () {
          expect(
            () => service.delete(password: 'password'),
            throwsAssertionError,
          );
        });
      });

      group('when user is authenticated', () {
        group('and user is null', () {
          setUp(() {
            mockFirebaseAuth = MockFirebaseAuth(signedIn: true);
            service = FirebaseAuthService(mockFirebaseAuth);
          });

          test('expect ${DeleteResult.other}', () async {
            expect(
              await service.delete(password: 'password'),
              DeleteResult.other,
            );
          });
        });
      });

      group('and user email is null', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(
            signedIn: true,
            mockUser: MockUser(),
          );
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect ${DeleteResult.other}', () async {
          expect(
            await service.delete(password: 'password'),
            DeleteResult.other,
          );
        });
      });

      group('and password is incorrect', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(
            signedIn: true,
            mockUser: MockUser(email: 'email')..exception = FirebaseAuthException(code: 'wrong-password'),
          );
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect ${DeleteResult.incorrectPassword}', () async {
          expect(
            await service.delete(password: 'password'),
            DeleteResult.incorrectPassword,
          );
        });
      });

      group('and user email is not null', () {
        setUp(() {
          mockFirebaseAuth = MockFirebaseAuth(
            signedIn: true,
            mockUser: MockUser(email: 'email'),
          );
          service = FirebaseAuthService(mockFirebaseAuth);
        });

        test('expect ${DeleteResult.success}', () async {
          expect(
            await service.delete(password: 'password'),
            DeleteResult.success,
          );
        });
      });
    });
  });

  group('AuthStringExtensions', () {
    group('userNotFound', () {
      test('when user-not-found expect isTrue', () {
        expect('user-not-found'.userNotFound, isTrue);
      });

      test('when not user-not-found expect isFalse', () {
        expect('bla'.userNotFound, isFalse);
      });
    });

    group('wrongPassword', () {
      test('when wrong-password expect isTrue', () {
        expect('wrong-password'.wrongPassword, isTrue);
      });

      test('when not wrong-password expect isFalse', () {
        expect('bla'.wrongPassword, isFalse);
      });
    });
  });
}
