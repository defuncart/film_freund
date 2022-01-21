import 'dart:math';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = max(100.0, min(200.0, constraints.maxWidth / 4));

        return ListView(
          shrinkWrap: true,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                for (final movieTeaser in movieTeasers)
                  MovieTeaserCard(
                    movieTeaser: movieTeaser,
                    width: width,
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
