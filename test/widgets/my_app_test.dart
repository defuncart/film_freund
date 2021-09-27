import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/widgets/home_screen/home_screen.dart';
import 'package:film_freund/widgets/my_app.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../firebase_auth_mock.dart';
import '../mocks.dart';
import '../test_service_locator.dart';

void main() {
  group('$MyApp', () {
    testWidgets('Ensure initial loading state', (tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );

      expect(find.byType(MyApp), findsOneWidget);
      expect(find.byType(Material), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Ensure data state', (tester) async {
      setupFirebaseAuthMocks();

      final UserManager mockUserManager = MockUserManager();
      TestServiceLocator.register(
        userManager: mockUserManager,
      );
      when(mockUserManager.isAuthenticated).thenReturn(false);

      await tester.pumpWidget(
        TestServiceLocator.providerScope(
          child: const MyApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MyApp), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(MyAppContent), findsOneWidget);
    });
  });

  group('$MyAppContent', () {
    late UserManager mockUserManager;

    setUp(() {
      mockUserManager = MockUserManager();
      TestServiceLocator.register(
        userManager: mockUserManager,
      );
    });

    tearDown(TestServiceLocator.reset);

    testWidgets('When user is not authenticated, expect $SigninScreen', (tester) async {
      when(mockUserManager.isAuthenticated).thenReturn(false);

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
      when(mockUserManager.isAuthenticated).thenReturn(true);

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
