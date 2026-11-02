import 'package:flutter/material.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_theme.dart';
import '../domain/order.dart';

String orderStatusLabel(AppLocalizations l10n, OrderStatus status) =>
    switch (status) {
      OrderStatus.received => l10n.statusReceived,
      OrderStatus.preparing => l10n.statusPreparing,
      OrderStatus.ready => l10n.statusReady,
    };

/// Three-step horizontal tracker: received → preparing → ready.
class OrderStatusTracker extends StatelessWidget {
  const OrderStatusTracker({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const steps = OrderStatus.values;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, step) in steps.indexed) ...[
          // Steps get twice the width of connectors so labels stay on
          // one line.
          Expanded(
            flex: 2,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.index <= status.index
                        ? (step == OrderStatus.ready
                            ? AppColors.matcha
                            : AppColors.espresso)
                        : AppColors.surfaceMuted,
                  ),
                  child: Icon(
                    switch (step) {
                      OrderStatus.received => Icons.receipt_rounded,
                      OrderStatus.preparing => Icons.coffee_maker_outlined,
                      OrderStatus.ready => Icons.check_rounded,
                    },
                    size: 16,
                    color: step.index <= status.index
                        ? AppColors.paper
                        : AppColors.inkMuted,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  orderStatusLabel(l10n, step),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight:
                        step == status ? FontWeight.w800 : FontWeight.w500,
                    color: step.index <= status.index
                        ? AppColors.ink
                        : AppColors.inkMuted,
                  ),
                ),
              ],
            ),
          ),
          if (index < steps.length - 1)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 2,
                  color: step.index < status.index
                      ? AppColors.espresso
                      : AppColors.line,
                ),
              ),
            ),
        ],
      ],
    );
  }
}
