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

    testWidgets('when value has data, expect $MovieTeasers', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          ProviderScope(
            child: wrapWithMaterialApp(
              MovieTeasersAsyncValue(AsyncValue.data([TestInstance.movieTeaser()])),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(MovieTeasersAsyncValue), findsOneWidget);
        expect(find.byType(MovieTeasers), findsOneWidget);
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
