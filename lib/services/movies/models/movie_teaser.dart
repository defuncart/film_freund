import 'package:film_freund/services/movies/models/base_movie.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:meta/meta.dart';

import 'movie.dart';

/// A model repesenting short information about a movie
///
/// For full movie info, see [Movie]
@immutable
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is MovieTeaser &&
        other.backdropPath == backdropPath &&
        listEquals(other.genres, genres) &&
        other.id == id &&
        other.originalLanguage == originalLanguage &&
        other.originalTitle == originalTitle &&
        other.overview == overview &&
        other.popularity == popularity &&
        other.posterPath == posterPath &&
        other.releaseDate == releaseDate &&
        other.title == title &&
        other.voteAverage == voteAverage &&
        other.voteCount == voteCount;
  }

  @override
  int get hashCode =>
      backdropPath.hashCode ^
      genres.hashCode ^
      id.hashCode ^
      originalLanguage.hashCode ^
      originalTitle.hashCode ^
      overview.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      releaseDate.hashCode ^
      title.hashCode ^
      voteAverage.hashCode ^
      voteCount.hashCode;
}
