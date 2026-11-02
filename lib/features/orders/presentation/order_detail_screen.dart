import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/clock.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/common.dart';
import '../application/order_controllers.dart';
import '../domain/order.dart';
import 'order_widgets.dart';

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({
    super.key,
    required this.orderId,
    this.justPlaced = false,
  });

  final String orderId;

  /// Shown right after checkout: adds a thank-you header and a way home.
  final bool justPlaced;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final order = ref.watch(orderByIdProvider(orderId));
    // Re-evaluates the time-based status every few seconds.
    final now =
        ref.watch(nowTickerProvider).valueOrNull ?? ref.watch(clockProvider)();

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: !justPlaced),
      body: AsyncValueView(
        value: order,
        onRetry: () => ref.invalidate(orderHistoryProvider),
        data: (order) => order == null
            ? EmptyState(
                icon: Icons.search_off_rounded, message: l10n.errorNotFound)
            : _OrderBody(order: order, now: now, justPlaced: justPlaced),
      ),
      bottomNavigationBar: justPlaced
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: OutlinedButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: Text(l10n.backToHome),
                ),
              ),
            )
          : null,
    );
  }
}

class _OrderBody extends StatelessWidget {
  const _OrderBody({
    required this.order,
    required this.now,
    required this.justPlaced,
  });

  final Order order;
  final DateTime now;
  final bool justPlaced;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = order.statusAt(now);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      children: [
        if (justPlaced) ...[
          Center(
            child: Text(
              l10n.orderThanks,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 16),
        ],
        Container(
          padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColors.line),
          ),
          child: Column(
            children: [
              Text(
                l10n.orderNumberLabel,
                style: const TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                  color: AppColors.caramel,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text('No.${order.number}', style: AppTextStyles.display(56)),
              const SizedBox(height: 4),
              Text(
                order.storeName,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              OrderStatusTracker(status: status),
              const SizedBox(height: 20),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  status == OrderStatus.ready
                      ? l10n.readyMessage
                      : l10n.preparingMessage(formatTime(order.pickupAt)),
                  key: ValueKey(status),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: status == OrderStatus.ready
                        ? AppColors.matcha
                        : AppColors.roast,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(l10n.orderItems,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        SurfaceCard(
          child: Column(
            children: [
              for (final line in order.lines)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(line.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            if (line.options != null)
                              Text(
                                line.options!,
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.inkMuted),
                              ),
                          ],
                        ),
                      ),
                      Text('×${line.quantity}',
                          style: const TextStyle(color: AppColors.inkMuted)),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 72,
                        child: Text(formatYen(line.total),
                            textAlign: TextAlign.end),
                      ),
                    ],
                  ),
                ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(),
              ),
              if (order.pointsUsed > 0)
                _AmountRow(
                  label: l10n.pointsDiscount,
                  value: '−${formatYen(order.pointsUsed)}',
                ),
              _AmountRow(
                  label: l10n.total, value: formatYen(order.total), bold: true),
              _AmountRow(
                label: l10n.pointsEarned,
                value: '+${formatPoints(order.pointsEarned)} pt',
                color: AppColors.matcha,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          formatDateTime(order.createdAt, l10n.localeName),
          textAlign: TextAlign.end,
          style: const TextStyle(fontSize: 12, color: AppColors.inkMuted),
        ),
      ],
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({
    required this.label,
    required this.value,
    this.bold = false,
    this.color,
  });

  final String label;
  final String value;
  final bool bold;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
      color: color,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(label, style: style),
          const Spacer(),
          Text(value, style: style),
        ],
      ),
    );
  }
}
