import 'dart:async';

import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/user/i_user_database.dart';
import 'package:meta/meta.dart';

/// A manager which caches some user details in memory
class CacheManager {
  CacheManager({
    required IAuthService authService,
    required IUserDatabase userDatabase,
  })  : _authService = authService,
        _userDatabase = userDatabase;

  final IAuthService _authService;
  final IUserDatabase _userDatabase;

  @visibleForTesting
  StreamSubscription<bool>? onAuthStateChangedSubscription;

  String? _watchedId;

  /// The current user's watched list id
  String get watchedId {
    assert(_watchedId != null, 'User must be authencicated');

    return _watchedId!;
  }

  String? _watchlistId;

  /// The current user's watchlist list id
  String get watchlistId {
    assert(_watchlistId != null, 'User must be authencicated');

    return _watchlistId!;
  }

  /// Start persisting data
  void start() => onAuthStateChangedSubscription = _authService.onAuthStateChanged.listen(onAuthStateChanged);

  @visibleForTesting
  Future<void> onAuthStateChanged(bool isUserAuthenticated) async {
    if (isUserAuthenticated) {
      assert(_authService.isUserAuthenticated, 'User should be authenticated');

      final user = await _userDatabase.getUser(id: _authService.authenticatedUserId!);
      if (user != null) {
        _watchedId = user.watchedId;
        _watchlistId = user.watchlistId;
      } else {
        throw ArgumentError('User should be authenticated');
      }
    } else {
      _watchedId = null;
      _watchlistId = null;
    }
  }

  /// Stops persisting data
  void stop() => onAuthStateChangedSubscription?.cancel();
}
