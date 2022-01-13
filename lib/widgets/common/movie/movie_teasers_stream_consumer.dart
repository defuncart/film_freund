import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A [ConsumerWidget] which takes a `AutoDisposeStreamProvider` [provider] of `List<MovieTeasers>` and displays appropriate state
class MovieTeasersStreamConsumer extends ConsumerWidget {
  const MovieTeasersStreamConsumer({
    required this.provider,
    Key? key,
  }) : super(key: key);

  final AutoDisposeStreamProvider<List<MovieTeaser>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(provider);

    return MovieTeasersAsyncValue(movies);
  }
}
