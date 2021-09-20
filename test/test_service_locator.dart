import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/date_time.dart/date_time_service.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A helper class to initialize [ServiceLocator] in tests
class TestServiceLocator {
  TestServiceLocator._();

  static late ProviderContainer _container;

  /// Register services for tests. This is generally called in `setUp`
  static void register({
    DateTimeService? dateTimeService,
    UserManager? userManager,
  }) {
    _container = ProviderContainer(
      overrides: [
        if (dateTimeService != null)
          dateTimeServiceProvider.overrideWithValue(
            dateTimeService,
          ),
        if (userManager != null)
          userManagerProvider.overrideWithValue(
            userManager,
          ),
      ],
    );
    ServiceLocator.initialize(_container.read);
  }

  /// Reset all services. This is generally called in `tearDown`
  static void rest() => _container.dispose();

  /// Returns a [ProviderScope] widget containing a container of overrided services
  ///
  /// It is expected that [register] is called before this method
  static Widget providerScope({required Widget child}) => UncontrolledProviderScope(
        container: _container,
        child: child,
      );
}
