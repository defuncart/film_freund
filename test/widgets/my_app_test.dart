import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:film_freund/widgets/home_screen/home_screen.dart';
import 'package:film_freund/widgets/my_app.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  group('$MyAppContent', () {
    testWidgets('When user is not authenticated, expect $SigninScreen', (tester) async {
      final IAuthService mockAuthService = MockIAuthService();

      final container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(
            mockAuthService,
          ),
        ],
      );
      ServiceLocator.initialize(container.read);

      when(mockAuthService.isUserAuthenticated).thenReturn(false);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MyAppContent(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MyAppContent), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(SigninScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('When user is authenticated, expect $HomeScreen', (tester) async {
      final IAuthService mockAuthService = MockIAuthService();

      final container = ProviderContainer(
        overrides: [
          authServiceProvider.overrideWithValue(
            mockAuthService,
          ),
        ],
      );
      ServiceLocator.initialize(container.read);

      when(mockAuthService.isUserAuthenticated).thenReturn(true);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MyAppContent(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MyAppContent), findsOneWidget);
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(SigninScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
