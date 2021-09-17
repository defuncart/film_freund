import 'package:film_freund/services/auth/firebase_auth_service.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/date_time.dart/date_time_service.dart';
import 'package:film_freund/services/user/firebase_user_service.dart';
import 'package:film_freund/services/user/i_user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ServiceLocator {
  static late Reader _read;

  static void initialize(Reader read) => _read = read;

  static DateTimeService get dateTimeService => _read(dateTimeServiceProvider);

  static IAuthService get authService => _read(authServiceProvider);

  static IUserService get userService => _read(userServiceProvider);
}

@visibleForTesting
final dateTimeServiceProvider = Provider<DateTimeService>(
  (_) => DateTimeService(),
);

@visibleForTesting
final authServiceProvider = Provider<IAuthService>(
  (_) => FirebaseAuthService(),
);

@visibleForTesting
final userServiceProvider = Provider<IUserService>(
  (_) => FirebaseUserService(),
);
