import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/date_time/date_time_service.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/movies/i_movie_database.dart';
import 'package:film_freund/services/user/i_user_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

export 'mocks.mocks.dart';

@GenerateMocks([
  UserManager,
  MovieManager,
  DateTimeService,
  IAuthService,
  IUserDatabase,
  IMovieDatabase,
  ILocalSettingsDatabase,
])
void main() {}

/// Mocks [VoidCallback]
///
/// ```dart
/// final mockVoidCallback = MockVoidCallback();
/// verifyNever(mockVoidCallback.call());
/// ```
class MockVoidCallback extends Mock {
  void call();
}

typedef Callback = void Function(MethodCall call);

class MethodChannelMocks {
// Copied from https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_auth/firebase_auth/test/mock.dart
  static void setupFirebase([Callback? customHandlers]) {
    TestWidgetsFlutterBinding.ensureInitialized();

    MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
      if (call.method == 'Firebase#initializeCore') {
        return [
          {
            'name': defaultFirebaseAppName,
            'options': {
              'apiKey': '123',
              'appId': '123',
              'messagingSenderId': '123',
              'projectId': '123',
            },
            'pluginConstants': {},
          }
        ];
      }

      if (call.method == 'Firebase#initializeApp') {
        return {
          'name': call.arguments['appName'],
          'options': call.arguments['options'],
          'pluginConstants': {},
        };
      }

      if (customHandlers != null) {
        customHandlers(call);
      }

      return null;
    });
  }
}
