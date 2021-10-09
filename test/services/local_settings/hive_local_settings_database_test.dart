import 'package:film_freund/services/local_settings/hive_local_settings_database.dart';
import 'package:film_freund/services/platform/i_platform_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
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
  });
}
