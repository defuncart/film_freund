import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/state/movie_watch_status_provider.dart';
import 'package:film_freund/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

/// Displays [MovieTeaserBottomSheet] from a Provider
class MovieTeaserBottomSheetConsumer extends ConsumerWidget {
  const MovieTeaserBottomSheetConsumer({
    required this.movieId,
    required this.movieTitle,
    required this.movieYear,
    Key? key,
  }) : super(key: key);

  final int movieId;
  final String movieTitle;
  final String movieYear;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieWatchStatus = ref.watch(movieWatchStatusProvider(movieId));

    return movieWatchStatus.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, _) => Text(err.toString()),
      data: (movieWatchStatus) => MovieTeaserBottomSheet(
        movieId: movieId,
        movieTitle: movieTitle,
        movieYear: movieYear,
        isWatched: movieWatchStatus.isWatched,
        isWatchlist: movieWatchStatus.isWatchlist,
        onAddWatchedMovie: ref.read(movieManagerProvider).addWatchedMovie,
        onRemoveWatchedMovie: ref.read(movieManagerProvider).removeWatchedMovie,
        onAddWatchlistMovie: ref.read(movieManagerProvider).addWatchlistMovie,
        onRemoveWatchlistMovie: ref.read(movieManagerProvider).removeWatchlistMovie,
      ),
    );
  }
}

/// A bottom sheet with list operations for a movie
@visibleForTesting
class MovieTeaserBottomSheet extends StatelessWidget {
  const MovieTeaserBottomSheet({
    required this.movieId,
    required this.movieTitle,
    required this.movieYear,
    required this.isWatched,
    required this.isWatchlist,
    required this.onAddWatchedMovie,
    required this.onRemoveWatchedMovie,
    required this.onAddWatchlistMovie,
    required this.onRemoveWatchlistMovie,
    Key? key,
  }) : super(key: key);

  final int movieId;
  final String movieTitle;
  final String movieYear;
  final bool isWatched;
  final bool isWatchlist;
  final void Function(int) onAddWatchedMovie;
  final void Function(int) onRemoveWatchedMovie;
  final void Function(int) onAddWatchlistMovie;
  final void Function(int) onRemoveWatchlistMovie;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movieTitle,
              style: Theme.of(context).textTheme.headline6,
            ),
            const Gap(4),
            Text(
              movieYear,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconOptionButton(
                  icon: isWatched ? Icons.check_circle : Icons.check_circle_outline,
                  label: AppLocalizations.of(context).activeViewWatchedTitle,
                  accentColor: isWatched ? Colors.green[700] : Colors.grey,
                  onPressed: isWatched ? () => onRemoveWatchedMovie(movieId) : () => onAddWatchedMovie(movieId),
                ),
                IconOptionButton(
                  icon: isWatchlist ? Icons.watch_later : Icons.watch_later_outlined,
                  label: AppLocalizations.of(context).activeViewWatchlistTitle,
                  accentColor: isWatchlist ? Theme.of(context).colorScheme.secondary : Colors.grey,
                  onPressed: isWatchlist ? () => onRemoveWatchlistMovie(movieId) : () => onAddWatchlistMovie(movieId),
                ),
              ],
            ),
            const Divider(),
            TextOptionButton(
              AppLocalizations.of(context).movieTeaserBottomSheetAddToListButtonText,
              // TODO navigate to list management
              onPressed: null,
            ),
            TextOptionButton(
              AppLocalizations.of(context).movieTeaserBottomSheetShowMovieButtonText,
              // TODO navigate to MovieDetails
              onPressed: null,
            ),
          ],
        ),
      );
}

@visibleForTesting
class IconOptionButton extends StatelessWidget {
  const IconOptionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.accentColor,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const CircleBorder(),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Icon(
              icon,
              color: accentColor,
            ),
            Text(
              label,
              style: TextStyle(
                color: accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@visibleForTesting
class TextOptionButton extends StatelessWidget {
  const TextOptionButton(
    this.text, {
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.zero,
        ),
      ),
    );
  }
}
