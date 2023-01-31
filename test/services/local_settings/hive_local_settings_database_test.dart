import 'dart:io';

import 'package:film_freund/services/local_settings/hive_local_settings_database.dart';
import 'package:film_freund/services/local_settings/region.dart';
import 'package:film_freund/services/platform/i_platform_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../mocks.dart';

void main() {
  group('$HiveLocalSettingsDatabase', () {
    late PathProviderPlatform mockPathProvider;
    late HiveLocalSettingsDatabase hiveLocalSettings;
    late IPlatformService mockPlatformService;

    setUp(() {
      mockPathProvider = MockPathProviderPlatform();
      mockPlatformService = MockIPlatformService();
    });

    group('initialize', () {
      late HiveInterface mockHiveInterface;

      setUp(() {
        mockHiveInterface = MockHiveInterface();
        hiveLocalSettings = HiveLocalSettingsDatabase(
          platformService: mockPlatformService,
          hive: mockHiveInterface,
        );

        when(mockHiveInterface.openBox(HiveLocalSettingsDatabase.boxName)).thenAnswer((_) => Future.value(MockBox()));
      });

      test('when not web, expect correctly initialized', () async {
        final dir = (await mockPathProvider.getApplicationDocumentsPath())!;

        MethodChannelMocks.setupPathProvider(mockPathProvider);

        when(mockPlatformService.isRunningOnWeb).thenReturn(false);

        await hiveLocalSettings.initialize();

        verify(mockHiveInterface.init(dir));
      });

      test('when web, expect correctly initialized', () async {
        final dir = (await mockPathProvider.getApplicationDocumentsPath())!;

        when(mockPlatformService.isRunningOnWeb).thenReturn(true);

        await hiveLocalSettings.initialize();

        verifyNever(mockHiveInterface.init(dir));
      });
    });

    test('Ensure hive works as expected', () async {
      hiveLocalSettings = HiveLocalSettingsDatabase(
        platformService: mockPlatformService,
      );

      MethodChannelMocks.setupPathProvider(mockPathProvider);

      when(mockPlatformService.isRunningOnWeb).thenReturn(false);

      await hiveLocalSettings.initialize();

      expect(hiveLocalSettings.region, Defaults.region.asRegion);

      hiveLocalSettings.region = Region.pl;

      expect(hiveLocalSettings.region, Region.pl);

      await hiveLocalSettings.reset();

      expect(hiveLocalSettings.region, Defaults.region.asRegion);

      // delete files
      final applicationDocumentsDirectory = await mockPathProvider.getApplicationDocumentsPath();
      final dir = Directory(applicationDocumentsDirectory!);
      await dir.delete(recursive: true);
    });
  });

  group('IntExtensions', () {
    group('asRegion', () {
      test('when index is invalid, expect assert', () {
        expect(
          () => (-1).asRegion,
          throwsAssertionError,
        );
        expect(
          () => 100.asRegion,
          throwsAssertionError,
        );
      });

      test('when index is valid, expect correct value', () {
        for (var i = 0; i < Region.values.length; i++) {
          expect(i.asRegion, Region.values[i]);
        }
      });
    });
  });
}
