import 'package:film_freund/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MovieTeaserBottomSheet extends StatelessWidget {
  const MovieTeaserBottomSheet({
    required this.movieId,
    required this.movieTitle,
    required this.movieYear,
    Key? key,
  }) : super(key: key);

  final int movieId;
  final String movieTitle;
  final String movieYear;

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
                  icon: Icons.check,
                  label: AppLocalizations.of(context).activeViewWatchedTitle,
                  accentColor: Colors.green[700],
                  // TODO implement add/remove watched list logic
                  onPressed: () {},
                ),
                IconOptionButton(
                  icon: Icons.watch_later,
                  label: AppLocalizations.of(context).activeViewWatchlistTitle,
                  accentColor: Theme.of(context).colorScheme.secondary,
                  // TODO implement add/remove watchlist list logic
                  onPressed: () {},
                ),
              ],
            ),
            const Divider(),
            TextOptionButton(
              AppLocalizations.of(context).movieTeaserBottomSheetAddToListButtonText,
              // TODO navigate to list management
              onPressed: () {},
            ),
            TextOptionButton(
              AppLocalizations.of(context).movieTeaserBottomSheetShowMovieButtonText,
              // TODO navigate to MovieDetails
              onPressed: () {},
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
  final VoidCallback onPressed;

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
