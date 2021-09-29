import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/common/movie/movie_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A card to tease a movie
///
/// [width] must be greater than 0. Height is automatically calculated as 1.5 * [width]
class MovieTeaserCard extends StatelessWidget {
  const MovieTeaserCard({
    required this.movieTeaser,
    required this.width,
    Key? key,
  })  : assert(width > 0),
        super(key: key);

  final MovieTeaser movieTeaser;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO: open movie details
      onTap: () {},
      // TODO: Desktop open options menu
      onSecondaryTap: () {},
      // TODO: Mobile open options menu
      onLongPress: () {},
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: SizedBox(
                    width: width,
                    height: width * 1.5,
                    child: Image.network(
                      // TODO display loading and error states
                      movieTeaser.posterPath ?? '',
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: MovieRating(
                  percentage: movieTeaser.voteAverage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
