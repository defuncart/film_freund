import 'package:uuid/uuid.dart';

/// A service which generates uuids
class UUIDService {
  static const _uuid = Uuid();

  /// Generates a RNG version 4 UUID
  String generated() => _uuid.v4();
}
