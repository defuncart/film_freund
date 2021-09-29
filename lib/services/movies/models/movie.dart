import 'package:film_freund/services/movies/models/base_movie.dart';

/// A model representing full information about a movie
class Movie extends BaseMovie {
  const Movie({
    required String? backdropPath,
    required this.budget,
    required List<String> genres,
    required this.homepage,
    required int id,
    required String originalLanguage,
    required String originalTitle,
    required String overview,
    required double popularity,
    required String posterPath,
    required DateTime releaseDate,
    required this.revenue,
    required this.runtime,
    required this.tagline,
    required String title,
    required int voteAverage,
    required int voteCount,
  }) : super(
          backdropPath: backdropPath,
          genres: genres,
          id: id,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          releaseDate: releaseDate,
          title: title,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  final int budget;
  final String? homepage;
  final int revenue;
  final int? runtime;
  final String? tagline;

  @override
  String toString() => '$Movie{id: $id, title: $title}';
}
