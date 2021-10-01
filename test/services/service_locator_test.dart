import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/date_time/date_time_service.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../firebase_mocks.dart';
import '../mocks.dart';
import '../test_service_locator.dart';

void main() {
  group('$ServiceLocator', () {
    test('When $ServiceLocator is initialized, expect access to services', () async {
      setupFirebaseMocks();
      await Firebase.initializeApp();
      final container = ProviderContainer();
      ServiceLocator.setReader(container.read);

      expect(
        () => ServiceLocator.dateTimeService,
        returnsNormally,
      );
      expect(
        () => ServiceLocator.userManager,
        returnsNormally,
      );
      expect(
        () => ServiceLocator.movieManager,
        returnsNormally,
      );
      expect(
        () => ServiceLocator.localSettings,
        returnsNormally,
      );
    });

    group('ensure services can be mocked', () {
      late DateTimeService mockDateTimeService;
      late UserManager mockUserManager;
      late MovieManager mockMovieManager;
      late ILocalSettingsDatabase mockLocalSettings;

      setUp(() {
        mockDateTimeService = MockDateTimeService();
        mockUserManager = MockUserManager();
        mockMovieManager = MockMovieManager();
        mockLocalSettings = MockILocalSettingsDatabase();
        TestServiceLocator.register(
          dateTimeService: mockDateTimeService,
          userManager: mockUserManager,
          movieManager: mockMovieManager,
          localSettings: mockLocalSettings,
        );
      });

      tearDown(TestServiceLocator.reset);

      test('When $ServiceLocator is initialized, expect access to services', () {
        expect(
          () => ServiceLocator.dateTimeService,
          returnsNormally,
        );
        expect(
          () => ServiceLocator.userManager,
          returnsNormally,
        );
        expect(
          () => ServiceLocator.movieManager,
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
