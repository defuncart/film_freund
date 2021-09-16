import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks.dart';
import '../test_service_locator.dart';

void main() {
  group('$ServiceLocator', () {
    late IAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockIAuthService();
      TestServiceLocator.register(
        authService: mockAuthService,
      );
    });

    tearDown(TestServiceLocator.rest);

    test('When $ServiceLocator is initialized, expect access to services', () {
      expect(
        () => ServiceLocator.authService,
        returnsNormally,
      );
    });
  });
}
