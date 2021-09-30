import 'package:film_freund/widgets/common/movie/movie_rating.dart';
import 'package:film_freund/widgets/common/movie/movie_teaser_card.dart';
import 'package:flutter/material.dart';
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
        // expect(find.byType(GestureDetector), findsOneWidget);
        // expect(
        // find.descendant(of: find.byType(MovieTeaserCard), matching: find.byType(GestureDetector)), findsOneWidget);
        expect(find.descendant(of: find.byType(MovieTeaserCard), matching: find.byType(MouseRegion)), findsOneWidget);
        expect(find.descendant(of: find.byType(MovieTeaserCard), matching: find.byType(Tooltip)), findsOneWidget);
        expect(find.byType(DecoratedBox), findsOneWidget);
        expect(find.byType(ClipRRect), findsOneWidget);
        expect(find.byType(Image), findsNothing);
        expect(find.byType(MovieRating), findsNothing);
      });
    });
  });
}
