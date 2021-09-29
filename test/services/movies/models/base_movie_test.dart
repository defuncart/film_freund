import 'package:film_freund/services/movies/models/base_movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$BaseMovie', () {
    group('hasEnoughVotes', () {
      test('When voteCount < 50, expect isFalse', () {
        final movie = _MyMovie(releaseDate: DateTime(1), voteCount: 20);
        expect(movie.hasEnoughVotes, isFalse);
      });

      test('When voteCount >= 50, expect isTrue', () {
        final movie = _MyMovie(releaseDate: DateTime(1), voteCount: 50);
        expect(movie.hasEnoughVotes, isTrue);
      });
    });
  });
}

class _MyMovie extends BaseMovie {
  const _MyMovie({
    required DateTime releaseDate,
    required int voteCount,
  }) : super(
          backdropPath: 'backdropPath',
          genres: const ['genres'],
          id: 1,
          originalLanguage: 'originalLanguage',
          originalTitle: 'originalTitle',
          overview: 'overview',
          popularity: 0,
          posterPath: 'posterPath',
          releaseDate: releaseDate,
          title: 'title',
          voteAverage: 50,
          voteCount: voteCount,
        );
}
