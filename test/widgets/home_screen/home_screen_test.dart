import 'dart:ui' show Size;

import 'package:film_freund/services/movies/models/movie_teaser.dart';
import 'package:film_freund/state/current_user_provider.dart';
import 'package:film_freund/utils/sizes.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:film_freund/widgets/home_screen/home_screen.dart';
import 'package:film_freund/widgets/home_screen/popular/popular_view.dart';
import 'package:film_freund/widgets/home_screen/popular/upcoming_view.dart';
import 'package:film_freund/widgets/home_screen/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../riverpod_overrides.dart';
import '../../test_utils.dart';

void main() {
  group('$HomeScreen', () {
    testWidgets('On small screen, expect detail', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(
        singlePageBreakpoint - 1,
        singlePageBreakpoint - 1,
      );
      tester.binding.window.devicePixelRatioTestValue = 1;

      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });

      final widget = popularProvider(
        wrapWithMaterialAppLocalizationDelegates(
          const HomeScreen(),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      expect(find.byType(HomeScreenDetail), findsOneWidget);
      expect(find.byType(HomeScreenMasterDetail), findsNothing);
    });

    testWidgets('On large screen, expect master detail', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(
        singlePageBreakpoint,
        singlePageBreakpoint,
      );
      tester.binding.window.devicePixelRatioTestValue = 1;

      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });

      final widget = popularProvider(
        wrapWithMaterialAppLocalizationDelegates(
          const HomeScreen(),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      expect(find.byType(HomeScreenDetail), findsNothing);
      expect(find.byType(HomeScreenMasterDetail), findsOneWidget);
    });
  });

  group('$HomeScreenContent', () {
    testWidgets('When ${ActiveView.popular}, expect $PopularView', (tester) async {
      final widget = popularProvider(
        wrapWithMaterialAppLocalizationDelegates(
          const HomeScreenContent(
            activeView: ActiveView.popular,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreenContent), findsOneWidget);
      expect(find.byType(PopularView), findsOneWidget);
    });

    testWidgets('When ${ActiveView.upcoming}, expect $UpcomingView', (tester) async {
      final widget = ProviderScope(
        overrides: [
          upcomingMoviesProvider.overrideWithValue(
            const AsyncValue.data(<MovieTeaser>[]),
          ),
        ],
        child: wrapWithMaterialAppLocalizationDelegates(
          const HomeScreenContent(
            activeView: ActiveView.upcoming,
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreenContent), findsOneWidget);
      expect(find.byType(UpcomingView), findsOneWidget);
    });

    testWidgets('When ${ActiveView.search}, expect $ActiveViewPlaceholder', (tester) async {
      final widget = wrapWithMaterialAppLocalizationDelegates(
        const HomeScreenContent(
          activeView: ActiveView.search,
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreenContent), findsOneWidget);
      expect(find.byType(ActiveViewPlaceholder), findsOneWidget);
    });

    testWidgets('When ${ActiveView.watched}, expect $ActiveViewPlaceholder', (tester) async {
      final widget = wrapWithMaterialAppLocalizationDelegates(
        const HomeScreenContent(
          activeView: ActiveView.watched,
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreenContent), findsOneWidget);
      expect(find.byType(ActiveViewPlaceholder), findsOneWidget);
    });

    testWidgets('When ${ActiveView.watchlist}, expect $ActiveViewPlaceholder', (tester) async {
      final widget = wrapWithMaterialAppLocalizationDelegates(
        const HomeScreenContent(
          activeView: ActiveView.watchlist,
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreenContent), findsOneWidget);
      expect(find.byType(ActiveViewPlaceholder), findsOneWidget);
    });

    testWidgets('When ${ActiveView.lists}, expect $ActiveViewPlaceholder', (tester) async {
      final widget = wrapWithMaterialAppLocalizationDelegates(
        const HomeScreenContent(
          activeView: ActiveView.lists,
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreenContent), findsOneWidget);
      expect(find.byType(ActiveViewPlaceholder), findsOneWidget);
    });

    testWidgets('When ${ActiveView.settings}, expect $SettingsView', (tester) async {
      final widget = ProviderScope(
        overrides: [
          currentUserProvider.overrideWithValue(
            AsyncValue.data(TestInstance.user()),
          ),
        ],
        child: wrapWithMaterialAppLocalizationDelegates(
          const Scaffold(
            body: HomeScreenContent(
              activeView: ActiveView.settings,
            ),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreenContent), findsOneWidget);
      expect(find.byType(SettingsView), findsOneWidget);
    });
  });
}
