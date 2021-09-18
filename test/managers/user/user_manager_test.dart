import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/user/i_user_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('$UserManager', () {
    late IAuthService mockAuthService;
    late IUserDatabase mockUserDatabase;
    late UserManager userManager;

    setUp(() {
      mockAuthService = MockIAuthService();
      mockUserDatabase = MockIUserDatabase();
      userManager = UserManager(
        authService: mockAuthService,
        userDatabase: mockUserDatabase,
      );
    });

    group('isAuthenticated', () {
      test('when IAuthService user not authenticated, expect isFalse', () {
        when(mockAuthService.isUserAuthenticated).thenReturn(false);

        expect(userManager.isAuthenticated, isFalse);
      });

      test('when IAuthService user is authenticated, expect isTrue', () {
        when(mockAuthService.isUserAuthenticated).thenReturn(true);

        expect(userManager.isAuthenticated, isTrue);
      });
    });

    group('currentUser', () {
      test('IAuthService user not authenticated, expect AssertionError', () {
        when(mockAuthService.isUserAuthenticated).thenReturn(false);

        expect(
          () => userManager.currentUser,
          throwsAssertionError,
        );
      });

      test('IAuthService user authenticated, IUserDatabase no user found, expect ArgumentError', () {
        const id = 'id';

        when(mockAuthService.isUserAuthenticated).thenReturn(true);
        when(mockAuthService.authenticatedUserId).thenReturn(id);
        when(mockUserDatabase.getUser(id: id)).thenAnswer((_) => Future.value(null));

        expect(
          () => userManager.currentUser,
          throwsArgumentError,
        );
      });

      test('IAuthService user authenticated, IUserDatabase user found, expect user', () async {
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
      test('IUserDatabase no user found, expect isNull', () async {
        const id = 'id';

        when(mockUserDatabase.getUser(id: id)).thenAnswer((_) => Future.value(null));

        expect(
          await userManager.getUser(id: id),
          isNull,
        );
      });

      test('IUserDatabase user found, expect user', () async {
        const id = 'id';
        final user = TestInstance.user(id: 'id');

        when(mockUserDatabase.getUser(id: id)).thenAnswer((_) => Future.value(user));

        expect(
          await userManager.getUser(id: id),
          user,
        );
      });
    });
  });
}
