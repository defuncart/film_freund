import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/date_time.dart/date_time_service.dart';
import 'package:film_freund/services/movies/i_movie_database.dart';
import 'package:film_freund/services/user/i_user_database.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

export 'mocks.mocks.dart';

@GenerateMocks([
  UserManager,
  DateTimeService,
  IAuthService,
  IUserDatabase,
  IMovieDatabase,
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
