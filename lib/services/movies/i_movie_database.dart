import 'package:film_freund/services/movies/models/movie.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';

/// A service which queries an external movie database
abstract class IMovieDatabase {
  /// Returns a movie for a given [id], else null
  Future<Movie?> getMovie(String id);

  /// Returns a list of movies for a given [ids]
  Future<List<Movie>> getMovies(List<String> ids);

  /// Returns a list of the 20 most popular movies for [region]
  Future<List<MovieTeaser>> getPopular({required String region});

  /// Returns a list of upcoming movies for [region]
  Future<List<MovieTeaser>> getUpcoming({required String region});
}
