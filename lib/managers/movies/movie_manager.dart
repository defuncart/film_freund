import 'package:film_freund/services/movies/i_movie_database.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';

/// A manager which handles movie databsae requests and updating user's movie lists
class MovieManager {
  const MovieManager({
    required IMovieDatabase movieDatabase,
  }) : _movieDatabase = movieDatabase;

  final IMovieDatabase _movieDatabase;

  /// Returns a list of the 20 most popular movies
  Future<List<MovieTeaser>> getPopular() => _movieDatabase.getPopular(region: 'de');

  /// Returns a list of upcoming movies
  Future<List<MovieTeaser>> getUpcoming() => _movieDatabase.getUpcoming(region: 'de');
}
