import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/local_settings/region.dart';
import 'package:film_freund/services/movies/i_movie_database.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';

/// A manager which handles movie databsae requests and updating user's movie lists
class MovieManager {
  const MovieManager({
    required IMovieDatabase movieDatabase,
    required ILocalSettingsDatabase localSettings,
  })  : _movieDatabase = movieDatabase,
        _localSettings = localSettings;

  final IMovieDatabase _movieDatabase;
  final ILocalSettingsDatabase _localSettings;

  /// Returns a list of the 20 most popular movies
  Future<List<MovieTeaser>> getPopular() => _movieDatabase.getPopular(
        region: _localSettings.region.countryCode,
      );

  /// Returns a list of upcoming movies
  Future<List<MovieTeaser>> getUpcoming() => _movieDatabase.getUpcoming(
        region: _localSettings.region.countryCode,
      );
}
