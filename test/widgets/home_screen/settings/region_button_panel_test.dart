import 'package:film_freund/services/local_settings/i_local_settings_database.dart';
import 'package:film_freund/services/local_settings/region.dart';
import 'package:film_freund/widgets/home_screen/settings/region_button_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../mocks.dart';
import '../../../test_service_locator.dart';
import '../../../test_utils.dart';

void main() {
  group('$RegionButtonPanel', () {
    late ILocalSettingsDatabase mockLocalSettings;

    setUp(() {
      mockLocalSettings = MockILocalSettingsDatabase();
      TestServiceLocator.register(localSettings: mockLocalSettings);

      when(mockLocalSettings.region).thenReturn(Region.de);
    });

    testWidgets('Expect widget tree is correct', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapWithMaterialApp(
          const RegionButtonPanel(),
        ));
        await tester.pumpAndSettle();

        expect(find.byType(RegionButtonPanel), findsOneWidget);
        // expect(find.byType(Row), findsOneWidget);
        expect(find.byType(RegionButton), findsNWidgets(Region.values.length));
        expect(find.byType(Gap), findsNWidgets(Region.values.length));
      });
    });
  });

  group('$RegionButton', () {
    final mockOnPressed = MockVoidCallback();

    testWidgets('Expect widget tree is correct', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapWithMaterialApp(
          RegionButton(
            imageUrl: '',
            onPressed: mockOnPressed,
            isSelected: true,
          ),
        ));

        expect(find.byType(RegionButton), findsOneWidget);
        expect(find.byType(GestureDetector), findsOneWidget);
        expect(find.byType(MouseRegion), findsNWidgets(2));
        expect(find.byType(ClipRRect), findsOneWidget);
        expect(find.byType(AnimatedOpacity), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
      });
    });

    testWidgets('Ensure callback can be invoked', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapWithMaterialApp(
          RegionButton(
            imageUrl: '',
            onPressed: mockOnPressed,
            isSelected: true,
          ),
        ));

        await tester.tap(find.byType(GestureDetector));

        verify(mockOnPressed.call());
      });
    });

    testWidgets('When isSelected = false, expect half opacity', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapWithMaterialApp(
          RegionButton(
            imageUrl: '',
            onPressed: mockOnPressed,
            isSelected: false,
          ),
        ));
        await tester.pumpAndSettle();

        final opacityWidget = tester.firstWidget<AnimatedOpacity>(find.byType(AnimatedOpacity));

        expect(opacityWidget.opacity, 0.5);
      });
    });

    testWidgets('When isSelected = true, expect full opacity', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(wrapWithMaterialApp(
          RegionButton(
            imageUrl: '',
            onPressed: mockOnPressed,
            isSelected: true,
          ),
        ));
        await tester.pumpAndSettle();

        final opacityWidget = tester.firstWidget<AnimatedOpacity>(find.byType(AnimatedOpacity));

        expect(opacityWidget.opacity, 1.0);
      });
    });
  });

  group('RegionImageExtensions', () {
    test('imageUrl', () {
      expect(
        Region.de.imageUrl,
        'https://raw.githubusercontent.com/swantzter/square-flags/master/png/1x1/256/de.png',
      );
      expect(
        Region.pl.imageUrl,
        'https://raw.githubusercontent.com/swantzter/square-flags/master/png/1x1/256/pl.png',
      );
      expect(
        Region.gb.imageUrl,
        'https://raw.githubusercontent.com/swantzter/square-flags/master/png/1x1/256/gb.png',
      );
      expect(
        Region.us.imageUrl,
        'https://raw.githubusercontent.com/swantzter/square-flags/master/png/1x1/256/us.png',
      );
    });
  });
}
