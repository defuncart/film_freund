import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_async_value.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_stream_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../test_utils.dart';

void main() {
  group('$MovieTeasersStreamConsumer', () {
    final provider = StreamProvider.autoDispose<List<MovieTeaser>>(
      (ref) => Stream.value([
        TestInstance.movieTeaser(),
      ]),
    );

    testWidgets('when provider is loading, expect $CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithMaterialApp(
            MovieTeasersStreamConsumer(provider: provider),
          ),
        ),
      );

      expect(find.byType(MovieTeasersStreamConsumer), findsOneWidget);
      expect(find.byType(MovieTeasersAsyncValue), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('when provider has data, expect $MovieTeasers', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          ProviderScope(
            child: wrapWithMaterialApp(
              MovieTeasersStreamConsumer(provider: provider),
            ),
          ),
        );

        expect(find.byType(MovieTeasersStreamConsumer), findsOneWidget);
        expect(find.byType(MovieTeasersAsyncValue), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pumpAndSettle();

        expect(find.byType(MovieTeasers), findsOneWidget);
      });
    });

    testWidgets('when provider has error, expect $Text and error description', (tester) async {
      const errorDescription = 'An error occured';
      final provider = StreamProvider.autoDispose<List<MovieTeaser>>(
        (ref) => Stream.error(errorDescription),
      );
      await tester.pumpWidget(
        ProviderScope(
          child: wrapWithMaterialApp(
            MovieTeasersStreamConsumer(provider: provider),
          ),
        ),
      );

      expect(find.byType(MovieTeasersStreamConsumer), findsOneWidget);
      expect(find.byType(MovieTeasersAsyncValue), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(Text), findsOneWidget);
      expect(find.text(errorDescription), findsOneWidget);
    });
  });
}
