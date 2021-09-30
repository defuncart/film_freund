import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/user/i_user_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('$UserManager', () {
    late IAuthService mockAuthService;
    late IUserDatabase mockUserDatabase;
    late ILocalSettingsDatabase mockLocalSettings;
    late UserManager userManager;

    setUp(() {
      mockAuthService = MockIAuthService();
      mockUserDatabase = MockIUserDatabase();
      mockLocalSettings = MockILocalSettingsDatabase();
      userManager = UserManager(
        authService: mockAuthService,
        userDatabase: mockUserDatabase,
        localSettings: mockLocalSettings,
      );
    });

    group('isAuthenticated', () {
      test('when $IAuthService user not authenticated, expect isFalse', () {
        when(mockAuthService.isUserAuthenticated).thenReturn(false);

        expect(userManager.isAuthenticated, isFalse);
      });

      test('when $IAuthService user is authenticated, expect isTrue', () {
        when(mockAuthService.isUserAuthenticated).thenReturn(true);

        expect(userManager.isAuthenticated, isTrue);
      });
    });

    group('currentUser', () {
      test('$IAuthService user not authenticated, expect AssertionError', () {
        when(mockAuthService.isUserAuthenticated).thenReturn(false);

        expect(
          () => userManager.currentUser,
          throwsAssertionError,
        );
      });

      test('$IAuthService user authenticated, $IUserDatabase no user found, expect ArgumentError', () {
        const id = 'id';

        when(mockAuthService.isUserAuthenticated).thenReturn(true);
        when(mockAuthService.authenticatedUserId).thenReturn(id);
        when(mockUserDatabase.getUser(id: id)).thenAnswer((_) => Future.value(null));

        expect(
          () => userManager.currentUser,
          throwsArgumentError,
        );
      });

      test('$IAuthService user authenticated, $IUserDatabase user found, expect user', () async {
        const id = 'id';
        final user = TestInstance.user(id: 'id');

        when(mockAuthService.isUserAuthenticated).thenReturn(true);
        when(mockAuthService.authenticatedUserId).thenReturn(id);
        when(mockUserDatabase.getUser(id: id)).thenAnswer((_) => Future.value(user));

        expect(
          await userManager.currentUser,
          user,
        );
      });
    });

    group('getUser', () {
      test('$IUserDatabase no user found, expect isNull', () async {
        const id = 'id';

        when(mockUserDatabase.getUser(id: id)).thenAnswer((_) => Future.value(null));

        expect(
          await userManager.getUser(id: id),
          isNull,
        );
      });

      test('$IUserDatabase user found, expect user', () async {
        const id = 'id';
        final user = TestInstance.user(id: 'id');

        when(mockUserDatabase.getUser(id: id)).thenAnswer((_) => Future.value(user));

        expect(
          await userManager.getUser(id: id),
          user,
        );
      });
    });

    group('signin', () {
      const email = 'email';
      const password = 'password';

      test('when $IAuthService.signin ${AuthResult.createSuccess}, expect user is created on database', () async {
        const id = 'id';

        when(mockAuthService.signin(email: email, password: password))
            .thenAnswer((_) => Future.value(AuthResult.createSuccess));
        when(mockAuthService.authenticatedUserId).thenReturn(id);

        final result = await userManager.signin(email: email, password: password);
        expect(result, AuthResult.createSuccess);

        verify(mockUserDatabase.createUser(id: id, email: email));
      });

      test('$IAuthService.signin ${AuthResult.signinSuccess}', () async {
        when(mockAuthService.signin(email: email, password: password))
            .thenAnswer((_) => Future.value(AuthResult.signinSuccess));

        expect(
          await userManager.signin(email: email, password: password),
          AuthResult.signinSuccess,
        );
      });

      test('$IAuthService.signin ${AuthResult.signinIncorrectPassword}', () async {
        when(mockAuthService.signin(email: email, password: password))
            .thenAnswer((_) => Future.value(AuthResult.signinIncorrectPassword));

        expect(
          await userManager.signin(email: email, password: password),
          AuthResult.signinIncorrectPassword,
        );
      });

      test('$IAuthService.signin ${AuthResult.other}', () async {
        when(mockAuthService.signin(email: email, password: password))
            .thenAnswer((_) => Future.value(AuthResult.other));

        expect(
          await userManager.signin(email: email, password: password),
          AuthResult.other,
        );
      });
    });

    test('signout', () {
      userManager.signout();

      verify(mockAuthService.signout());
    });

    test('updateDisplayName', () {
      const id = 'id';
      final user = TestInstance.user();

      when(mockAuthService.isUserAuthenticated).thenReturn(true);
      when(mockAuthService.authenticatedUserId).thenReturn(id);
      when(mockUserDatabase.getUser(id: id)).thenAnswer((_) => Future.value(user));

      const updatedDisplayName = 'updatedDisplayName';
      final updatedUser = user.copyWith(displayName: updatedDisplayName);

      userManager.updateDisplayName(updatedDisplayName);

      verify(mockUserDatabase.updateUser(
        user: updatedUser,
      ));
    });

    test('changePassword', () async {
      const currentPassword = 'currentPassword';
      const newPassword = 'newPassword';
      const changePasswordResult = ChangePasswordResult.success;

      when(mockAuthService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      )).thenAnswer((_) => Future.value(changePasswordResult));

      final result = await userManager.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      expect(result, changePasswordResult);

      verify(mockAuthService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      ));
    });

    group('delete', () {
      const id = 'id';
      const password = 'password';

      setUp(() {
        when(mockAuthService.authenticatedUserId).thenReturn(id);
      });

      test('IAuthService.delete ${DeleteResult.success}, expect IUserDatabase delete', () async {
        when(mockAuthService.delete(password: password)).thenAnswer((_) => Future.value(DeleteResult.success));

        expect(
          await userManager.deleteUser(password: password),
          DeleteResult.success,
        );

        verify(mockUserDatabase.deleteUser(id: id));
      });

      test('IAuthService.delete ${DeleteResult.incorrectPassword}', () async {
        when(mockAuthService.delete(password: password))
            .thenAnswer((_) => Future.value(DeleteResult.incorrectPassword));

        expect(
          await userManager.deleteUser(password: password),
          DeleteResult.incorrectPassword,
        );
      });

      test('IAuthService.delete ${DeleteResult.other}', () async {
        when(mockAuthService.delete(password: password)).thenAnswer((_) => Future.value(DeleteResult.other));

        expect(
          await userManager.deleteUser(password: password),
          DeleteResult.other,
        );
      });
    });
  });
}
