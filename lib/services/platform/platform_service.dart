import 'package:film_freund/services/platform/i_platform_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformService implements IPlatformService {
  @override
  bool get isRunningOnWeb => kIsWeb;
}
