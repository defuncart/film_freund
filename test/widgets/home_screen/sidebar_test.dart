import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/common/user/user_avatar.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:film_freund/widgets/home_screen/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';

import '../../riverpod_provider_extension.dart';
import '../../test_utils.dart';

void main() {
  group('$Sidebar', () {
    testWidgets('Ensure correct contents', (tester) async {
      final widget = ProviderScope(
        overrides: [
          watchCurrentUserDisplayNameProvider.overrideWithValue(
            const AsyncValue.data('Max'),
          ),
        ],
        child: wrapWithMaterialAppLocalizationDelegates(
          Sidebar(
            onViewChanged: (_) {},
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(Material), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      for (final element in elements) {
        expect(find.byIcon(element.icon), findsOneWidget);
      }

      for (final element in elements) {
        expect(find.text(element.view.title), findsOneWidget);
      }
    }, skip: true);

    testWidgets('Ensure onViewChanged can be invoked', (tester) async {
      var activeView = ActiveView.popular;
      final widget = ProviderScope(
        overrides: [
          watchCurrentUserDisplayNameProvider.overrideWithValue(
            const AsyncValue.data('Max'),
          ),
        ],
        child: wrapWithMaterialAppLocalizationDelegates(
          Sidebar(
            onViewChanged: (newView) => activeView = newView,
          ),
        ),
      );

      await tester.pumpWidget(widget);

      await tester.pumpAndSettle();

      expect(activeView, ActiveView.popular);

      await tester.tap(
        find.text(AppLocalizations.current.activeViewSearchTitle),
      );

      expect(activeView, ActiveView.search);
    }, skip: true);

    group('$UserPanelConsumer', () {
      testWidgets('loading', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              watchCurrentUserDisplayNameProvider.overrideWithValue(
                const AsyncValue.loading(),
              ),
            ],
            child: wrapWithMaterialApp(const UserPanelConsumer()),
          ),
        );

        expect(find.byType(UserPanel), findsOneWidget);
        expect(
          tester.firstWidget<UserPanel>(find.byType(UserPanel)).displayName,
          'Film Freund',
        );
      });

      testWidgets('error', (tester) async {
        const error = 'error';

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              watchCurrentUserDisplayNameProvider.overrideWithValue(
                const AsyncValue.error(error, StackTrace.empty),
              ),
            ],
            child: wrapWithMaterialApp(const UserPanelConsumer()),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(Text), findsOneWidget);
        expect(find.text(error), findsOneWidget);
      });

      testWidgets('data', (tester) async {
        const displayName = 'displayName';

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              watchCurrentUserDisplayNameProvider.overrideWithValue(
                const AsyncValue.data(displayName),
              ),
            ],
            child: wrapWithMaterialApp(const UserPanelConsumer()),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(UserPanel), findsOneWidget);
        expect(
          tester.firstWidget<UserPanel>(find.byType(UserPanel)).displayName,
          displayName,
        );
      });
    }, skip: true);

    group('$UserPanel', () {
      const displayName = 'displayName';

      final widget = wrapWithMaterialApp(
        const UserPanel(
          displayName: displayName,
        ),
      );

      testWidgets('Ensure widget tree is correct', (tester) async {
        await tester.pumpWidget(widget);

        expect(find.byType(UserPanel), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(UserAvatar), findsOneWidget);
        expect(find.text(displayName[0].toUpperCase()), findsOneWidget);
        expect(find.byType(Gap), findsOneWidget);
        expect(find.text(displayName), findsOneWidget);
        expect(find.byType(Text), findsNWidgets(2));
      });
    }, skip: true);

    group('$UserPanel', () {
      testWidgets('Ensure widget tree is correct', (tester) async {
        const displayName = 'displayName';
        final widget = wrapWithMaterialApp(
          const UserPanel(
            displayName: displayName,
          ),
        );

        await tester.pumpWidget(widget);

        expect(find.byType(UserPanel), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
        expect(find.byType(UserAvatar), findsOneWidget);
        expect(find.text(displayName[0].toUpperCase()), findsOneWidget);
        expect(find.byType(Gap), findsOneWidget);
        expect(find.text(displayName), findsOneWidget);
        expect(find.byType(Text), findsNWidgets(2));
      });
    }, skip: true);
  });
}
