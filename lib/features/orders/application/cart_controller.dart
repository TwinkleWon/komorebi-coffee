import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../stores/domain/cafe_store.dart';
import '../domain/cart.dart';

final cartControllerProvider =
    NotifierProvider<CartController, Cart>(CartController.new);

class CartController extends Notifier<Cart> {
  @override
  Cart build() => const Cart();

  void selectStore(CafeStore store) => state = state.copyWith(store: store);

  void add(CartLine line) {
    final index = state.lines.indexWhere((l) => l.key == line.key);
    if (index < 0) {
      state = state.copyWith(lines: [...state.lines, line]);
      return;
    }
    final merged = state.lines[index]
        .copyWith(quantity: state.lines[index].quantity + line.quantity);
    state = state.copyWith(
      lines: [...state.lines]..[index] = merged,
    );
  }

  /// Setting the quantity to zero removes the line.
  void updateQuantity(String key, int quantity) {
    state = state.copyWith(
      lines: [
        for (final line in state.lines)
          if (line.key != key)
            line
          else if (quantity > 0)
            line.copyWith(quantity: quantity),
      ],
    );
  }

  void setPickupSlot(PickupSlot slot) =>
      state = state.copyWith(pickupSlot: slot);

  void setUsePoints(bool value) => state = state.copyWith(usePoints: value);

  /// Empties the cart but keeps the chosen store for the next order.
  void clearAfterOrder() => state = Cart(store: state.store);
}
