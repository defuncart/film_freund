import 'package:film_freund/services/local_settings/hive_local_settings_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../mocks.dart';

void main() {
  group('$HiveLocalSettingsDatabase', () {
    late PathProviderPlatform mockPathProvider;
    late HiveLocalSettingsDatabase hiveLocalSettings;

    setUp(() {
      mockPathProvider = MockPathProviderPlatform();
      MethodChannelMocks.setupPathProvider(mockPathProvider);
    });

    group('initialize', () {
      late HiveInterface mockHiveInterface;

      setUp(() {
        mockHiveInterface = MockHiveInterface();
        hiveLocalSettings = HiveLocalSettingsDatabase(
          hive: mockHiveInterface,
        );
      });

      test('when not web, expect getApplicationDocumentsDirectory', () async {
        const dir = 'dir';

        when(mockPathProvider.getApplicationDocumentsPath()).thenAnswer((_) => Future.value(dir));

        await hiveLocalSettings.initialize();

        verify(mockHiveInterface.init(dir));
      }, skip: true);
    });
  });
}
