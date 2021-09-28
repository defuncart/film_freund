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

  group('$MovieRating', () {
    group('percentage', () {
      test('when percentage < 0, expect assertion', () {
        expect(
          () => MovieRating(
            percentage: -1,
          ),
          throwsAssertionError,
        );
      });
      test('when percentage > 100, expect assertion', () {
        expect(
          () => MovieRating(
            percentage: 101,
          ),
          throwsAssertionError,
        );
      });

      test('when 0 <= percentage <= 100, expect no assertion', () {
        expect(
          () => const MovieRating(
            percentage: 50,
          ),
          returnsNormally,
        );
      });
    });

    group('colorForPercentage', () {
      test('when >= 70, expect green', () {
        expect(
          MovieRating.colorForPercentage(70),
          Colors.green,
        );
      });

      test('when >= 40, expect green', () {
        expect(
          MovieRating.colorForPercentage(40),
          Colors.yellow,
        );
      });

      test('when < 40, expect red', () {
        expect(
          MovieRating.colorForPercentage(30),
          Colors.red,
        );
      });
    });

    testWidgets('ensure widget tree is correct', (tester) async {
      final widget = wrapWithMaterialApp(
        const MovieRating(
          percentage: 50,
        ),
      );
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(MovieRating), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.descendant(of: find.byType(MovieRating), matching: find.byType(CustomPaint)), findsOneWidget);
      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('50'), findsOneWidget);
    });

    testWidgets('when percentage >= 70, expect match golden', (tester) async {
      final widget = wrapWithMaterialApp(
        const RepaintBoundary(
          child: MovieRating(
            percentage: 70,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MovieRating),
        matchesGoldenFile('goldens/common/movies/movie_teaser_card/movie_rating_green.png'),
      );
    }, skip: true);

    testWidgets('when percentage >= 40, expect match golden', (tester) async {
      final widget = wrapWithMaterialApp(
        const RepaintBoundary(
          child: MovieRating(
            percentage: 40,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MovieRating),
        matchesGoldenFile('goldens/common/movies/movie_teaser_card/movie_rating_yellow.png'),
      );
    }, skip: true);

    testWidgets('when percentage < 40, expect match golden', (tester) async {
      final widget = wrapWithMaterialApp(
        const RepaintBoundary(
          child: MovieRating(
            percentage: 30,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MovieRating),
        matchesGoldenFile('goldens/common/movies/movie_teaser_card/movie_rating_red.png'),
      );
    }, skip: true);
  });

  group('$Ring', () {
    group('percentage', () {
      test('when percentage < 0, expect assertion', () {
        expect(
          () => Ring(
            percentage: -1,
            backgroundColor: Colors.transparent,
            normalColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          throwsAssertionError,
        );
      });
      test('when percentage > 100, expect assertion', () {
        expect(
          () => Ring(
            percentage: 101,
            backgroundColor: Colors.transparent,
            normalColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          throwsAssertionError,
        );
      });

      test('when 0 <= percentage <= 100, expect no assertion', () {
        expect(
          () => const Ring(
            percentage: 50,
            backgroundColor: Colors.transparent,
            normalColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          returnsNormally,
        );
      });
    });
  });
}
