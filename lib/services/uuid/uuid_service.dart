import 'package:uuid/uuid.dart';

/// A service which generates uuids
class UUIDService {
  static const _uuid = Uuid();

  const UUIDService();

  /// Generates a RNG version 4 UUID
  String generate() => _uuid.v4();
}
