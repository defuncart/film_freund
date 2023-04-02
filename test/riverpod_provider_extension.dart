import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: A temp solution until `overrideWithValue` is re-introduced for all providers

extension Temp1 on FutureProvider {
  Override overrideWithValue<T>(T value) => overrideWithProvider(FutureProvider((_) async => value));
}

extension Temp2 on AutoDisposeFutureProvider {
  Override overrideWithValue<T>(T value) => overrideWithProvider(FutureProvider.autoDispose((_) async => value));
}

extension Temp3 on AutoDisposeStreamProvider {
  Override overrideWithValue<T>(T value) =>
      overrideWithProvider(StreamProvider.autoDispose((_) => Stream.value(value)));
}

extension Temp4 on StreamProvider {
  Override overrideWithValue<T>(T value) => overrideWithProvider(StreamProvider((_) => Stream.value(value)));
}