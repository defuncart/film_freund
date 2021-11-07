import 'package:film_freund/state/movie_watch_status_provider.dart';
import 'package:film_freund/widgets/common/movie/movie_rating.dart';
import 'package:film_freund/widgets/common/movie/movie_teaser_bottom_sheet.dart';
import 'package:film_freund/widgets/common/movie/movie_teaser_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../test_utils.dart';

void main() {
  group('$MovieTeaserCard', () {
    group('width', () {
      test('when width <= 0, expect assertion', () {
        expect(
          () => MovieTeaserCard(
            width: 0,
            movieTeaser: TestInstance.movieTeaser(),
          ),
          throwsAssertionError,
        );
        expect(
          () => MovieTeaserCard(
            width: -100,
            movieTeaser: TestInstance.movieTeaser(),
          ),
          throwsAssertionError,
        );
      });

      test('when width > 0, expect no assertion', () {
        expect(
          () => MovieTeaserCard(
            width: 50,
            movieTeaser: TestInstance.movieTeaser(),
          ),
          returnsNormally,
        );
      });
    });

    testWidgets('ensure widget tree is correct', (tester) async {
      mockNetworkImagesFor(() async {
        final movieTeaser = TestInstance.movieTeaser(voteCount: 100);
        final widget = wrapWithMaterialApp(
          MovieTeaserCard(
            movieTeaser: movieTeaser,
            width: 100,
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.byType(MovieTeaserCard), findsOneWidget);
        expect(find.byType(GestureDetector), findsOneWidget);
        expect(find.descendant(of: find.byType(MovieTeaserCard), matching: find.byType(MouseRegion)), findsOneWidget);
        expect(find.byType(DecoratedBox), findsOneWidget);
        expect(find.byType(ClipRRect), findsOneWidget);
        expect(find.byType(Image), findsNothing);
        expect(find.byType(MovieRating), findsNothing);
      });
    });

    testWidgets('on long press, expect $MovieTeaserBottomSheetConsumer', (tester) async {
      mockNetworkImagesFor(() async {
        final movieTeaser = TestInstance.movieTeaser(id: 1);
        final widget = ProviderScope(
          overrides: [
            movieWatchStatusProvider(1).overrideWithValue(
              const AsyncValue.data(
                MovieWatchStatus(isWatched: true, isWatchlist: false),
              ),
            )
          ],
          child: wrapWithMaterialAppLocalizationDelegates(
            MovieTeaserCard(
              movieTeaser: movieTeaser,
              width: 100,
            ),
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        await tester.longPress(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        expect(find.byType(MovieTeaserBottomSheetConsumer), findsOneWidget);
      });
    });
  });
}
