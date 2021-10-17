import 'package:film_freund/managers/cache/cache_manager.dart';
import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks.dart';
import '../test_service_locator.dart';

void main() {
  group('$ServiceLocator', () {
    test('When $ServiceLocator is initialized, expect access to services', () async {
      MethodChannelMocks.setupFirebase();
      await Firebase.initializeApp();
      final container = ProviderContainer();
      ServiceLocator.setReader(container.read);

      expect(
        () => ServiceLocator.userManager,
        returnsNormally,
      );
      expect(
        () => ServiceLocator.movieManager,
        returnsNormally,
      );
      expect(
        () => ServiceLocator.cacheManager,
        returnsNormally,
      );
      expect(
        () => ServiceLocator.localSettings,
        returnsNormally,
      );
    });

    group('ensure services can be mocked', () {
      late UserManager mockUserManager;
      late MovieManager mockMovieManager;
      late CacheManager mockCacheManager;
      late ILocalSettingsDatabase mockLocalSettings;

      setUp(() {
        mockUserManager = MockUserManager();
        mockMovieManager = MockMovieManager();
        mockCacheManager = MockCacheManager();
        mockLocalSettings = MockILocalSettingsDatabase();
        TestServiceLocator.register(
          userManager: mockUserManager,
          movieManager: mockMovieManager,
          cacheManager: mockCacheManager,
          localSettings: mockLocalSettings,
        );
      });

      tearDown(TestServiceLocator.reset);

      test('When $ServiceLocator is initialized, expect access to services', () {
        expect(
          () => ServiceLocator.userManager,
          returnsNormally,
        );
        expect(
          () => ServiceLocator.movieManager,
          returnsNormally,
        );
        expect(
          () => ServiceLocator.cacheManager,
          returnsNormally,
        );
        expect(
          () => ServiceLocator.localSettings,
          returnsNormally,
        );
      });
    });
  });
}
