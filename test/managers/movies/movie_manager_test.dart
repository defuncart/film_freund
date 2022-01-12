import 'package:film_freund/managers/cache/cache_manager.dart';
import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/services/lists/enums/list_type.dart';
import 'package:film_freund/services/lists/i_list_database.dart';
import 'package:film_freund/services/lists/models/movie_list.dart';
import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/local_settings/region.dart';
import 'package:film_freund/services/movies/i_movie_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('$MovieManager', () {
    const region = Region.de;
    const watchedId = 'watchedId';
    const watchlistId = 'watchlistId';

    late IMovieDatabase mockMovieDatabase;
    late ILocalSettingsDatabase mockLocalSettings;
    late IListDatabase mockListDatabase;
    late CacheManager mockCacheManager;
    late MovieManager movieManager;

    setUp(() {
      mockMovieDatabase = MockIMovieDatabase();
      mockLocalSettings = MockILocalSettingsDatabase();
      mockListDatabase = MockIListDatabase();
      mockCacheManager = MockCacheManager();
      movieManager = MovieManager(
        movieDatabase: mockMovieDatabase,
        localSettings: mockLocalSettings,
        listDatabase: mockListDatabase,
        cacheManager: mockCacheManager,
      );

      when(mockCacheManager.watchedId).thenReturn(watchedId);
      when(mockCacheManager.watchlistId).thenReturn(watchlistId);
    });

    final teasers = [TestInstance.movieTeaser()];

    test('getPopular', () async {
      when(mockLocalSettings.region).thenReturn(region);
      when(mockMovieDatabase.getPopular(region: region.countryCode)).thenAnswer((_) => Future.value(teasers));

      expect(await movieManager.getPopular(), teasers);
    });

    test('getUpcoming', () async {
      when(mockLocalSettings.region).thenReturn(region);
      when(mockMovieDatabase.getUpcoming(region: region.countryCode)).thenAnswer((_) => Future.value(teasers));

      expect(await movieManager.getUpcoming(), teasers);
    });

    group('watchedMovies', () {
      test('expect correct stream', () {
        final watched = TestInstance.movieList(
          type: ListType.watched,
          movies: [1],
        );
        when(mockListDatabase.watchList(id: watchedId)).thenAnswer((_) => Stream.value(watched));

        final watchedMovies = watched.movies.map((id) => TestInstance.movieTeaser(id: id));
        when(mockMovieDatabase.getMovies(watched.movies)).thenAnswer((_) => Future.value([TestInstance.movie(id: 1)]));

        expect(
          movieManager.watchedMovies,
          emitsInOrder([watchedMovies]),
        );
      });
    });

    group('watchlistMovies', () {
      test('expect correct stream', () {
        final watchlist = TestInstance.movieList(
          type: ListType.watchlist,
          movies: [1],
        );
        when(mockListDatabase.watchList(id: watchlistId)).thenAnswer((_) => Stream.value(watchlist));

        final watchlistMovies = watchlist.movies.map((id) => TestInstance.movieTeaser(id: id));
        when(mockMovieDatabase.getMovies(watchlist.movies))
            .thenAnswer((_) => Future.value([TestInstance.movie(id: 1)]));

        expect(
          movieManager.watchlistMovies,
          emitsInOrder([watchlistMovies]),
        );
      });
    });

    group('returnListOrThrow', () {
      test('when null, expect throw', () {
        expect(
          () => movieManager.returnListOrThrow(null),
          throwsArgumentError,
        );
      });

      test('when not null, expect list', () {
        final list = TestInstance.movieList();
        expect(
          movieManager.returnListOrThrow(list),
          list,
        );
      });
    });

    group('watchWatched', () {
      test('expect correct stream', () {
        final watched = TestInstance.movieList(
          type: ListType.watched,
        );
        final stream = Stream.value(watched).map<MovieList>((event) => event);
        when(mockListDatabase.watchList(id: watchedId)).thenAnswer((_) => stream);

        expect(
          movieManager.watchWatched,
          emitsInOrder([watched]),
        );
      });
    });

    group('watchWatchlist', () {
      test('expect correct stream', () {
        final watchlist = TestInstance.movieList(
          type: ListType.watched,
        );
        final stream = Stream.value(watchlist).map<MovieList>((event) => event);
        when(mockListDatabase.watchList(id: watchlistId)).thenAnswer((_) => stream);

        expect(
          movieManager.watchWatchlist,
          emitsInOrder([watchlist]),
        );
      });
    });

    group('addWatchedMovie', () {
      const movieId = 111;

      test('when movie added to watched, expect list database is updated', () async {
        await movieManager.addWatchedMovie(movieId);

        verify(mockListDatabase.addMovieToList(listId: watchedId, movieId: movieId));
        verify(mockListDatabase.removeMovieFromList(listId: watchlistId, movieId: movieId));
      });
    });

    group('removeWatchedMovie', () {
      test('when movie removed from watched, expect list database is updated', () async {
        const movieId = 111;

        await movieManager.removeWatchedMovie(movieId);

        verify(mockListDatabase.removeMovieFromList(listId: watchedId, movieId: movieId));
      });
    });

    group('addWatchlistMovie', () {
      test('when movie added to watchlist, expect list database is updated', () async {
        const movieId = 111;

        await movieManager.addWatchlistMovie(movieId);

        verify(mockListDatabase.addMovieToList(listId: watchlistId, movieId: movieId));
      });
    });

    group('removeWatchedMovie', () {
      test('when movie removed from watchlist, expect list database is updated', () async {
        const movieId = 111;

        await movieManager.removeWatchlistMovie(movieId);

        verify(mockListDatabase.removeMovieFromList(listId: watchlistId, movieId: movieId));
      });
    });
  });
}
