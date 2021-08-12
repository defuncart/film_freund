import 'package:film_freund/widgets/home_screen/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_utils.dart';

void main() {
  testWidgets('Ensure correct contents', (tester) async {
    final widget = wrapWithMaterialApp(const Sidebar());

    await tester.pumpWidget(widget);

    expect(find.byType(Material), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

    for (final element in elements) {
      expect(find.byIcon(element.icon), findsOneWidget);
    }

    for (final element in elements) {
      expect(find.text(element.title), findsOneWidget);
    }
  });
}
