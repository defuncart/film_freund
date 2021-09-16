import 'package:film_freund/services/auth/i_auth_service.dart';
import 'package:film_freund/widgets/home_screen/home_screen.dart';
import 'package:film_freund/widgets/my_app.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';
import '../test_service_locator.dart';

void main() {
  group('$MyAppContent', () {
    late IAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockIAuthService();
      TestServiceLocator.register(
        authService: mockAuthService,
      );
    });

    tearDown(TestServiceLocator.rest);

    testWidgets('When user is not authenticated, expect $SigninScreen', (tester) async {
      when(mockAuthService.isUserAuthenticated).thenReturn(false);

      await tester.pumpWidget(
        TestServiceLocator.providerScope(
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
      when(mockAuthService.isUserAuthenticated).thenReturn(true);

      await tester.pumpWidget(
        TestServiceLocator.providerScope(
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
