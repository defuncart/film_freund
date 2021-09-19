part of 'movie_database.dart';

@visibleForTesting
class GenreResponse {
  GenreResponse({
    required this.genres,
  });

  final Map<int, String> genres;

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    final rawValue = List<Map<String, dynamic>>.from(json['genres']);
    final genres = <int, String>{};
    for (final element in rawValue) {
      genres[element['id']] = element['name'];
    }

    return GenreResponse(genres: genres);
  }
}

@visibleForTesting
class PopularResponse {
  PopularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieListResult> results;
  final int totalPages;
  final int totalResults;

  factory PopularResponse.fromJson(Map<String, dynamic> json) => PopularResponse(
        page: json['page'],
        results: List<MovieListResult>.from(json['results'].map((x) => MovieListResult.fromJson(x))),
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );
}

@visibleForTesting
class MovieListResult {
  const MovieListResult({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieListResult.fromJson(Map<String, dynamic> json) => MovieListResult(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'].toDouble(),
        posterPath: json['poster_path'],
        releaseDate: DateTime.parse(json['release_date']),
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
      );
}
