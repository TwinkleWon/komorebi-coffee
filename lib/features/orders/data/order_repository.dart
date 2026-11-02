import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_assets.dart';
import '../../../core/network/network_simulator.dart';
import '../../../core/storage/local_store.dart';
import '../../../core/time/clock.dart';
import '../../points/data/point_ledger.dart';
import '../../stores/data/store_repository.dart';
import '../domain/order.dart';
import 'mock_order_repository.dart';

abstract interface class OrderRepository {
  Future<List<Order>> fetchOrders();

  /// Places an order. Retrying with the same idempotency key returns the
  /// original order instead of creating a new one.
  Future<Order> placeOrder(OrderRequest request);
}

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final simulator = ref.watch(networkSimulatorProvider);
  final clock = ref.watch(clockProvider);
  return MockOrderRepository(
    simulator: simulator,
    store: ref.watch(localStoreProvider),
    ledger: ref.watch(pointLedgerProvider),
    stores: MockStoreRepository(
      assets: ref.watch(mockAssetsProvider),
      simulator: simulator,
      clock: clock,
    ),
    clock: clock,
  );
});
