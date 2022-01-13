import 'package:film_freund/services/movies/models/base_movie.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:meta/meta.dart';

/// A model representing full information about a movie
@immutable
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Movie &&
        other.backdropPath == backdropPath &&
        other.budget == budget &&
        listEquals(other.genres, genres) &&
        other.homepage == homepage &&
        other.id == id &&
        other.originalLanguage == originalLanguage &&
        other.originalTitle == originalTitle &&
        other.overview == overview &&
        other.popularity == popularity &&
        other.posterPath == posterPath &&
        other.releaseDate == releaseDate &&
        other.revenue == revenue &&
        other.runtime == runtime &&
        other.tagline == tagline &&
        other.title == title &&
        other.voteAverage == voteAverage &&
        other.voteCount == voteCount;
  }

  @override
  int get hashCode =>
      backdropPath.hashCode ^
      budget.hashCode ^
      genres.hashCode ^
      homepage.hashCode ^
      id.hashCode ^
      originalLanguage.hashCode ^
      originalTitle.hashCode ^
      overview.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      releaseDate.hashCode ^
      revenue.hashCode ^
      runtime.hashCode ^
      tagline.hashCode ^
      title.hashCode ^
      voteAverage.hashCode ^
      voteCount.hashCode;
}
