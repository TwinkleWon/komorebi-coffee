import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_assets.dart';
import '../../../core/network/network_simulator.dart';
import '../../../core/time/clock.dart';
import '../domain/cafe_store.dart';

abstract interface class StoreRepository {
  Future<List<CafeStore>> fetchStores();
}

final storeRepositoryProvider = Provider<StoreRepository>(
  (ref) => MockStoreRepository(
    assets: ref.watch(mockAssetsProvider),
    simulator: ref.watch(networkSimulatorProvider),
    clock: ref.watch(clockProvider),
  ),
);

class MockStoreRepository implements StoreRepository {
  MockStoreRepository({
    required MockAssets assets,
    required NetworkSimulator simulator,
    required Clock clock,
  })  : _assets = assets,
        _simulator = simulator,
        _clock = clock;

  final MockAssets _assets;
  final NetworkSimulator _simulator;
  final Clock _clock;

  @override
  Future<List<CafeStore>> fetchStores() => _simulator(loadWithoutNetwork);

  /// Direct fixture access for other mock "server" components (e.g. order
  /// validation), which would query the database rather than the API.
  Future<List<CafeStore>> loadWithoutNetwork() async {
    final rows = await _assets.list('stores');
    final now = _clock();
    return [
      for (final (index, row) in rows.indexed)
        _withCongestion(CafeStore.fromJson(row), index, now),
    ];
  }

  CafeStore _withCongestion(CafeStore store, int seed, DateTime now) {
    if (!store.isOpenAt(now)) return store.copyWith(congestion: null);
    return store.copyWith(congestion: estimateCongestion(now, seed));
  }
}

/// Fake but plausible crowd levels: busy at the morning commute, lunch and
/// mid-afternoon, varied per store.
Congestion estimateCongestion(DateTime now, int seed) {
  const peaks = {8: 2, 12: 2, 13: 1, 15: 1, 18: 1};
  final base = peaks[now.hour] ?? 0;
  final jitter = (seed + now.hour) % 3 == 0 ? 1 : 0;
  final level = (base + jitter).clamp(0, 2);
  return Congestion.values[level];
}
