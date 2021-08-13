import 'dart:ui' show Size;

import 'package:film_freund/utils/sizes.dart';
import 'package:film_freund/widgets/home_screen/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
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

    final widget = wrapWithMaterialAppLocalizationDelegates(
      const HomeScreen(),
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

    final widget = wrapWithMaterialAppLocalizationDelegates(
      const HomeScreen(),
    );

    await tester.pumpWidget(widget);

    await tester.pumpAndSettle();

    expect(find.byType(HomeScreenDetail), findsNothing);
    expect(find.byType(HomeScreenMasterDetail), findsOneWidget);
  });
}
