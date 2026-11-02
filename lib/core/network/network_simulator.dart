import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dev/dev_settings.dart';
import '../error/app_exception.dart';
import 'connectivity.dart';

final networkSimulatorProvider = Provider<NetworkSimulator>((ref) {
  return NetworkSimulator(
    isOnline: () => ref.read(isOnlineProvider),
    failureRate: () => ref.read(devSettingsProvider).failureRate,
  );
});

/// Makes mock repositories behave like a real HTTP client: random latency,
/// offline detection and injected failures.
class NetworkSimulator {
  NetworkSimulator({
    required bool Function() isOnline,
    required double Function() failureRate,
    this.minLatency = const Duration(milliseconds: 350),
    this.maxLatency = const Duration(milliseconds: 1100),
    Random? random,
  })  : _isOnline = isOnline,
        _failureRate = failureRate,
        _random = random ?? Random();

  /// A simulator with no latency and no failures, for tests.
  factory NetworkSimulator.instant() => NetworkSimulator(
        isOnline: () => true,
        failureRate: () => 0,
        minLatency: Duration.zero,
        maxLatency: Duration.zero,
      );

  final bool Function() _isOnline;
  final double Function() _failureRate;
  final Duration minLatency;
  final Duration maxLatency;
  final Random _random;

  /// Runs [request] as if it were a network call.
  ///
  /// When [mayLoseResponse] is `true`, an injected failure can also happen
  /// *after* the request was processed (the response is lost on the way
  /// back). This is what makes idempotency keys necessary for orders.
  Future<T> call<T>(
    FutureOr<T> Function() request, {
    bool mayLoseResponse = false,
  }) async {
    await Future<void>.delayed(_latency());
    if (!_isOnline()) throw const NetworkException();

    final rate = _failureRate();
    if (rate > 0 && _random.nextDouble() < rate) {
      final failure = _random.nextBool()
          ? const RequestTimeoutException()
          : const ServerException(503);
      if (mayLoseResponse && _random.nextBool()) {
        await request();
      }
      throw failure;
    }
    return request();
  }

  Duration _latency() {
    final span = maxLatency.inMilliseconds - minLatency.inMilliseconds;
    if (span <= 0) return minLatency;
    return minLatency + Duration(milliseconds: _random.nextInt(span));
  }
}
