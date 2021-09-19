import 'package:film_freund/services/movies/models/movie.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';

/// A service which queries an external movie database
abstract class IMovieDatabase {
  /// Returns a list of the 20 most popular movies for DE
  Future<List<MovieTeaser>> getPopular();

  /// Returns a movie for a given [id], else null
  Future<Movie?> getMovie(String id);
}
