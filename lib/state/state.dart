import 'package:film_freund/managers/cache/cache_manager.dart';
import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/firebase_auth_service.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/date_time/date_time_service.dart';
import 'package:film_freund/services/lists/firebase_list_database.dart';
import 'package:film_freund/services/lists/i_list_database.dart';
import 'package:film_freund/services/local_settings/hive_local_settings_database.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/movies/movie_database.dart';
import 'package:film_freund/services/platform/i_platform_service.dart';
import 'package:film_freund/services/platform/platform_service.dart';
import 'package:film_freund/services/user/firebase_user_database.dart';
import 'package:film_freund/services/user/i_user_database.dart';
import 'package:film_freund/services/uuid/uuid_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userManagerProvider = Provider<UserManager>(
  (ref) => UserManager(
    authService: ref.read(authServiceProvider),
    userDatabase: ref.read(userDatabaseProvider),
    listDatabase: ref.read(listDatabaseProvider),
  ),
);

final movieManagerProvider = Provider<MovieManager>(
  (ref) => MovieManager(
    movieDatabase: MovieDatabase(),
    localSettings: ref.read(localSettingsDatabaseProvider),
    listDatabase: ref.read(listDatabaseProvider),
    cacheManager: ref.read(cacheManagerProvider),
  ),
);

final cacheManagerProvider = Provider<CacheManager>(
  (ref) => CacheManager(
    authService: ref.read(authServiceProvider),
    userDatabase: ref.read(userDatabaseProvider),
  ),
);

final authServiceProvider = Provider<IAuthService>(
  (_) => FirebaseAuthService(),
);

final userDatabaseProvider = Provider<IUserDatabase>(
  (ref) => FirebaseUserDatabase(
    dateTimeService: ref.read(dateTimeServiceProvider),
  ),
);

final listDatabaseProvider = Provider<IListDatabase>(
  (ref) => FirebaseListDatabase(
    uuidService: ref.read(uuidServiceProvider),
    dateTimeService: ref.read(dateTimeServiceProvider),
  ),
);

final localSettingsDatabaseProvider = Provider<ILocalSettingsDatabase>(
  (ref) => HiveLocalSettingsDatabase(
    platformService: ref.read(platformServiceProvider),
  ),
);

final platformServiceProvider = Provider<IPlatformService>(
  (_) => PlatformService(),
);

final dateTimeServiceProvider = Provider<DateTimeService>(
  (_) => DateTimeService(),
);

final uuidServiceProvider = Provider<UUIDService>(
  (_) => UUIDService(),
);
