import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/state/movie_watch_status_provider.dart';
import 'package:film_freund/state/state.dart';
import 'package:film_freund/widgets/common/movie/movie_teaser_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_ui/flutter_test_ui.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$MovieTeaserBottomSheetConsumer', () {
    late MockMovieManager mockMovieManager;

    setUp(() {
      mockMovieManager = MockMovieManager();
    });

    testWidgets('loading', (tester) async {
      const movieId = 1;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            movieWatchStatusProvider(movieId).overrideWithValue(
              const AsyncValue.loading(),
            ),
            movieManagerProvider.overrideWithValue(mockMovieManager),
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
            movieManagerProvider.overrideWithValue(mockMovieManager),
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
            movieManagerProvider.overrideWithValue(mockMovieManager),
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
    const movieId = 0;
    const movieTitle = 'Title';
    const movieYear = 'Year';
    late MockVoidFunctionT<int> mockOnAddWatchedMovie;
    late MockVoidFunctionT<int> mockOnRemoveWatchedMovie;
    late MockVoidFunctionT<int> mockOnAddWatchlistMovie;
    late MockVoidFunctionT<int> mockOnRemoveWatchlistMovie;

    setUp(() {
      mockOnAddWatchedMovie = MockVoidFunctionT<int>();
      mockOnRemoveWatchedMovie = MockVoidFunctionT<int>();
      mockOnAddWatchlistMovie = MockVoidFunctionT<int>();
      mockOnRemoveWatchlistMovie = MockVoidFunctionT<int>();
    });

    group('isWatched, isWatchlist are true', () {
      setUpUI((tester) async {
        final widget = wrapWithMaterialAppLocalizationDelegates(
          MovieTeaserBottomSheet(
            movieId: movieId,
            movieTitle: movieTitle,
            movieYear: movieYear,
            isWatched: true,
            isWatchlist: true,
            onAddWatchedMovie: mockOnAddWatchedMovie,
            onRemoveWatchedMovie: mockOnRemoveWatchedMovie,
            onAddWatchlistMovie: mockOnAddWatchlistMovie,
            onRemoveWatchlistMovie: mockOnRemoveWatchlistMovie,
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
      });

      testUI('Ensure widget tree is correct', (tester) async {
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

      testUI('on watched tap, expect remove', (tester) async {
        await tester.tap(find.byType(IconOptionButton).first);

        verifyNever(mockOnAddWatchedMovie(movieId));
        verify(mockOnRemoveWatchedMovie(movieId));
      });

      testUI('on watchlist tap, expect remove', (tester) async {
        await tester.tap(find.byType(IconOptionButton).last);

        verifyNever(mockOnAddWatchlistMovie(movieId));
        verify(mockOnRemoveWatchlistMovie(movieId));
      });
    });

    group('isWatched, isWatchlist are false', () {
      setUpUI((tester) async {
        final widget = wrapWithMaterialAppLocalizationDelegates(
          MovieTeaserBottomSheet(
            movieId: movieId,
            movieTitle: movieTitle,
            movieYear: movieYear,
            isWatched: false,
            isWatchlist: false,
            onAddWatchedMovie: mockOnAddWatchedMovie,
            onRemoveWatchedMovie: mockOnRemoveWatchedMovie,
            onAddWatchlistMovie: mockOnAddWatchlistMovie,
            onRemoveWatchlistMovie: mockOnRemoveWatchlistMovie,
          ),
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
      });

      testUI('on watched tap, expect add', (tester) async {
        await tester.tap(find.byType(IconOptionButton).first);

        verify(mockOnAddWatchedMovie(movieId));
        verifyNever(mockOnRemoveWatchedMovie(movieId));
      });

      testUI('on watchlist tap, expect add', (tester) async {
        await tester.tap(find.byType(IconOptionButton).last);

        verify(mockOnAddWatchlistMovie(movieId));
        verifyNever(mockOnRemoveWatchlistMovie(movieId));
      });
    });
  });

  group('$IconOptionButton', () {
    const icon = Icons.code;
    const label = 'Label';
    late VoidCallback mockVoidCallback;

    setUp(() {
      mockVoidCallback = MockVoidCallback();
    });

    setUpUI((tester) async {
      final widget = wrapWithMaterialApp(
        IconOptionButton(
          icon: icon,
          label: label,
          onPressed: mockVoidCallback,
        ),
      );

      await tester.pumpWidget(widget);
    });

    testUI('Ensure widget tree is correct', (tester) async {
      expect(find.byType(IconOptionButton), findsOneWidget);
      expect(find.byType(MaterialButton), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(icon), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text(label), findsOneWidget);
    });

    testUI('Ensure onPressed can be invoked', (tester) async {
      await tester.tap(find.byType(IconOptionButton));
      await tester.pumpAndSettle();

      verify(mockVoidCallback.call());
    });
  });

  group('$TextOptionButton', () {
    const text = 'Text';
    late VoidCallback mockVoidCallback;

    setUp(() {
      mockVoidCallback = MockVoidCallback();
    });

    setUpUI((tester) async {
      final widget = wrapWithMaterialApp(
        TextOptionButton(
          text,
          onPressed: mockVoidCallback,
        ),
      );

      await tester.pumpWidget(widget);
    });

    testUI('Ensure widget tree is correct', (tester) async {
      expect(find.byType(TextOptionButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.text(text), findsOneWidget);
    });

    testUI('Ensure onPressed can be invoked', (tester) async {
      await tester.tap(find.byType(TextOptionButton));
      await tester.pumpAndSettle();

      verify(mockVoidCallback.call());
    });
  });
}
