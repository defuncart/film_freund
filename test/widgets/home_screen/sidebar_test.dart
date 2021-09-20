import 'package:film_freund/generated/l10n.dart';
import 'package:film_freund/widgets/home_screen/active_view.dart';
import 'package:film_freund/widgets/home_screen/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  testWidgets('Ensure correct contents', (tester) async {
    final widget = wrapWithMaterialAppLocalizationDelegates(
      Sidebar(
        onViewChanged: (_) {},
        onSignOut: () {},
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
  });

  testWidgets('Ensure onViewChanged can be invoked', (tester) async {
    var activeView = ActiveView.popular;
    final widget = wrapWithMaterialAppLocalizationDelegates(
      Sidebar(
        onViewChanged: (newView) => activeView = newView,
        onSignOut: () {},
      ),
    );

    await tester.pumpWidget(widget);

    await tester.pumpAndSettle();

    expect(activeView, ActiveView.popular);

    await tester.tap(
      find.text(AppLocalizations.current.activeViewSearchTitle),
    );

    expect(activeView, ActiveView.search);
  });

  // testWidgets('Ensure onSignOut can be invoked', (tester) async {
  //   var isPressed = false;
  //   final widget = wrapWithMaterialAppLocalizationDelegates(
  //     Sidebar(
  //       onViewChanged: (_) {},
  //       onSignOut: () => isPressed = true,
  //     ),
  //   );

  //   await tester.pumpWidget(widget);

  //   await tester.pumpAndSettle();

  //   expect(isPressed, isFalse);

  //   await tester.tap(
  //     find.text(AppLocalizations.current.sidebarSignOutButtonText),
  //   );

  //   expect(isPressed, isTrue);
  // });
}
