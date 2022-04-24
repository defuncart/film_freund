import 'package:film_freund/managers/cache/cache_manager.dart';
import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/state/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ServiceLocator {
  static late Reader _read;

  static void setReader(Reader read) => _read = read;

  static UserManager get userManager => _read(userManagerProvider);

  static MovieManager get movieManager => _read(movieManagerProvider);

  static CacheManager get cacheManager => _read(cacheManagerProvider);

  static ILocalSettingsDatabase get localSettings => _read(localSettingsDatabaseProvider);
}
