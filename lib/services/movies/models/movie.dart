/// A model representing full information about a movie
class Movie {
  const Movie({
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final int budget;
  final List<String> genres;
  final String? homepage;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final DateTime releaseDate;
  final int revenue;
  final int? runtime;
  final String? tagline;
  final String title;
  final double voteAverage;
  final int voteCount;

  @override
  String toString() => '$Movie{id: $id, title: $title}';
}
