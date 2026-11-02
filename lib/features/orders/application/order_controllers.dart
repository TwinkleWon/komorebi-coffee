import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/cache/response_cache.dart';
import '../../points/application/points_providers.dart';
import '../data/order_repository.dart';
import '../domain/order.dart';
import 'cart_controller.dart';

final orderHistoryProvider =
    AsyncNotifierProvider<OrderHistoryController, Snapshot<List<Order>>>(
  OrderHistoryController.new,
);

final orderByIdProvider =
    Provider.family<AsyncValue<Order?>, String>((ref, id) {
  return ref.watch(orderHistoryProvider).whenData(
      (snapshot) => snapshot.data.firstWhereOrNull((o) => o.id == id));
});

class OrderHistoryController extends AsyncNotifier<Snapshot<List<Order>>> {
  static const _cacheKey = 'orders';
  static final _codec =
      CacheCodec.listOf<Order>(Order.fromJson, (o) => o.toJson());

  @override
  Future<Snapshot<List<Order>>> build() {
    return ref.watch(responseCacheProvider).fetch(
          key: _cacheKey,
          request: ref.watch(orderRepositoryProvider).fetchOrders,
          codec: _codec,
        );
  }

  /// Inserts a just-placed order locally so the confirmation screen does not
  /// depend on another network round trip.
  Future<void> prepend(Order order) async {
    final current = state.valueOrNull;
    final orders = [
      order,
      ...?current?.data.where((o) => o.id != order.id),
    ];
    state = AsyncData(
      Snapshot(
        data: orders,
        fetchedAt: current?.fetchedAt ?? order.createdAt,
        isFromCache: current?.isFromCache ?? false,
      ),
    );
    await ref.read(responseCacheProvider).write(_cacheKey, orders, _codec);
  }
}

final uuidProvider = Provider<Uuid>((ref) => const Uuid());

final checkoutControllerProvider =
    AsyncNotifierProvider.autoDispose<CheckoutController, Order?>(
  CheckoutController.new,
);

/// Submits the cart. The idempotency key lives as long as the cart contents
/// stay the same, so tapping "retry" after a timeout is always safe.
class CheckoutController extends AutoDisposeAsyncNotifier<Order?> {
  String? _idempotencyKey;

  @override
  Order? build() {
    ref.listen(cartControllerProvider, (previous, next) {
      if (previous?.lines != next.lines ||
          previous?.store != next.store ||
          previous?.usePoints != next.usePoints ||
          previous?.pickupSlot != next.pickupSlot) {
        _idempotencyKey = null;
      }
    });
    return null;
  }

  Future<Order?> submit() async {
    final cart = ref.read(cartControllerProvider);
    final store = cart.store;
    if (store == null || cart.isEmpty || state.isLoading) return null;

    final balance =
        ref.read(pointSummaryProvider).valueOrNull?.data.balance ?? 0;
    _idempotencyKey ??= ref.read(uuidProvider).v4();
    final request = OrderRequest(
      idempotencyKey: _idempotencyKey!,
      storeId: store.id,
      lines: cart.lines.map(OrderLine.fromCart).toList(),
      pickupSlot: cart.pickupSlot,
      pointsToUse: cart.pointsToUse(balance),
    );

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(orderRepositoryProvider).placeOrder(request),
    );

    final order = state.valueOrNull;
    if (order != null) {
      await ref.read(orderHistoryProvider.notifier).prepend(order);
      ref.read(cartControllerProvider.notifier).clearAfterOrder();
      ref.invalidate(pointSummaryProvider);
    }
    return order;
  }
}
