import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Given `AyncValue` [value], displays appropriate state
///
/// If [noData] is given, it is displayed when there are no results
class MovieTeasersAsyncValue extends StatelessWidget {
  const MovieTeasersAsyncValue(
    this.value, {
    this.noData,
    Key? key,
  }) : super(key: key);

  final AsyncValue<List<MovieTeaser>> value;
  final Widget? noData;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, _) => Text(err.toString()),
      data: (movies) => movies.isEmpty
          ? noData ?? const SizedBox.shrink()
          : MovieTeasers(
              movieTeasers: movies,
            ),
    );
  }
}
