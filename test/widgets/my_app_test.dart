import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/widgets/home_screen/home_screen.dart';
import 'package:film_freund/widgets/my_app.dart';
import 'package:film_freund/widgets/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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
      MethodChannelMocks.setupFirebase();

      final UserManager mockUserManager = MockUserManager();
      final ILocalSettingsDatabase mockLocalSettings = MockILocalSettingsDatabase();
      TestServiceLocator.register(
        userManager: mockUserManager,
        localSettings: mockLocalSettings,
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
    }, skip: true);
  });

  group('$MyAppContent', () {
    late UserManager mockUserManager;
    late ILocalSettingsDatabase mockLocalSettings;

    setUp(() {
      mockUserManager = MockUserManager();
      mockLocalSettings = MockILocalSettingsDatabase();
      TestServiceLocator.register(
        userManager: mockUserManager,
        localSettings: mockLocalSettings,
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
