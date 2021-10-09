import 'package:film_freund/managers/movies/movie_manager.dart';
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
    final movies = [
      TestInstance.movieTeaser(),
    ];

    late IMovieDatabase mockMovieDatabase;
    late ILocalSettingsDatabase mockLocalSettings;
    late MovieManager movieManager;

    setUp(() {
      mockMovieDatabase = MockIMovieDatabase();
      mockLocalSettings = MockILocalSettingsDatabase();
      movieManager = MovieManager(
        movieDatabase: mockMovieDatabase,
        localSettings: mockLocalSettings,
      );
    });

    test('getPopular', () async {
      when(mockLocalSettings.region).thenReturn(region);
      when(mockMovieDatabase.getPopular(region: region.countryCode)).thenAnswer((_) => Future.value(movies));

      expect(await movieManager.getPopular(), movies);
    });

    test('getUpcoming', () async {
      when(mockLocalSettings.region).thenReturn(region);
      when(mockMovieDatabase.getUpcoming(region: region.countryCode)).thenAnswer((_) => Future.value(movies));

      expect(await movieManager.getUpcoming(), movies);
    });
  });
}
