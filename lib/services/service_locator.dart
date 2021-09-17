import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/firebase_auth_service.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/date_time.dart/date_time_service.dart';
import 'package:film_freund/services/user/firebase_user_database.dart';
import 'package:film_freund/services/user/i_user_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ServiceLocator {
  static late Reader _read;

  static void initialize(Reader read) => _read = read;

  static DateTimeService get dateTimeService => _read(dateTimeServiceProvider);

  static UserManager get userManager => _read(userManagerProvider);

  static IAuthService get authService => _read(authServiceProvider);

  static IUserDatabase get userDatabase => _read(userDatabaseProvider);
}

@visibleForTesting
final dateTimeServiceProvider = Provider<DateTimeService>(
  (_) => DateTimeService(),
);

@visibleForTesting
final userManagerProvider = Provider<UserManager>(
  (_) => UserManager(
    authService: FirebaseAuthService(),
    userDatabase: FirebaseUserDatabase(),
  ),
);

@visibleForTesting
final authServiceProvider = Provider<IAuthService>(
  (_) => FirebaseAuthService(),
);

@visibleForTesting
final userDatabaseProvider = Provider<IUserDatabase>(
  (_) => FirebaseUserDatabase(),
);
