import 'package:freezed_annotation/freezed_annotation.dart';

import '../../menu/domain/menu_item.dart';
import '../../stores/domain/cafe_store.dart';

part 'cart.freezed.dart';

enum PickupSlot {
  asap(5),
  in15(15),
  in30(30);

  const PickupSlot(this.minutes);

  final int minutes;
}

@freezed
class CartLine with _$CartLine {
  const CartLine._();

  const factory CartLine({
    required MenuItem item,
    DrinkSize? size,
    Temperature? temperature,
    @Default(1) int quantity,
  }) = _CartLine;

  /// Lines with the same item and options are merged.
  String get key => '${item.id}|${size?.name}|${temperature?.name}';

  int get unitPrice => item.price + (size?.priceDelta ?? 0);

  int get total => unitPrice * quantity;

  /// e.g. "M / ICED"
  String? get optionsLabel {
    final parts = [
      if (size != null) size!.label,
      if (temperature != null) temperature!.name.toUpperCase(),
    ];
    return parts.isEmpty ? null : parts.join(' / ');
  }
}

@freezed
class Cart with _$Cart {
  const Cart._();

  const factory Cart({
    CafeStore? store,
    @Default(<CartLine>[]) List<CartLine> lines,
    @Default(PickupSlot.asap) PickupSlot pickupSlot,
    @Default(false) bool usePoints,
  }) = _Cart;

  bool get isEmpty => lines.isEmpty;

  int get itemCount => lines.fold(0, (sum, l) => sum + l.quantity);

  int get subtotal => lines.fold(0, (sum, l) => sum + l.total);

  /// Points applied at checkout: never more than the subtotal.
  int pointsToUse(int balance) =>
      usePoints ? (balance < subtotal ? balance : subtotal) : 0;
}
