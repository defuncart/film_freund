import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  group('ActiveViewExtensions', () {
    testWidgets('', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialAppLocalizationDelegates(Container()),
      );

      expect(ActiveView.popular.title, AppLocalizations.current.activeViewPopularTitle);
      expect(ActiveView.upcoming.title, AppLocalizations.current.activeViewUpcomingTitle);
      expect(ActiveView.search.title, AppLocalizations.current.activeViewSearchTitle);
      expect(ActiveView.watched.title, AppLocalizations.current.activeViewWatchedTitle);
      expect(ActiveView.watchlist.title, AppLocalizations.current.activeViewWatchlistTitle);
      expect(ActiveView.lists.title, AppLocalizations.current.activeViewListsTitle);
      expect(ActiveView.settings.title, AppLocalizations.current.activeViewSettingsTitle);
    });
  });
}
