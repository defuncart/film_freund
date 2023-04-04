import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_stream_consumer.dart';
import 'package:film_freund/widgets/home_screen/watched/watched_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';
import '../../../riverpod_provider_extension.dart';
import '../../../test_service_locator.dart';
import '../../../test_utils.dart';

void main() {
  group('$WatchedView', () {
    testWidgets('Expect correct widget tree', (tester) async {
      final widget = ProviderScope(
        overrides: [
          watchedMoviesProvider.overrideWithValue(
            const AsyncValue.data([]),
          ),
        ],
        child: wrapWithMaterialApp(
          const WatchedView(),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(WatchedView), findsOneWidget);
      expect(find.byType(MovieTeasersStreamConsumer), findsOneWidget);
    });
  }, skip: true);

  group('watchedMoviesProvider', () {
    late MovieManager mockMovieManager;

    setUp(() {
      mockMovieManager = MockMovieManager();
      TestServiceLocator.register(movieManager: mockMovieManager);
    });

    test('ensure data is correct', () async {
      final movies = [TestInstance.movieTeaser()];
      when(mockMovieManager.watchedMovies).thenAnswer((_) => Stream.value(movies));

      final container = ProviderContainer();

      // expect loading state
      expect(
        container.read(watchedMoviesProvider),
        const AsyncValue<List<MovieTeaser>>.loading(),
      );

      // wait for  request to finish
      await container.read(watchedMoviesProvider.future);

      // expect data fetched
      expect(
        container.read(watchedMoviesProvider).value,
        movies,
      );
    });
  });
}
