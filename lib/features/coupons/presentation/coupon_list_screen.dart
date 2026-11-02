import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/cache/response_cache.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/time/clock.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/common.dart';
import '../application/coupon_controller.dart';
import '../domain/coupon.dart';
import 'coupon_ticket.dart';

class CouponListScreen extends ConsumerWidget {
  const CouponListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final coupons = ref.watch(couponListProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
          title: PageTitle(eyebrow: 'Coupon', title: l10n.couponsTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.couponsAvailable),
              Tab(text: l10n.couponsHistory),
            ],
          ),
        ),
        body: AsyncValueView(
          value: coupons,
          onRetry: () => ref.invalidate(couponListProvider),
          data: (snapshot) {
            final now = ref.watch(clockProvider)();
            final available = snapshot.data
                .where((c) => c.isAvailableAt(now))
                .toList()
              ..sort((a, b) => a.expiresAt.compareTo(b.expiresAt));
            final history = snapshot.data
                .where((c) => !c.isAvailableAt(now))
                .toList()
              ..sort((a, b) =>
                  (b.usedAt ?? b.expiresAt).compareTo(a.usedAt ?? a.expiresAt));

            return TabBarView(
              children: [
                _CouponList(
                  snapshot: snapshot,
                  coupons: available,
                  now: now,
                  emptyMessage: l10n.couponsEmptyAvailable,
                ),
                _CouponList(
                  snapshot: snapshot,
                  coupons: history,
                  now: now,
                  emptyMessage: l10n.couponsEmptyHistory,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CouponList extends ConsumerWidget {
  const _CouponList({
    required this.snapshot,
    required this.coupons,
    required this.now,
    required this.emptyMessage,
  });

  final Snapshot<List<Coupon>> snapshot;
  final List<Coupon> coupons;
  final DateTime now;
  final String emptyMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () =>
          safeRefresh(() => ref.refresh(couponListProvider.future)),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          StaleDataNotice(snapshot: snapshot),
          if (coupons.isEmpty)
            EmptyState(
              icon: Icons.confirmation_number_outlined,
              message: emptyMessage,
            ),
          for (final coupon in coupons) ...[
            CouponTicket(
              coupon: coupon,
              now: now,
              onTap: () => context.push(AppRoutes.coupon(coupon.id)),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
