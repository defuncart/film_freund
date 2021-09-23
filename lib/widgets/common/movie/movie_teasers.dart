import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/common/movie/movie_teaser_card.dart';
import 'package:flutter/material.dart';

class MovieTeasers extends StatelessWidget {
  const MovieTeasers({
    required this.movieTeasers,
    Key? key,
  }) : super(key: key);

  final List<MovieTeaser> movieTeasers;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final movieTeaser in movieTeasers)
              MovieTeaserCard(
                movieTeaser: movieTeaser,
              ),
          ],
        ),
      ],
    );
  }
}
