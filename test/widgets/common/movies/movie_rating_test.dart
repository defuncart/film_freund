import 'package:film_freund/widgets/common/movie/movie_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$MovieRating', () {
    group('percentage', () {
      test('when percentage < 0, expect assertion', () {
        expect(
          () => MovieRating(
            showRating: true,
            rating: -1,
          ),
          throwsAssertionError,
        );
      });
      test('when percentage > 100, expect assertion', () {
        expect(
          () => MovieRating(
            showRating: true,
            rating: 101,
          ),
          throwsAssertionError,
        );
      });

      test('when 0 <= percentage <= 100, expect no assertion', () {
        expect(
          () => const MovieRating(
            showRating: true,
            rating: 50,
          ),
          returnsNormally,
        );
      });
    });

    group('colorForPercentage', () {
      test('when >= 70, expect green', () {
        expect(
          MovieRating.ratingRingColor(70),
          Colors.green,
        );
      });

      test('when >= 40, expect green', () {
        expect(
          MovieRating.ratingRingColor(40),
          Colors.yellow,
        );
      });

      test('when < 40, expect red', () {
        expect(
          MovieRating.ratingRingColor(30),
          Colors.red,
        );
      });
    });

    testWidgets('ensure widget tree is correct', (tester) async {
      final widget = wrapWithMaterialApp(
        const MovieRating(
          showRating: true,
          rating: 50,
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

    testWidgets('when showRating && percentage >= 70, expect match golden', (tester) async {
      final widget = wrapWithMaterialApp(
        const RepaintBoundary(
          child: MovieRating(
            showRating: true,
            rating: 70,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MovieRating),
        matchesGoldenFile(GoldenUtils.generateFilepath(
          testFilepath: 'common/movies/movie_rating',
          imageName: 'green',
        )),
      );
    }, tags: GoldenUtils.tag);

    testWidgets('when showRating && percentage >= 40, expect match golden', (tester) async {
      final widget = wrapWithMaterialApp(
        const RepaintBoundary(
          child: MovieRating(
            showRating: true,
            rating: 40,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MovieRating),
        matchesGoldenFile(GoldenUtils.generateFilepath(
          testFilepath: 'common/movies/movie_rating',
          imageName: 'yellow',
        )),
      );
    }, tags: GoldenUtils.tag);

    testWidgets('when showRating && percentage < 40, expect match golden', (tester) async {
      final widget = wrapWithMaterialApp(
        const RepaintBoundary(
          child: MovieRating(
            showRating: true,
            rating: 30,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MovieRating),
        matchesGoldenFile(GoldenUtils.generateFilepath(
          testFilepath: 'common/movies/movie_rating',
          imageName: 'red',
        )),
      );
    }, tags: GoldenUtils.tag);

    testWidgets('when !showRating, expect match golden', (tester) async {
      final widget = wrapWithMaterialApp(
        const RepaintBoundary(
          child: MovieRating(
            showRating: false,
            rating: 30,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(MovieRating),
        matchesGoldenFile(GoldenUtils.generateFilepath(
          testFilepath: 'common/movies/movie_rating',
          imageName: 'gray',
        )),
      );
    }, tags: GoldenUtils.tag);
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

      test('should repaint is always true', () {
        const ring = Ring(
          percentage: 50,
          backgroundColor: Colors.transparent,
          normalColor: Colors.transparent,
          highlightColor: Colors.transparent,
        );

        expect(ring.shouldRepaint(ring), isTrue);
      });
    });
  });
}
