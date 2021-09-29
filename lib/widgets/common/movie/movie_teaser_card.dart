import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/common/movie/movie_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A card to tease a movie
///
/// [width] must be greater than 0. Height is automatically calculated as 1.5 * [width]
class MovieTeaserCard extends StatefulWidget {
  const MovieTeaserCard({
    required this.movieTeaser,
    required this.width,
    Key? key,
  })  : assert(width > 0),
        super(key: key);

  final MovieTeaser movieTeaser;
  final double width;

  @override
  State<MovieTeaserCard> createState() => _MovieTeaserCardState();
}

class _MovieTeaserCardState extends State<MovieTeaserCard> {
  late Image _image;
  var _isImageLoaded = false;

  @override
  void initState() {
    super.initState();

    _image = Image.network(widget.movieTeaser.posterPath);
    _image.image.resolve(const ImageConfiguration()).addListener(ImageStreamListener((_, __) {
      if (mounted) {
        setState(() => _isImageLoaded = true);
      }
    }));
  }

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
                    width: widget.width,
                    height: widget.width * 1.5,
                    child: _isImageLoaded
                        ? _image
                        : Container(
                            color: Colors.grey.withOpacity(0.25),
                          ),
                  ),
                ),
              ),
              if (_isImageLoaded)
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: MovieRating(
                    showRating: widget.movieTeaser.hasEnoughVotes,
                    rating: widget.movieTeaser.voteAverage,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
