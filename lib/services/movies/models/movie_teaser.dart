import 'movie.dart';

/// A model repesenting short information about a movie
///
/// For full movie info, see [Movie]
class MovieTeaser {
  const MovieTeaser({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<String> genres;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime releaseDate;
  final String title;
  final int voteAverage;
  final int voteCount;

  @override
  String toString() => '$MovieTeaser{id: $id, title: $title}';
}
