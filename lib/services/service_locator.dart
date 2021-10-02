import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/firebase_auth_service.dart';
import 'package:film_freund/services/date_time/date_time_service.dart';
import 'package:film_freund/services/lists/firebase_list_database.dart';
import 'package:film_freund/services/local_settings/hive_local_settings_database.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/movies/movie_database.dart';
import 'package:film_freund/services/platform/i_platform_service.dart';
import 'package:film_freund/services/platform/platform_service.dart';
import 'package:film_freund/services/user/firebase_user_database.dart';
import 'package:film_freund/services/uuid/uuid_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ServiceLocator {
  static late Reader _read;

  static void setReader(Reader read) => _read = read;

  static DateTimeService get dateTimeService => _read(dateTimeServiceProvider);

  static UserManager get userManager => _read(userManagerProvider);

  static MovieManager get movieManager => _read(movieManagerProvider);

  static ILocalSettingsDatabase get localSettings => _read(localSettingsDatabaseProvider);
}

@visibleForTesting
final dateTimeServiceProvider = Provider<DateTimeService>(
  (_) => DateTimeService(),
);

@visibleForTesting
final uuidServiceProvider = Provider<UUIDService>(
  (_) => UUIDService(),
);

@visibleForTesting
final userManagerProvider = Provider<UserManager>(
  (ref) => UserManager(
    authService: FirebaseAuthService(),
    userDatabase: FirebaseUserDatabase(),
    listDatabase: FirebaseListDatabase(
      uuidService: ref.read(uuidServiceProvider),
      dateTimeService: ref.read(dateTimeServiceProvider),
    ),
  ),
);

@visibleForTesting
final movieManagerProvider = Provider<MovieManager>(
  (ref) => MovieManager(
    movieDatabase: MovieDatabase(),
    localSettings: ref.read(localSettingsDatabaseProvider),
  ),
);

@visibleForTesting
final localSettingsDatabaseProvider = Provider<ILocalSettingsDatabase>(
  (ref) => HiveLocalSettingsDatabase(
    platformService: ref.read(platformServiceProvider),
  ),
);

@visibleForTesting
final platformServiceProvider = Provider<IPlatformService>(
  (_) => PlatformService(),
);
