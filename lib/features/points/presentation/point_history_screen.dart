import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/common.dart';
import '../application/points_providers.dart';
import '../domain/point_transaction.dart';
import 'point_widgets.dart';

class PointHistoryScreen extends ConsumerWidget {
  const PointHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final summary = ref.watch(pointSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: PageTitle(eyebrow: 'Points', title: l10n.pointsHistory),
      ),
      body: AsyncValueView(
        value: summary,
        onRetry: () => ref.invalidate(pointSummaryProvider),
        data: (snapshot) {
          final data = snapshot.data;
          return RefreshIndicator(
            onRefresh: () =>
                safeRefresh(() => ref.refresh(pointSummaryProvider.future)),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              children: [
                StaleDataNotice(snapshot: snapshot),
                SurfaceCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.pointsBalance,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.inkMuted,
                              ),
                            ),
                            const SizedBox(height: 4),
                            PointsText(
                              points: data.balance,
                              size: 32,
                              color: AppColors.ink,
                            ),
                          ],
                        ),
                      ),
                      RankBadge(rank: data.rank, onDark: false),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (data.transactions.isEmpty)
                  EmptyState(
                    icon: Icons.receipt_long_outlined,
                    message: l10n.pointsHistoryEmpty,
                  )
                else
                  ...ListTile.divideTiles(
                    context: context,
                    tiles: data.transactions.map((t) => _TransactionTile(t)),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile(this.transaction);

  final PointTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final earned = transaction.amount > 0;
    final title = switch (transaction.reason) {
      PointReason.welcome => l10n.pointReasonWelcome,
      PointReason.orderEarn =>
        l10n.pointReasonOrderEarn(transaction.orderNumber ?? 0),
      PointReason.orderSpend =>
        l10n.pointReasonOrderSpend(transaction.orderNumber ?? 0),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: earned ? AppColors.matchaSoft : AppColors.caramelSoft,
            ),
            child: Icon(
              earned ? Icons.add_rounded : Icons.remove_rounded,
              size: 20,
              color: earned ? AppColors.matcha : AppColors.caramel,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(
                  formatDateTime(transaction.createdAt, l10n.localeName),
                  style:
                      const TextStyle(fontSize: 12, color: AppColors.inkMuted),
                ),
              ],
            ),
          ),
          Text(
            '${earned ? '+' : '−'}${formatPoints(transaction.amount.abs())} pt',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: earned ? AppColors.matcha : AppColors.caramel,
            ),
          ),
        ],
      ),
    );
  }
}
