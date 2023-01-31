import 'package:alchemist/alchemist.dart';
import 'package:film_freund/widgets/common/user/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$UserAvatar', () {
    group('initial', () {
      test('when initial is a single letter, expect no assertion', () {
        expect(
          () => const UserAvatar(initial: 'M'),
          returnsNormally,
        );
      });

      test('when initial is not a single letter, expect assertion', () {
        expect(
          () => UserAvatar(initial: 'Max'),
          throwsAssertionError,
        );
      });
    });

    const usersInitial = 'M';
    final widget = wrapWithMaterialApp(
      const UserAvatar(
        initial: usersInitial,
      ),
    );

    testWidgets('Expect correct widget tree', (tester) async {
      await tester.pumpWidget(widget);

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text(usersInitial), findsOneWidget);
    });

    goldenTest(
      'renders correctly',
      fileName: 'user_avatar',
      builder: () => GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'initial $usersInitial',
            child: const UserAvatar(
              initial: usersInitial,
            ),
          ),
        ],
      ),
    );
  }, skip: true);
}
