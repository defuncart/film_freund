import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/home_screen/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_ui/flutter_test_ui.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';
import '../../../test_service_locator.dart';
import '../../../test_utils.dart';

void main() {
  group('$SearchView', () {
    setUpUI((tester) async {
      final widget = ProviderScope(
        overrides: [
          searchMoviesProvider.overrideWith(
            (_, searchTerm) => const [],
          ),
        ],
        child: wrapWithMaterialAppLocalizationDelegates(
          const SearchView(),
          useScaffold: true,
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });

    testUI('expect initial widget tree', (tester) async {
      expect(find.byType(SearchView), findsOneWidget);
      expect(find.byType(MovieTeasersFamilyConsumer), findsNothing);
    });

    group('when text is entered', () {
      const searchTerm = 'searchTerm';

      setUpUI((tester) async {
        await tester.enterText(find.byType(TextField), searchTerm);
        await tester.pumpAndSettle(debounceDuration);
      });

      testUI('expect $searchTerm and $MovieTeasersFamilyConsumer are displayed', (tester) async {
        expect(find.byType(SearchView), findsOneWidget);
        expect(find.byType(MovieTeasersFamilyConsumer), findsOneWidget);
        expect(find.text(searchTerm), findsOneWidget);
      });

      group('and when x button is pressed', () {
        setUpUI((tester) async {
          await tester.tap(find.byType(IconButton));
          await tester.pumpAndSettle();
        });

        testUI('expect $searchTerm and $MovieTeasersFamilyConsumer are not displayed', (tester) async {
          expect(find.byType(SearchView), findsOneWidget);
          expect(find.byType(MovieTeasersFamilyConsumer), findsNothing);
          expect(find.text(searchTerm), findsNothing);
        });
      });
    });
  }, skip: true);

  group('searchMoviesProvider', () {
    const searchTerm = 'searchTerm';
    late MovieManager mockMovieManager;

    setUp(() {
      mockMovieManager = MockMovieManager();
      TestServiceLocator.register(movieManager: mockMovieManager);
    });

    test('ensure data is correct', () async {
      final movies = [TestInstance.movieTeaser()];
      when(mockMovieManager.searchMovies(searchTerm)).thenAnswer((_) => Future.value(movies));

      final container = ProviderContainer();

      // expect loading state
      expect(
        container.read(searchMoviesProvider(searchTerm)),
        const AsyncValue<List<MovieTeaser>>.loading(),
      );

      // wait for  request to finish
      await container.read(searchMoviesProvider(searchTerm).future);

      // expect data fetched
      expect(
        container.read(searchMoviesProvider(searchTerm)).value,
        movies,
      );
    });
  });
}
