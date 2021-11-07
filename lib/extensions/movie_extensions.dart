import 'package:film_freund/services/movies/models/movie.dart';
import 'package:film_freund/services/movies/models/movie_teaser.dart';

extension ListMovieExtensions on List<Movie> {
  List<MovieTeaser> toMovieTeasers() => map(
        (movie) => movie.toMovieTeaser(),
      ).toList();
}

extension MovieExtensions on Movie {
  MovieTeaser toMovieTeaser() => MovieTeaser(
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
}
