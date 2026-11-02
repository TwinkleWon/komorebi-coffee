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

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final orders = ref.watch(orderHistoryProvider);
    final now = ref.watch(clockProvider)();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: PageTitle(eyebrow: 'Orders', title: l10n.orderHistory),
      ),
      body: AsyncValueView(
        value: orders,
        onRetry: () => ref.invalidate(orderHistoryProvider),
        data: (snapshot) => RefreshIndicator(
          onRefresh: () =>
              safeRefresh(() => ref.refresh(orderHistoryProvider.future)),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            children: [
              StaleDataNotice(snapshot: snapshot),
              if (snapshot.data.isEmpty)
                EmptyState(
                  icon: Icons.receipt_long_outlined,
                  message: l10n.orderHistoryEmpty,
                ),
              for (final order in snapshot.data) ...[
                _OrderTile(order: order, now: now),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({required this.order, required this.now});

  final Order order;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = order.statusAt(now);
    final ready = status == OrderStatus.ready;
    return SurfaceCard(
      padding: const EdgeInsets.all(18),
      onTap: () => context.push(AppRoutes.orderDetail(order.id)),
      child: Row(
        children: [
          Text('No.${order.number}', style: AppTextStyles.display(22)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.storeName,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                Text(
                  '${formatDateTime(order.createdAt, l10n.localeName)} · ${formatYen(order.total)}',
                  style:
                      const TextStyle(fontSize: 12, color: AppColors.inkMuted),
                ),
              ],
            ),
          ),
          Pill(
            label: orderStatusLabel(l10n, status),
            color: ready ? AppColors.surfaceMuted : AppColors.matchaSoft,
            textColor: ready ? AppColors.inkMuted : AppColors.matcha,
          ),
        ],
      ),
    );
  }
}
