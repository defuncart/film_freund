import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_consumer.dart';
import 'package:film_freund/widgets/home_screen/popular/popular_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';
import '../../../riverpod_provider_extension.dart';
import '../../../test_service_locator.dart';
import '../../../test_utils.dart';

void main() {
  group('$PopularView', () {
    testWidgets('Expect correct widget tree', (tester) async {
      final widget = ProviderScope(
        overrides: [
          popularMoviesProvider.overrideWithValue(
            const AsyncValue.data([]),
          ),
        ],
        child: wrapWithMaterialApp(
          const PopularView(),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(PopularView), findsOneWidget);
      expect(find.byType(MovieTeasersConsumer), findsOneWidget);
    });
  });

  group('popularMoviesProvider', () {
    late MovieManager mockMovieManager;

    setUp(() {
      mockMovieManager = MockMovieManager();
      TestServiceLocator.register(movieManager: mockMovieManager);
    });

    test('ensure data is correct', () async {
      final movies = [TestInstance.movieTeaser()];
      when(mockMovieManager.getPopular()).thenAnswer((_) => Future.value(movies));

      final container = ProviderContainer();

      // expect loading state
      expect(
        container.read(popularMoviesProvider),
        const AsyncValue<List<MovieTeaser>>.loading(),
      );

      // wait for  request to finish
      await container.read(popularMoviesProvider.future);

      // expect data fetched
      expect(
        container.read(popularMoviesProvider).value,
        movies,
      );
    });
  });
}
