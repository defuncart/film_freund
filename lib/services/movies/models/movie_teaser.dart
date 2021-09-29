import 'package:film_freund/services/movies/models/base_movie.dart';

import 'movie.dart';

/// A model repesenting short information about a movie
///
/// For full movie info, see [Movie]
class MovieTeaser extends BaseMovie {
  const MovieTeaser({
    required String? backdropPath,
    required List<String> genres,
    required int id,
    required String originalLanguage,
    required String originalTitle,
    required String overview,
    required double popularity,
    required String posterPath,
    required DateTime releaseDate,
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

  @override
  String toString() => '$MovieTeaser{id: $id, title: $title}';
}
