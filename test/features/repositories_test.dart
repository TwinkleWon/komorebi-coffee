import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komorebi_coffee/core/error/app_exception.dart';
import 'package:komorebi_coffee/features/coupons/data/coupon_repository.dart';
import 'package:komorebi_coffee/features/orders/data/order_repository.dart';
import 'package:komorebi_coffee/features/orders/domain/cart.dart';
import 'package:komorebi_coffee/features/orders/domain/order.dart';
import 'package:komorebi_coffee/features/points/data/point_ledger.dart';
import 'package:komorebi_coffee/features/points/data/point_repository.dart';

import '../helpers/test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;

  setUp(() async {
    container = await createTestContainer();
  });

  tearDown(() => container.dispose());

  group('MockCouponRepository', () {
    test('redeems once and persists the redemption', () async {
      final repo = container.read(couponRepositoryProvider);

      final redeemed = await repo.redeem('cp_welcome');
      expect(redeemed.isUsed, isTrue);
      expect(redeemed.redemptionCode, startsWith('KMB-'));

      await expectLater(
        repo.redeem('cp_welcome'),
        throwsA(isA<CouponAlreadyUsedException>()),
      );

      // A fresh repository instance reads the same persisted state, as it
      // would after an app restart.
      container.invalidate(couponRepositoryProvider);
      final coupons =
          await container.read(couponRepositoryProvider).fetchCoupons();
      expect(coupons.firstWhere((c) => c.id == 'cp_welcome').isUsed, isTrue);
    });

    test('rejects expired coupons', () {
      expect(
        container.read(couponRepositoryProvider).redeem('cp_summer'),
        throwsA(isA<CouponExpiredException>()),
      );
    });
  });

  group('MockOrderRepository', () {
    OrderRequest request({String key = 'key-1', int points = 0}) =>
        OrderRequest(
          idempotencyKey: key,
          storeId: 'st_jinnan',
          lines: const [
            OrderLine(
                itemId: 'm_latte', name: 'Latte', unitPrice: 530, quantity: 2),
          ],
          pickupSlot: PickupSlot.asap,
          pointsToUse: points,
        );

    test('earns 1pt per ¥100 and is idempotent per key', () async {
      final repo = container.read(orderRepositoryProvider);

      final first = await repo.placeOrder(request());
      final retry = await repo.placeOrder(request());

      expect(retry.id, first.id);
      expect(first.total, 1060);
      expect(first.pointsEarned, 10);
      expect((await repo.fetchOrders()).length, 1);
      expect(container.read(pointLedgerProvider).balance, 10);
    });

    test('a new key creates a new order', () async {
      final repo = container.read(orderRepositoryProvider);
      await repo.placeOrder(request(key: 'a'));
      await repo.placeOrder(request(key: 'b'));
      expect((await repo.fetchOrders()).length, 2);
    });

    test('rejects spending more points than the balance', () {
      expect(
        container
            .read(orderRepositoryProvider)
            .placeOrder(request(points: 500)),
        throwsA(isA<InsufficientPointsException>()),
      );
    });

    test('rejects stores without mobile ordering', () {
      final req = OrderRequest(
        idempotencyKey: 'x',
        storeId: 'st_kiyosumi',
        lines: request().lines,
        pickupSlot: PickupSlot.asap,
      );
      expect(
        container.read(orderRepositoryProvider).placeOrder(req),
        throwsA(isA<StoreClosedException>()),
      );
    });

    test('point summary reflects spend and earn', () async {
      final repo = container.read(orderRepositoryProvider);
      await repo.placeOrder(request(key: 'a')); // +10
      await repo.placeOrder(request(key: 'b', points: 10)); // -10, +10
      final summary =
          await container.read(pointRepositoryProvider).fetchSummary();
      expect(summary.balance, 10);
      expect(summary.lifetimeEarned, 20);
    });
  });
}
