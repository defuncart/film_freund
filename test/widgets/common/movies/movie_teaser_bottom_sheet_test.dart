import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/state/movie_watch_status_provider.dart';
import 'package:film_freund/widgets/common/movie/movie_teaser_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$MovieTeaserBottomSheetConsumer', () {
    testWidgets('loading', (tester) async {
      const movieId = 1;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            movieWatchStatusProvider(movieId).overrideWithValue(
              const AsyncValue.loading(),
            ),
          ],
          child: const MovieTeaserBottomSheetConsumer(
            movieId: movieId,
            movieTitle: 'Title',
            movieYear: '2021',
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('error', (tester) async {
      const movieId = 1;
      const error = 'error';
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            movieWatchStatusProvider(movieId).overrideWithValue(
              const AsyncValue.error(error),
            ),
          ],
          child: const MaterialApp(
            home: MovieTeaserBottomSheetConsumer(
              movieId: movieId,
              movieTitle: 'Title',
              movieYear: '2021',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Text), findsOneWidget);
      expect(find.text(error), findsOneWidget);
    });

    testWidgets('data', (tester) async {
      const movieId = 1;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            movieWatchStatusProvider(movieId).overrideWithValue(
              const AsyncValue.data(
                MovieWatchStatus(isWatched: true, isWatchlist: false),
              ),
            ),
          ],
          child: wrapWithMaterialAppLocalizationDelegates(
            const MovieTeaserBottomSheetConsumer(
              movieId: movieId,
              movieTitle: 'Title',
              movieYear: '2021',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MovieTeaserBottomSheet), findsOneWidget);
    });
  });

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
          isWatched: true,
          isWatchlist: true,
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text(movieTitle), findsOneWidget);
      expect(find.text(movieYear), findsOneWidget);
      expect(find.byType(Divider), findsNWidgets(2));
      expect(find.byType(IconOptionButton), findsNWidgets(2));
      expect(find.text(AppLocalizations.current.activeViewWatchedTitle), findsOneWidget);
      expect(find.text(AppLocalizations.current.activeViewWatchlistTitle), findsOneWidget);
      expect(find.byType(TextOptionButton), findsNWidgets(2));
      expect(find.text(AppLocalizations.current.movieTeaserBottomSheetAddToListButtonText), findsOneWidget);
      expect(find.text(AppLocalizations.current.movieTeaserBottomSheetShowMovieButtonText), findsOneWidget);
    });
  });
}
