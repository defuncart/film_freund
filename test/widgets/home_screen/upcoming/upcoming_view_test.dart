import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_consumer.dart';
import 'package:film_freund/widgets/home_screen/upcoming/upcoming_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks.dart';
import '../../../test_service_locator.dart';
import '../../../test_utils.dart';

void main() {
  group('$UpcomingView', () {
    testWidgets('Expect correct widget tree', (tester) async {
      final widget = ProviderScope(
        overrides: [
          upcomingMoviesProvider.overrideWithValue(
            const AsyncValue.data([]),
          ),
        ],
        child: wrapWithMaterialApp(
          const UpcomingView(),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(UpcomingView), findsOneWidget);
      expect(find.byType(MovieTeasersConsumer), findsOneWidget);
    });
  });

  group('upcomingMoviesProvider', () {
    late MovieManager mockMovieManager;

    setUp(() {
      mockMovieManager = MockMovieManager();
      TestServiceLocator.register(movieManager: mockMovieManager);
    });

    test('ensure data is correct', () async {
      final movies = [TestInstance.movieTeaser()];
      when(mockMovieManager.getUpcoming()).thenAnswer((_) => Future.value(movies));

      final container = ProviderContainer();

      // expect loading state
      expect(
        container.read(upcomingMoviesProvider),
        const AsyncValue<List<MovieTeaser>>.loading(),
      );

      // wait for  request to finish
      await container.read(upcomingMoviesProvider.future);

      // expect data fetched
      expect(
        container.read(upcomingMoviesProvider).value,
        movies,
      );
    });
  });
}
