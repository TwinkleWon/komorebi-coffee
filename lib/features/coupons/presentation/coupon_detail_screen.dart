import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/error_presenter.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/clock.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/common.dart';
import '../application/coupon_controller.dart';
import '../domain/coupon.dart';
import 'coupon_ticket.dart';

class CouponDetailScreen extends ConsumerStatefulWidget {
  const CouponDetailScreen({super.key, required this.couponId});

  final String couponId;

  @override
  ConsumerState<CouponDetailScreen> createState() => _CouponDetailScreenState();
}

class _CouponDetailScreenState extends ConsumerState<CouponDetailScreen> {
  bool _redeeming = false;

  Future<void> _confirmAndRedeem() async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.couponConfirmTitle),
        content: Text(l10n.couponConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel,
                style: const TextStyle(color: AppColors.inkMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.couponConfirmAction),
          ),
        ],
      ),
    );
    if (confirmed == true) await _redeem();
  }

  Future<void> _redeem() async {
    setState(() => _redeeming = true);
    try {
      await ref.read(couponListProvider.notifier).redeem(widget.couponId);
    } on Object catch (error) {
      if (!mounted) return;
      // Transient failures offer a retry. Retrying is safe: a request that
      // actually succeeded comes back as "already used".
      showErrorSnackBar(context, error, onRetry: _redeem);
    } finally {
      if (mounted) setState(() => _redeeming = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final coupon = ref.watch(couponByIdProvider(widget.couponId));
    final now = ref.watch(clockProvider)();
    final current = coupon.valueOrNull;
    final canRedeem = current != null && current.isAvailableAt(now);

    return Scaffold(
      appBar: AppBar(),
      body: AsyncValueView(
        value: coupon,
        onRetry: () => ref.invalidate(couponListProvider),
        data: (coupon) {
          if (coupon == null) {
            return EmptyState(
              icon: Icons.search_off_rounded,
              message: l10n.errorNotFound,
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: coupon.isUsed
                    ? _RedeemedPanel(coupon: coupon)
                    : _CouponHero(coupon: coupon, now: now),
              ),
              const SizedBox(height: 28),
              Text(
                coupon.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                coupon.description,
                style: const TextStyle(color: AppColors.roast, height: 1.8),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(Icons.schedule_rounded,
                      size: 16, color: AppColors.inkMuted),
                  const SizedBox(width: 6),
                  Text(
                    l10n.couponExpiresOn(
                        formatDate(coupon.expiresAt, l10n.localeName)),
                    style: const TextStyle(
                        color: AppColors.inkMuted, fontSize: 13),
                  ),
                ],
              ),
              if (coupon.conditions.isNotEmpty) ...[
                const SizedBox(height: 28),
                Text(
                  l10n.couponConditions,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                for (final condition in coupon.conditions)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8, right: 10),
                          child: CircleAvatar(
                            radius: 2.5,
                            backgroundColor: AppColors.caramel,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            condition,
                            style: const TextStyle(fontSize: 13.5, height: 1.6),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ],
          );
        },
      ),
      bottomNavigationBar: canRedeem
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: FilledButton(
                  onPressed: _redeeming ? null : _confirmAndRedeem,
                  child: _redeeming
                      ? const SizedBox.square(
                          dimension: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.4),
                        )
                      : Text(l10n.couponUse),
                ),
              ),
            )
          : null,
    );
  }
}

class _CouponHero extends StatelessWidget {
  const _CouponHero({required this.coupon, required this.now});

  final Coupon coupon;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final available = coupon.isAvailableAt(now);
    return Container(
      key: const ValueKey('hero'),
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: available ? AppColors.caramelSoft : AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: -30,
            bottom: -40,
            child: Icon(
              Icons.local_cafe_rounded,
              size: 180,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          CouponValue(coupon: coupon, muted: !available, scale: 1.8),
          if (!available)
            Positioned(
              top: 16,
              right: 16,
              child: Pill(
                label: context.l10n.couponExpired,
                color: AppColors.surface,
                textColor: AppColors.inkMuted,
              ),
            ),
        ],
      ),
    );
  }
}

class _RedeemedPanel extends StatelessWidget {
  const _RedeemedPanel({required this.coupon});

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      key: const ValueKey('redeemed'),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.espresso,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: AppColors.matcha,
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.check_rounded, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 14),
          Text(
            l10n.couponRedeemedTitle,
            style: const TextStyle(
              color: AppColors.paper,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.couponRedeemedBody,
            style: const TextStyle(color: AppColors.caramelSoft, fontSize: 12),
          ),
          const SizedBox(height: 18),
          Text(
            coupon.redemptionCode ?? '----',
            style: AppTextStyles.display(36, color: AppColors.paper)
                .copyWith(letterSpacing: 4),
          ),
          const SizedBox(height: 6),
          if (coupon.usedAt != null)
            Text(
              l10n.couponRedeemedAt(
                  formatDateTime(coupon.usedAt!, l10n.localeName)),
              style: TextStyle(
                color: AppColors.paper.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
