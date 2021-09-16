import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks.dart';

void main() {
  group('$ServiceLocator', () {
    final IAuthService mockAuthService = MockIAuthService();
    final container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(
          mockAuthService,
        )
      ],
    );
    ServiceLocator.initialize(container.read);

    test('When $ServiceLocator is initialized, expect access to services', () {
      expect(
        () => ServiceLocator.authService,
        returnsNormally,
      );
    });
  });
}
