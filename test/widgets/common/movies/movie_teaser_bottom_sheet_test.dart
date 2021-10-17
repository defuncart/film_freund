import 'package:film_freund/widgets/common/movie/movie_teaser_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$MovieTeaserBottomSheet', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      const movieId = 0;
      const movieTitle = 'Title';
      const movieYear = 'Year';
      final widget = wrapWithMaterialAppLocalizationDelegates(
        const MovieTeaserBottomSheet(
          movieId: movieId,
          movieTitle: movieTitle,
          movieYear: movieYear,
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text(movieTitle), findsOneWidget);
      expect(find.text(movieYear), findsOneWidget);
      expect(find.byType(Divider), findsNWidgets(2));
      expect(find.byType(IconOptionButton), findsNWidgets(2));
      expect(find.byType(TextOptionButton), findsNWidgets(2));
    });
  });
}
