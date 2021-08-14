import 'package:film_freund/di_container.dart';
import 'package:film_freund/widgets/my_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'di_container_test.mocks.dart';

// TODO remove, just for testing
@GenerateMocks([
  ITestService,
])
void main() {
  group('$DIContainer', () {
    testWidgets('When MyApp is initialized, expect DIContainer to be initialized', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));

      expect(
        () => DIContainer.testService,
        returnsNormally,
      );

      expect(
        DIContainer.testService.myMethod(),
        1,
      );
    });

    testWidgets('when testServiceProvider is override, expect overridden value', (tester) async {
      final mockTestService = MockITestService();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            testServiceProvider.overrideWithProvider(
              Provider((ref) => mockTestService),
            )
          ],
          child: const MyApp(),
        ),
      );

      when(mockTestService.myMethod()).thenReturn(42);

      expect(DIContainer.testService, isNotNull);
      expect(
        DIContainer.testService.myMethod(),
        42,
      );
    });
  });
}
