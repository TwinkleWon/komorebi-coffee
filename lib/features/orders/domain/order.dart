import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart.dart';

part 'order.freezed.dart';
part 'order.g.dart';

enum OrderStatus { received, preparing, ready }

@freezed
class OrderLine with _$OrderLine {
  const OrderLine._();

  const factory OrderLine({
    required String itemId,
    required String name,
    String? options,
    required int unitPrice,
    required int quantity,
  }) = _OrderLine;

  factory OrderLine.fromJson(Map<String, dynamic> json) =>
      _$OrderLineFromJson(json);

  factory OrderLine.fromCart(CartLine line) => OrderLine(
        itemId: line.item.id,
        name: line.item.name,
        options: line.optionsLabel,
        unitPrice: line.unitPrice,
        quantity: line.quantity,
      );

  int get total => unitPrice * quantity;
}

@freezed
class Order with _$Order {
  const Order._();

  const factory Order({
    required String id,

    /// Short number called out at the pickup counter.
    required int number,
    required String storeId,
    required String storeName,
    required List<OrderLine> lines,
    required int subtotal,
    @Default(0) int pointsUsed,
    required int total,
    @Default(0) int pointsEarned,
    required DateTime createdAt,
    required DateTime pickupAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  /// Status derived from time, as a stand-in for server push updates.
  OrderStatus statusAt(DateTime now) {
    if (!now.isBefore(pickupAt)) return OrderStatus.ready;
    if (now.difference(createdAt) < const Duration(minutes: 1)) {
      return OrderStatus.received;
    }
    return OrderStatus.preparing;
  }

  /// Still worth surfacing on the home screen.
  bool isActiveAt(DateTime now) =>
      now.isBefore(pickupAt.add(const Duration(minutes: 30)));
}

/// Payload sent when placing an order.
class OrderRequest {
  const OrderRequest({
    required this.idempotencyKey,
    required this.storeId,
    required this.lines,
    required this.pickupSlot,
    this.pointsToUse = 0,
  });

  /// Same key for every retry of the same checkout, so a request whose
  /// response was lost cannot create a duplicate order.
  final String idempotencyKey;
  final String storeId;
  final List<OrderLine> lines;
  final PickupSlot pickupSlot;
  final int pointsToUse;
}
