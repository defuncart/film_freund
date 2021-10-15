import 'package:film_freund/managers/movies/movie_manager.dart';
import 'package:film_freund/managers/user/user_manager.dart';
import 'package:film_freund/services/lists/enums/list_type.dart';
import 'package:film_freund/services/lists/i_list_database.dart';
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
    const movieIds = [1, 2, 3];
    final movies = movieIds.map((id) => TestInstance.movie(id: id)).toList();

    const watchedId = 'watchedId';
    const watchlistId = 'watchlistId';
    final user = TestInstance.user(
      watchedId: watchedId,
      watchlistId: watchlistId,
    );

    late IMovieDatabase mockMovieDatabase;
    late ILocalSettingsDatabase mockLocalSettings;
    late IListDatabase mockListDatabase;
    late UserManager mockUserManager;
    late MovieManager movieManager;

    setUp(() {
      mockMovieDatabase = MockIMovieDatabase();
      mockLocalSettings = MockILocalSettingsDatabase();
      mockListDatabase = MockIListDatabase();
      mockUserManager = MockUserManager();
      movieManager = MovieManager(
        movieDatabase: mockMovieDatabase,
        localSettings: mockLocalSettings,
        listDatabase: mockListDatabase,
        userManager: mockUserManager,
      );

      when(mockUserManager.currentUser).thenAnswer((_) => Future.value(user));
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
      final list = TestInstance.movieList(
        id: watchedId,
        type: ListType.watched,
        movies: movieIds,
      );

      test('when list does not exist, expect error', () async {
        when(mockListDatabase.getList(id: watchedId)).thenAnswer((_) => Future.value(null));

        expect(
          () => movieManager.watchedMovies,
          throwsArgumentError,
        );
      });

      test('when list exists, expect movies', () async {
        when(mockListDatabase.getList(id: watchedId)).thenAnswer((_) => Future.value(list));
        when(mockMovieDatabase.getMovies(movieIds)).thenAnswer((_) => Future.value(movies));

        expect(
          await movieManager.watchedMovies,
          movies,
        );
      });
    });

    group('watchlistMovies', () {
      final list = TestInstance.movieList(
        id: watchlistId,
        type: ListType.watchlist,
        movies: movieIds,
      );

      test('when list does not exist, expect error', () async {
        when(mockListDatabase.getList(id: watchlistId)).thenAnswer((_) => Future.value(null));

        expect(
          () => movieManager.watchlistMovies,
          throwsArgumentError,
        );
      });

      test('when list exists, expect movies', () async {
        when(mockListDatabase.getList(id: watchlistId)).thenAnswer((_) => Future.value(list));
        when(mockMovieDatabase.getMovies(movieIds)).thenAnswer((_) => Future.value(movies));

        expect(
          await movieManager.watchlistMovies,
          movies,
        );
      });
    });
  });
}
