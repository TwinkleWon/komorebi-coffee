import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/network_simulator.dart';
import '../domain/point_transaction.dart';
import 'point_ledger.dart';

abstract interface class PointRepository {
  Future<PointSummary> fetchSummary();
}

final pointRepositoryProvider = Provider<PointRepository>(
  (ref) => MockPointRepository(
    simulator: ref.watch(networkSimulatorProvider),
    ledger: ref.watch(pointLedgerProvider),
  ),
);

class MockPointRepository implements PointRepository {
  MockPointRepository({
    required NetworkSimulator simulator,
    required PointLedger ledger,
  })  : _simulator = simulator,
        _ledger = ledger;

  final NetworkSimulator _simulator;
  final PointLedger _ledger;

  @override
  Future<PointSummary> fetchSummary() =>
      _simulator(() => PointSummary.fromTransactions(_ledger.all()));
}
