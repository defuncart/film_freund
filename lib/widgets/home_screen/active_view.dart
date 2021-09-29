import 'package:film_freund/generated/l10n.dart';

enum ActiveView {
  popular,
  upcoming,
  search,
  watched,
  watchlist,
  lists,
  settings,
}

extension ActiveViewExtensions on ActiveView {
  String get title {
    switch (this) {
      case ActiveView.popular:
        return AppLocalizations.current.activeViewPopularTitle;
      case ActiveView.upcoming:
        return AppLocalizations.current.activeViewUpcomingTitle;
      case ActiveView.search:
        return AppLocalizations.current.activeViewSearchTitle;
      case ActiveView.watched:
        return AppLocalizations.current.activeViewWatchedTitle;
      case ActiveView.watchlist:
        return AppLocalizations.current.activeViewWatchlistTitle;
      case ActiveView.lists:
        return AppLocalizations.current.activeViewListsTitle;
      case ActiveView.settings:
        return AppLocalizations.current.activeViewSettingsTitle;
    }
  }
}
