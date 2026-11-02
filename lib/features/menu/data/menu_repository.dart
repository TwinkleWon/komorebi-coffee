import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_assets.dart';
import '../../../core/network/network_simulator.dart';
import '../domain/menu_item.dart';

abstract interface class MenuRepository {
  Future<List<MenuItem>> fetchMenu();
}

final menuRepositoryProvider = Provider<MenuRepository>(
  (ref) => MockMenuRepository(
    assets: ref.watch(mockAssetsProvider),
    simulator: ref.watch(networkSimulatorProvider),
  ),
);

class MockMenuRepository implements MenuRepository {
  MockMenuRepository({
    required MockAssets assets,
    required NetworkSimulator simulator,
  })  : _assets = assets,
        _simulator = simulator;

  final MockAssets _assets;
  final NetworkSimulator _simulator;

  @override
  Future<List<MenuItem>> fetchMenu() => _simulator(() async {
        final rows = await _assets.list('menu');
        return rows.map(MenuItem.fromJson).toList();
      });
}
