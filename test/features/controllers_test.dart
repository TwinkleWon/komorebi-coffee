import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komorebi_coffee/core/error/app_exception.dart';
import 'package:komorebi_coffee/features/menu/domain/menu_item.dart';
import 'package:komorebi_coffee/features/orders/application/cart_controller.dart';
import 'package:komorebi_coffee/features/orders/application/order_controllers.dart';
import 'package:komorebi_coffee/features/orders/data/order_repository.dart';
import 'package:komorebi_coffee/features/orders/domain/cart.dart';
import 'package:komorebi_coffee/features/orders/domain/order.dart';
import 'package:komorebi_coffee/features/stores/domain/cafe_store.dart';

import '../helpers/test_app.dart';

const _latte = MenuItem(
  id: 'm_latte',
  name: 'カフェラテ',
  nameEn: 'Caffè Latte',
  description: '',
  category: MenuCategory.coffee,
  price: 480,
  customizable: true,
);

const _store = CafeStore(
  id: 'st_jinnan',
  name: '渋谷 神南店',
  area: '渋谷',
  address: '',
  phone: '',
  latitude: 0,
  longitude: 0,
  weekdayHours: BusinessHours(open: '07:00', close: '22:00'),
  weekendHours: BusinessHours(open: '08:00', close: '22:00'),
);

/// Fails the first [failures] calls with a timeout, then succeeds, and
/// records every idempotency key it receives.
class _FlakyOrderRepository implements OrderRepository {
  _FlakyOrderRepository({this.failures = 1});

  int failures;
  final keys = <String>[];

  @override
  Future<List<Order>> fetchOrders() async => [];

  @override
  Future<Order> placeOrder(OrderRequest request) async {
    keys.add(request.idempotencyKey);
    if (failures-- > 0) throw const RequestTimeoutException();
    return Order(
      id: 'o1',
      number: 101,
      storeId: request.storeId,
      storeName: '',
      lines: request.lines,
      subtotal: 0,
      total: 0,
      createdAt: fixedNow,
      pickupAt: fixedNow,
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CartController', () {
    late ProviderContainer container;
    late CartController cart;

    setUp(() async {
      container = await createTestContainer();
      cart = container.read(cartControllerProvider.notifier);
    });

    tearDown(() => container.dispose());

    test('merges lines with identical options', () {
      cart
        ..add(const CartLine(
            item: _latte, size: DrinkSize.m, temperature: Temperature.hot))
        ..add(const CartLine(
            item: _latte,
            size: DrinkSize.m,
            temperature: Temperature.hot,
            quantity: 2))
        ..add(const CartLine(
            item: _latte, size: DrinkSize.l, temperature: Temperature.hot));

      final state = container.read(cartControllerProvider);
      expect(state.lines, hasLength(2));
      expect(state.itemCount, 4);
      expect(state.subtotal, (480 + 50) * 3 + (480 + 100));
    });

    test('quantity zero removes the line', () {
      cart.add(const CartLine(item: _latte));
      final key = container.read(cartControllerProvider).lines.single.key;
      cart.updateQuantity(key, 0);
      expect(container.read(cartControllerProvider).isEmpty, isTrue);
    });

    test('points applied never exceed the subtotal', () {
      cart
        ..add(const CartLine(item: _latte))
        ..setUsePoints(true);
      final state = container.read(cartControllerProvider);
      expect(state.pointsToUse(100), 100);
      expect(state.pointsToUse(10000), 480);
    });

    test('clearing after an order keeps the store', () {
      cart
        ..selectStore(_store)
        ..add(const CartLine(item: _latte))
        ..clearAfterOrder();
      final state = container.read(cartControllerProvider);
      expect(state.isEmpty, isTrue);
      expect(state.store, _store);
    });
  });

  group('CheckoutController', () {
    test('retrying a failed checkout reuses the idempotency key', () async {
      final repo = _FlakyOrderRepository();
      final container = await createTestContainer(
        overrides: [orderRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(container.dispose);
      // Keep the auto-dispose controller alive between calls.
      container.listen(checkoutControllerProvider, (_, __) {});

      container.read(cartControllerProvider.notifier)
        ..selectStore(_store)
        ..add(const CartLine(item: _latte));
      final checkout = container.read(checkoutControllerProvider.notifier);

      expect(await checkout.submit(), isNull);
      expect(container.read(checkoutControllerProvider).error,
          isA<RequestTimeoutException>());

      final order = await checkout.submit();
      expect(order?.id, 'o1');
      expect(repo.keys, hasLength(2));
      expect(repo.keys[0], repo.keys[1]);
      expect(container.read(cartControllerProvider).isEmpty, isTrue);
    });

    test('changing the cart produces a new idempotency key', () async {
      final repo = _FlakyOrderRepository(failures: 2);
      final container = await createTestContainer(
        overrides: [orderRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(container.dispose);
      container.listen(checkoutControllerProvider, (_, __) {});

      final cart = container.read(cartControllerProvider.notifier)
        ..selectStore(_store)
        ..add(const CartLine(item: _latte));
      final checkout = container.read(checkoutControllerProvider.notifier);

      await checkout.submit();
      cart.add(const CartLine(item: _latte));
      await checkout.submit();

      expect(repo.keys[0], isNot(repo.keys[1]));
    });
  });
}
