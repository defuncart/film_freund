import 'package:film_freund/managers/cache/cache_manager.dart';
import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/state/state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A helper class to initialize [ServiceLocator] in tests
class TestServiceLocator {
  TestServiceLocator._();

  static late ProviderContainer _container;

  /// Register services for tests. This is generally called in `setUp`
  static void register({
    UserManager? userManager,
    MovieManager? movieManager,
    CacheManager? cacheManager,
    ILocalSettingsDatabase? localSettings,
  }) {
    _container = ProviderContainer(
      overrides: [
        if (userManager != null)
          userManagerProvider.overrideWithValue(
            userManager,
          ),
        if (movieManager != null)
          movieManagerProvider.overrideWithValue(
            movieManager,
          ),
        if (cacheManager != null)
          cacheManagerProvider.overrideWithValue(
            cacheManager,
          ),
        if (localSettings != null)
          localSettingsDatabaseProvider.overrideWithValue(
            localSettings,
          ),
      ],
    );
    ServiceLocator.setReader(_container.read);
  }

  /// Reset all services. This is generally called in `tearDown`
  static void reset() => _container.dispose();

  /// Returns a [ProviderScope] widget containing a container of overrided services
  ///
  /// It is expected that [register] is called before this method
  static Widget providerScope({required Widget child}) => UncontrolledProviderScope(
        container: _container,
        child: child,
      );
}
