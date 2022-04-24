import 'package:film_freund/widgets/common/movie/movie_teasers.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../test_utils.dart';

void main() {
  group('$MovieTeasersAsyncValue', () {
    testWidgets('when value is loading, expect $CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithMaterialApp(
            const MovieTeasersAsyncValue(AsyncValue.loading()),
          ),
        ),
      );

      expect(find.byType(MovieTeasersAsyncValue), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    group('when value has data', () {
      const noData = 'noData';

      testWidgets('and data is not empty, expect $MovieTeasers', (tester) async {
        mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            ProviderScope(
              child: wrapWithMaterialApp(
                MovieTeasersAsyncValue(
                  AsyncValue.data([TestInstance.movieTeaser()]),
                  noData: const Text(noData),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.byType(MovieTeasersAsyncValue), findsOneWidget);
          expect(find.byType(MovieTeasers), findsOneWidget);
          expect(find.byType(Text), findsNothing);
          expect(find.text(noData), findsNothing);
        });
      });

      group('and data is empty', () {
        testWidgets('and noData is given, expect noData', (tester) async {
          await tester.pumpWidget(
            ProviderScope(
              child: wrapWithMaterialApp(
                const MovieTeasersAsyncValue(
                  AsyncValue.data([]),
                  noData: Text(noData),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.byType(MovieTeasersAsyncValue), findsOneWidget);
          expect(find.byType(MovieTeasers), findsNothing);
          expect(find.byType(Text), findsOneWidget);
          expect(find.text(noData), findsOneWidget);
        });

        testWidgets('and noData is not given, expect nothing', (tester) async {
          await tester.pumpWidget(
            ProviderScope(
              child: wrapWithMaterialApp(
                const MovieTeasersAsyncValue(
                  AsyncValue.data([]),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(find.byType(MovieTeasersAsyncValue), findsOneWidget);
          expect(find.byType(MovieTeasers), findsNothing);
          expect(find.byType(Text), findsNothing);
          expect(find.text(noData), findsNothing);
        });
      });
    });

    testWidgets('when value has error, expect $Text and error description', (tester) async {
      const errorDescription = 'An error occured';
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithMaterialApp(
            const MovieTeasersAsyncValue(AsyncValue.error(errorDescription)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MovieTeasersAsyncValue), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text(errorDescription), findsOneWidget);
    });
  });
}
