import 'package:collection/collection.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/network/network_simulator.dart';
import '../../../core/storage/local_store.dart';
import '../../../core/time/clock.dart';
import '../../points/data/point_ledger.dart';
import '../../points/domain/point_transaction.dart';
import '../../stores/data/store_repository.dart';
import '../domain/order.dart';
import 'order_repository.dart';

/// Mimics the order API, including server-side validation, point accrual and
/// idempotent retries.
class MockOrderRepository implements OrderRepository {
  MockOrderRepository({
    required NetworkSimulator simulator,
    required LocalStore store,
    required PointLedger ledger,
    required MockStoreRepository stores,
    required Clock clock,
  })  : _simulator = simulator,
        _store = store,
        _ledger = ledger,
        _stores = stores,
        _clock = clock;

  static const _ordersKey = 'mock_server.orders';
  static const _idempotencyKey = 'mock_server.idempotency';

  /// 1 point per ¥100 paid.
  static const yenPerPoint = 100;

  final NetworkSimulator _simulator;
  final LocalStore _store;
  final PointLedger _ledger;
  final MockStoreRepository _stores;
  final Clock _clock;

  @override
  Future<List<Order>> fetchOrders() => _simulator(() {
        final orders = _orders()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return orders;
      });

  @override
  Future<Order> placeOrder(OrderRequest request) {
    return _simulator(() => _process(request), mayLoseResponse: true);
  }

  Future<Order> _process(OrderRequest request) async {
    final processed = _processedKeys();
    final existingId = processed[request.idempotencyKey];
    if (existingId != null) {
      final existing = _orders().firstWhereOrNull((o) => o.id == existingId);
      if (existing != null) return existing;
    }

    final now = _clock();
    final pickupAt = now.add(Duration(minutes: request.pickupSlot.minutes));
    final stores = await _stores.loadWithoutNetwork();
    final store = stores.firstWhereOrNull((s) => s.id == request.storeId);
    if (store == null) throw const NotFoundException();
    if (!store.mobileOrder || !store.isOpenAt(pickupAt)) {
      throw const StoreClosedException();
    }
    if (request.pointsToUse > _ledger.balance) {
      throw const InsufficientPointsException();
    }

    final subtotal = request.lines.fold(0, (sum, l) => sum + l.total);
    final total = subtotal - request.pointsToUse;
    final orders = _orders();
    final order = Order(
      id: 'ord_${orders.length + 1}_${now.millisecondsSinceEpoch}',
      number: 101 + orders.length % 899,
      storeId: store.id,
      storeName: store.name,
      lines: request.lines,
      subtotal: subtotal,
      pointsUsed: request.pointsToUse,
      total: total,
      pointsEarned: total ~/ yenPerPoint,
      createdAt: now,
      pickupAt: pickupAt,
    );

    await _store.writeJson(
      _ordersKey,
      [...orders, order].map((o) => o.toJson()).toList(),
    );
    await _store.writeJson(_idempotencyKey, {
      ...processed,
      request.idempotencyKey: order.id,
    });
    if (order.pointsUsed > 0) {
      await _ledger.append(
        PointTransaction(
          id: '${order.id}_spend',
          amount: -order.pointsUsed,
          reason: PointReason.orderSpend,
          createdAt: now,
          orderNumber: order.number,
        ),
      );
    }
    if (order.pointsEarned > 0) {
      await _ledger.append(
        PointTransaction(
          id: '${order.id}_earn',
          amount: order.pointsEarned,
          reason: PointReason.orderEarn,
          createdAt: now,
          orderNumber: order.number,
        ),
      );
    }
    return order;
  }

  List<Order> _orders() {
    final json = _store.readJson(_ordersKey);
    if (json is! List) return [];
    return json
        .map((e) => Order.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Map<String, String> _processedKeys() {
    final json = _store.readJson(_idempotencyKey);
    return json is Map ? Map<String, String>.from(json) : {};
  }
}
