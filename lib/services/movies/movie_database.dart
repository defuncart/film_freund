import 'dart:convert' show jsonDecode;
import 'dart:developer' show log;

import 'package:film_freund/services/movies/i_movie_database.dart';
import 'package:film_freund/services/movies/models/movie.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'movie_database.responses.dart';
part 'movie_database.secrets.dart';

class MovieDatabase implements IMovieDatabase {
  MovieDatabase({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const _language = 'en-US';

  /// TODO if multi-language, then retrieve using
  /// $_baseUrl/genre/movie/list?api_key=$apiKey&language=$_language
  static const _genres = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };

  Future<http.Response> _get(String url) async {
    log('get\n$url');
    final uri = Uri.parse(url);
    try {
      return _httpClient.get(uri);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Movie?> getMovie(String id) async {
    final response = await _get('$_baseUrl/movie/$id?api_key=$apiKey&language=$_language');
    if (response.statusCode == 200) {
      final parsedResponse = MovieResponse.fromJson(jsonDecode(response.body));
      return Movie(
        backdropPath: _composeImagePath(parsedResponse.backdropPath),
        budget: parsedResponse.budget,
        genres: parsedResponse.genres.map((g) => g.name).toList(),
        homepage: parsedResponse.homepage,
        id: parsedResponse.id,
        originalLanguage: parsedResponse.originalLanguage,
        originalTitle: parsedResponse.originalTitle,
        overview: parsedResponse.overview ?? '',
        popularity: parsedResponse.popularity,
        posterPath: _composeImagePath(parsedResponse.posterPath!)!,
        releaseDate: parsedResponse.releaseDate,
        revenue: parsedResponse.revenue,
        runtime: parsedResponse.runtime,
        tagline: parsedResponse.tagline,
        title: parsedResponse.title,
        voteAverage: _convertVoteAverage(parsedResponse.voteAverage),
        voteCount: parsedResponse.voteCount,
      );
    }

    return null;
  }

  @override
  Future<List<Movie>> getMovies(List<String> ids) async {
    assert(ids.isNotEmpty, 'No ids supplied');

    final movies = <Movie>[];
    for (final id in ids) {
      final movie = await getMovie(id);

      if (movie != null) {
        movies.add(movie);
      } else {
        log('No movie found for $id');
      }
    }

    return movies;
  }

  @override
  Future<List<MovieTeaser>> getPopular({required String region}) async {
    final response = await _get('$_baseUrl/movie/popular?api_key=$apiKey&language=$_language&page=1&region=$region');
    final parsedResponse = PopularResponse.fromJson(jsonDecode(response.body));
    final movieTeasers = parsedResponse.results
        .where((result) => result.posterPath != null)
        .map((result) => _movieListResultToMovieTeaser(result))
        .toList();

    return movieTeasers;
  }

  @override
  Future<List<MovieTeaser>> getUpcoming({required String region}) async {
    final response = await _get('$_baseUrl/movie/upcoming?api_key=$apiKey&language=$_language&page=1&region=$region');
    final parsedResponse = UpcomingResponse.fromJson(jsonDecode(response.body));
    final movieTeasers = parsedResponse.results
        .where((result) => result.posterPath != null)
        .map((result) => _movieListResultToMovieTeaser(result))
        .toList();

    return movieTeasers;
  }

  /// Returns a full image path for a given relative [path]
  String? _composeImagePath(String? path) => path != null ? 'https://image.tmdb.org/t/p/w500/$path' : null;

  /// Returns [voteAverage] as percentage, i.e. 6.8 => 68
  int _convertVoteAverage(double voteAverage) => (voteAverage * 10).floor();

  /// Maps a [MovieListResult] to a [MovieTeaser]
  MovieTeaser _movieListResultToMovieTeaser(MovieListResult result) => MovieTeaser(
        backdropPath: _composeImagePath(result.backdropPath),
        genres: result.genreIds.map((id) => _genres[id]!).toList(),
        id: result.id,
        originalLanguage: result.originalLanguage,
        originalTitle: result.originalTitle,
        overview: result.overview,
        popularity: result.popularity,
        posterPath: _composeImagePath(result.posterPath!)!,
        releaseDate: result.releaseDate,
        title: result.title,
        voteAverage: _convertVoteAverage(result.voteAverage),
        voteCount: result.voteCount,
      );
}
