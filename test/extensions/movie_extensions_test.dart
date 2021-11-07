import 'package:film_freund/extensions/movie_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  group('MovieExtensions', () {
    group('toMovieTeaser', () {
      final movie = TestInstance.movie();

      test('expect correct MovieTeaser', () {
        final movieTeaser = movie.toMovieTeaser();

        expect(movieTeaser.backdropPath, movie.backdropPath);
        expect(movieTeaser.genres, movie.genres);
        expect(movieTeaser.id, movie.id);
        expect(movieTeaser.originalLanguage, movie.originalLanguage);
        expect(movieTeaser.originalTitle, movie.originalTitle);
        expect(movieTeaser.overview, movie.overview);
        expect(movieTeaser.popularity, movie.popularity);
        expect(movieTeaser.posterPath, movie.posterPath);
        expect(movieTeaser.releaseDate, movie.releaseDate);
        expect(movieTeaser.title, movie.title);
        expect(movieTeaser.voteAverage, movie.voteAverage);
        expect(movieTeaser.voteCount, movie.voteCount);
      });
    });
  });

  group('ListMovieExtensions', () {
    group('toMovieTeasers', () {
      final movies = [
        TestInstance.movie(),
      ];

      test('expect correct MovieTeasers', () {
        final movieTeasers = movies.toMovieTeasers();

        expect(movieTeasers.length, movies.length);
      });
    });
  });
}
