import 'dart:convert';
import 'dart:developer';

import 'package:film_freund/services/movies/configs/tmdb_config.dart';
import 'package:film_freund/services/movies/i_movie_database.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'movie_database.responses.dart';

class MovieDatabase implements IMovieDatabase {
  MovieDatabase({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const _baseUrl = 'https://api.themoviedb.org/3';
  static const _language = 'en-US';
  static const _region = 'de';

  late Map<int, String> _genres;

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
  Future<bool> initialize() async {
    await _determineGenres();

    return true;
  }

  Future<void> _determineGenres() async {
    final response = await _get('$_baseUrl/genre/movie/list?api_key=$apiKey&language=$_language');
    final parsedResponse = GenreResponse.fromJson(json.decode(response.body));
    _genres = parsedResponse.genres;
  }

  @override
  Future<List<MovieTeaser>> getPopular() async {
    final response = await _get('$_baseUrl/movie/popular?api_key=$apiKey&language=$_language&page=1&region=$_region');
    final parsedResponse = PopularResponse.fromJson(jsonDecode(response.body));
    final movieTeasers = parsedResponse.results
        .map(
          (result) => MovieTeaser(
            adult: result.adult,
            backdropPath: result.backdropPath != null ? 'https://image.tmdb.org/t/p/w500/${result.backdropPath}' : null,
            genres: result.genreIds.map((id) => _genres[id]!).toList(),
            id: result.id,
            originalLanguage: result.originalLanguage,
            originalTitle: result.originalTitle,
            overview: result.overview,
            popularity: result.popularity,
            posterPath: result.posterPath != null ? 'https://image.tmdb.org/t/p/w500/${result.posterPath}' : null,
            releaseDate: result.releaseDate,
            title: result.title,
            video: result.video,
            voteAverage: result.voteAverage,
            voteCount: result.voteCount,
          ),
        )
        .toList();

    return movieTeasers;
  }
}
