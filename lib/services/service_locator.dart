import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ServiceLocator {
  static late Reader _read;

  static void initialize(Reader read) => _read = read;

  //TODO Remove, presently for testing
  static ITestService get testService => _read(testServiceProvider);
}

//TODO Remove, presently for testing
abstract class ITestService {
  int myMethod();
}

//TODO Remove, presently for testing
class TestService implements ITestService {
  @override
  int myMethod() => 1;
}

//TODO Remove, presently for testing
@visibleForTesting
final testServiceProvider = Provider<ITestService>(
  (_) => TestService(),
);
