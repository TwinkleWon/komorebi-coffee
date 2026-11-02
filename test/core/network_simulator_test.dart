import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:komorebi_coffee/core/error/app_exception.dart';
import 'package:komorebi_coffee/core/network/network_simulator.dart';

void main() {
  NetworkSimulator build({bool online = true, double failureRate = 0}) =>
      NetworkSimulator(
        isOnline: () => online,
        failureRate: () => failureRate,
        minLatency: Duration.zero,
        maxLatency: Duration.zero,
        random: Random(1),
      );

  test('passes the result through when healthy', () async {
    expect(await build()(() => 42), 42);
  });

  test('throws NetworkException when offline', () {
    expect(
      build(online: false)(() => 42),
      throwsA(isA<NetworkException>()),
    );
  });

  test('always fails with a transient error at 100% failure rate', () async {
    final simulator = build(failureRate: 1);
    for (var i = 0; i < 20; i++) {
      await expectLater(
        simulator(() => 42),
        throwsA(
          isA<AppException>().having((e) => e.isTransient, 'isTransient', true),
        ),
      );
    }
  });

  test('a lost response may still have run the request', () async {
    final simulator = build(failureRate: 1);
    var executed = 0;
    for (var i = 0; i < 20; i++) {
      try {
        await simulator(() => executed++, mayLoseResponse: true);
      } on AppException {
        // Expected.
      }
    }
    expect(executed, greaterThan(0));
  });
}
