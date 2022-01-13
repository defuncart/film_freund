import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/widgets/common/movie/movie_teasers_async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A [ConsumerWidget] which takes a `AutoDisposeFutureProvider` [provider] of `List<MovieTeasers>` and displays appropriate state
class MovieTeasersConsumer extends ConsumerWidget {
  const MovieTeasersConsumer({
    required this.provider,
    Key? key,
  }) : super(key: key);

  final AutoDisposeFutureProvider<List<MovieTeaser>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(provider);

    return MovieTeasersAsyncValue(movies);
  }
}
