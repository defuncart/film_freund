import 'package:film_freund/managers/cache/cache_manager.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/user/i_user_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('$CacheManager', () {
    late IAuthService mockAuthService;
    late IUserDatabase mockUserDatabase;
    late CacheManager cacheManager;

    setUp(() {
      mockAuthService = MockIAuthService();
      mockUserDatabase = MockIUserDatabase();
      cacheManager = CacheManager(
        authService: mockAuthService,
        userDatabase: mockUserDatabase,
      );
    });

    group('When not started', () {
      test('expect onAuthStateChangedSubscription is null', () {
        expect(
          cacheManager.onAuthStateChangedSubscription,
          isNull,
        );
      });

      test('expect watchedId throws', () {
        expect(
          () => cacheManager.watchedId,
          throwsAssertionError,
        );
      });

      test('expect watchlistId throws', () {
        expect(
          () => cacheManager.watchlistId,
          throwsAssertionError,
        );
      });
    });

    group('onAuthStateChanged', () {
      test('When isUserAuthenticated = false, expect clear data', () {
        cacheManager.onAuthStateChanged(false);

        expect(
          () => cacheManager.watchedId,
          throwsAssertionError,
        );
        expect(
          () => cacheManager.watchlistId,
          throwsAssertionError,
        );
      });

      group('When isUserAuthenticated = true', () {
        test('and authService.isUserAuthenticated is false, expect throw', () {
          when(mockAuthService.isUserAuthenticated).thenReturn(false);

          expect(
            () => cacheManager.onAuthStateChanged(true),
            throwsAssertionError,
          );
        });

        test('and user does not exists in database, expect throw', () {
          const userId = 'userId';

          when(mockAuthService.isUserAuthenticated).thenReturn(true);
          when(mockAuthService.authenticatedUserId).thenReturn(userId);
          when(mockUserDatabase.getUser(id: userId)).thenAnswer((_) => Future.value(null));

          expect(
            () => cacheManager.onAuthStateChanged(true),
            throwsArgumentError,
          );
        });

        test('''and authService.isUserAuthenticated is true and user exists in database, 
              expect save data''', () async {
          const userId = 'userId';
          const watchedId = 'watchedId';
          const watchlistId = 'watchlistId';
          final user = TestInstance.user(
            id: userId,
            watchedId: watchedId,
            watchlistId: watchlistId,
          );

          when(mockAuthService.isUserAuthenticated).thenReturn(true);
          when(mockAuthService.authenticatedUserId).thenReturn(userId);
          when(mockUserDatabase.getUser(id: userId)).thenAnswer((_) => Future.value(user));

          expect(
            () => cacheManager.onAuthStateChanged(true),
            returnsNormally,
          );

          // a small delay to wait onAuthStateChanged
          await Future.delayed(const Duration(milliseconds: 1));

          expect(
            cacheManager.watchedId,
            watchedId,
          );
          expect(
            cacheManager.watchlistId,
            watchlistId,
          );
        });
      });

      group('start', () {
        test('expect subscription is not null', () {
          cacheManager.start();
          when(mockAuthService.onAuthStateChanged).thenAnswer((_) => Stream.value(false));

          expect(
            cacheManager.onAuthStateChangedSubscription,
            isNotNull,
          );
        });
      }, skip: true);

      group('stop', () {
        test('expect subscription is  null', () {
          cacheManager.stop();
          expect(
            cacheManager.onAuthStateChangedSubscription,
            isNull,
          );
        });
      });
    });
  });
}
