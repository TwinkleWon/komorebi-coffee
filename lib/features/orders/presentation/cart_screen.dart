import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/error_presenter.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common.dart';
import '../../menu/presentation/menu_item_sheet.dart';
import '../../menu/presentation/menu_screen.dart';
import '../../menu/presentation/product_thumb.dart';
import '../../points/application/points_providers.dart';
import '../application/cart_controller.dart';
import '../application/order_controllers.dart';
import '../data/mock_order_repository.dart';
import '../domain/cart.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  Future<void> _submit(BuildContext context, WidgetRef ref) async {
    final order = await ref.read(checkoutControllerProvider.notifier).submit();
    if (order != null && context.mounted) {
      context.pushReplacement(AppRoutes.orderDetail(order.id), extra: true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final cart = ref.watch(cartControllerProvider);
    final checkout = ref.watch(checkoutControllerProvider);
    final balance =
        ref.watch(pointSummaryProvider).valueOrNull?.data.balance ?? 0;
    final pointsToUse = cart.pointsToUse(balance);
    final total = cart.subtotal - pointsToUse;
    final submitting = checkout.isLoading;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: PageTitle(eyebrow: 'Cart', title: l10n.cartTitle),
      ),
      body: cart.isEmpty
          ? EmptyState(
              icon: Icons.shopping_bag_outlined,
              message: l10n.cartEmpty,
              action: OutlinedButton(
                onPressed: () => context.pop(),
                child: Text(l10n.browseMenu),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              children: [
                const PickupStoreCard(),
                const SizedBox(height: 20),
                SurfaceCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: ListTile.divideTiles(
                      context: context,
                      tiles:
                          cart.lines.map((line) => _CartLineTile(line: line)),
                    ).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                Text(l10n.pickupTime,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final slot in PickupSlot.values)
                      ChoiceChip(
                        label: Text(switch (slot) {
                          PickupSlot.asap => l10n.pickupAsap,
                          PickupSlot.in15 => l10n.pickupIn15,
                          PickupSlot.in30 => l10n.pickupIn30,
                        }),
                        selected: cart.pickupSlot == slot,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: cart.pickupSlot == slot
                              ? AppColors.paper
                              : AppColors.ink,
                        ),
                        onSelected: (_) => ref
                            .read(cartControllerProvider.notifier)
                            .setPickupSlot(slot),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                SurfaceCard(
                  padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      l10n.usePoints,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle:
                        Text(l10n.usePointsBalance(formatPoints(balance))),
                    value: cart.usePoints,
                    onChanged: balance > 0
                        ? (v) => ref
                            .read(cartControllerProvider.notifier)
                            .setUsePoints(v)
                        : null,
                  ),
                ),
                const SizedBox(height: 24),
                _SummaryRow(
                    label: l10n.subtotal, value: formatYen(cart.subtotal)),
                if (pointsToUse > 0)
                  _SummaryRow(
                    label: l10n.pointsDiscount,
                    value: '−${formatYen(pointsToUse)}',
                    valueColor: AppColors.caramel,
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(),
                ),
                _SummaryRow(
                  label: l10n.total,
                  value: formatYen(total),
                  emphasized: true,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.earnPreview(total ~/ MockOrderRepository.yenPerPoint),
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 12, color: AppColors.matcha),
                ),
                if (checkout.hasError && !submitting) ...[
                  const SizedBox(height: 20),
                  _CheckoutError(error: checkout.error!),
                ],
                const SizedBox(height: 16),
                Text(
                  l10n.payAtStore,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(fontSize: 12, color: AppColors.inkMuted),
                ),
              ],
            ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: FilledButton(
                  onPressed: cart.store == null || submitting
                      ? null
                      : () => _submit(context, ref),
                  child: submitting
                      ? const SizedBox.square(
                          dimension: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.4),
                        )
                      : Text(
                          cart.store == null
                              ? l10n.selectStoreHint
                              : l10n.placeOrder(formatYen(total)),
                        ),
                ),
              ),
            ),
    );
  }
}

class _CartLineTile extends ConsumerWidget {
  const _CartLineTile({required this.line});

  final CartLine line;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          ProductThumb(item: line.item, size: 52),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(line.item.name,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                if (line.optionsLabel != null)
                  Text(
                    line.optionsLabel!,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.inkMuted),
                  ),
                const SizedBox(height: 4),
                Text(formatYen(line.total),
                    style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
          QuantityStepper(
            value: line.quantity,
            onChanged: (v) => ref
                .read(cartControllerProvider.notifier)
                .updateQuantity(line.key, v),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasized = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool emphasized;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
              color: emphasized ? AppColors.ink : AppColors.inkMuted,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: emphasized
                ? AppTextStyles.display(26)
                : TextStyle(fontWeight: FontWeight.w600, color: valueColor),
          ),
        ],
      ),
    );
  }
}

/// Inline failure panel. Spells out that retrying will not double-order,
/// since the same idempotency key is reused.
class _CheckoutError extends StatelessWidget {
  const _CheckoutError({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final description = describeError(l10n, error);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.danger.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.danger.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(description.icon, color: AppColors.danger, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.checkoutFailed,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.danger,
                  ),
                ),
                const SizedBox(height: 4),
                Text(description.message, style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 4),
                Text(
                  l10n.checkoutRetryNote,
                  style:
                      const TextStyle(fontSize: 12, color: AppColors.inkMuted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
