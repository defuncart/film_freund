import 'package:film_freund/widgets/common/movie/movie_teaser_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../test_utils.dart';

void main() {
  group('$MovieTeaserCard', () {
    final movieTeaser = TestInstance.movieTeaser();

    group('width', () {
      test('when width <= 0, expect assertion', () {
        expect(
          () => MovieTeaserCard(
            width: 0,
            movieTeaser: movieTeaser,
          ),
          throwsAssertionError,
        );
        expect(
          () => MovieTeaserCard(
            width: -100,
            movieTeaser: movieTeaser,
          ),
          throwsAssertionError,
        );
      });

      test('when width > 0, expect no assertion', () {
        expect(
          () => MovieTeaserCard(
            width: 50,
            movieTeaser: movieTeaser,
          ),
          returnsNormally,
        );
      });
    });

    testWidgets('ensure widget tree is correct', (tester) async {
      mockNetworkImagesFor(() async {
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
        // expect(find.descendant(of: find.byType(MovieTeaserCard), matching: find.byType(Stack)), findsOneWidget);
        expect(find.byType(DecoratedBox), findsOneWidget);
        expect(find.byType(ClipRRect), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
        // expect(find.byType(SizedBox), findsOneWidget);
        // expect(find.byType(Positioned), findsOneWidget);
      });
    });
  });
}
