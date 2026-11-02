import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/clock.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/skeleton.dart';
import '../../auth/application/auth_controller.dart';
import '../../coupons/application/coupon_controller.dart';
import '../../news/application/news_providers.dart';
import '../../news/presentation/news_screens.dart';
import '../../orders/application/order_controllers.dart';
import '../../orders/presentation/order_widgets.dart';
import '../../points/application/points_providers.dart';
import '../../points/presentation/point_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(authControllerProvider).valueOrNull;
    final now = ref.watch(clockProvider)();

    final greeting = switch (now.hour) {
      >= 5 && < 11 => l10n.greetingMorning,
      >= 11 && < 18 => l10n.greetingAfternoon,
      _ => l10n.greetingEvening,
    };

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => safeRefresh(
            () => Future.wait<Object?>([
              ref.refresh(pointSummaryProvider.future),
              ref.refresh(newsProvider.future),
              ref.refresh(couponListProvider.future),
              ref.refresh(orderHistoryProvider.future),
            ]),
          ),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              const _TopBar(),
              const SizedBox(height: 20),
              Text(
                greeting,
                style: const TextStyle(color: AppColors.inkMuted, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.greetingName(user?.displayName ?? ''),
                style: AppTextStyles.display(30),
              ),
              const SizedBox(height: 20),
              const PointSummaryCard(),
              _ActiveOrderCard(now: now),
              const SizedBox(height: 24),
              const _QuickActions(),
              const SizedBox(height: 28),
              const _SeasonalBanner(),
              const SizedBox(height: 32),
              SectionHeader(
                eyebrow: 'News',
                title: l10n.homeNews,
                actionLabel: l10n.seeAll,
                onAction: () => context.push(AppRoutes.news),
              ),
              const _NewsPreview(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(unreadNewsCountProvider);
    return Row(
      children: [
        Text(
          'KOMOREBI',
          style: AppTextStyles.display(20).copyWith(letterSpacing: 2.5),
        ),
        const Spacer(),
        IconButton(
          tooltip: context.l10n.newsTitle,
          onPressed: () => context.push(AppRoutes.news),
          icon: Badge(
            isLabelVisible: unread > 0,
            backgroundColor: AppColors.caramel,
            label: Text('$unread'),
            child: const Icon(Icons.notifications_none_rounded),
          ),
        ),
        IconButton(
          tooltip: context.l10n.settingsTitle,
          onPressed: () => context.push(AppRoutes.settings),
          icon: const Icon(Icons.person_outline_rounded),
        ),
      ],
    );
  }
}

class _ActiveOrderCard extends ConsumerWidget {
  const _ActiveOrderCard({required this.now});

  final DateTime now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderHistoryProvider).valueOrNull?.data;
    final active = orders?.firstWhereOrNull((o) => o.isActiveAt(now));
    if (active == null) return const SizedBox.shrink();

    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SurfaceCard(
        padding: const EdgeInsets.all(16),
        onTap: () => context.push(AppRoutes.orderDetail(active.id)),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.matchaSoft,
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.local_cafe_rounded, color: AppColors.matcha),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.activeOrderTitle,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.inkMuted),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'No.${active.number} · '
                    '${orderStatusLabel(l10n, active.statusAt(now))}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    active.storeName,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.inkMuted),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.inkMuted),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends ConsumerWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final now = ref.watch(clockProvider)();
    final available = ref
            .watch(couponListProvider)
            .valueOrNull
            ?.data
            .where((c) => c.isAvailableAt(now))
            .length ??
        0;

    return Row(
      children: [
        Expanded(
          child: _QuickAction(
            icon: Icons.local_cafe_outlined,
            title: l10n.quickOrder,
            subtitle: l10n.quickOrderSub,
            onTap: () => context.go(AppRoutes.order),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _QuickAction(
            icon: Icons.confirmation_number_outlined,
            title: l10n.quickCoupons,
            subtitle: l10n.quickCouponsSub(available),
            onTap: () => context.go(AppRoutes.coupons),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _QuickAction(
            icon: Icons.place_outlined,
            title: l10n.quickStores,
            subtitle: l10n.quickStoresSub,
            onTap: () => context.go(AppRoutes.stores),
          ),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.fromLTRB(12, 16, 8, 16),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppColors.caramelSoft,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: AppColors.caramel),
          ),
          const SizedBox(height: 14),
          // Three columns are tight on small phones: shrink rather than
          // truncate the label.
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10.5, color: AppColors.inkMuted),
          ),
        ],
      ),
    );
  }
}

class _SeasonalBanner extends StatelessWidget {
  const _SeasonalBanner();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Material(
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(AppRoutes.order),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF0D7B8), Color(0xFFD39A62)],
            ),
          ),
          child: Stack(
            children: [
              const Positioned(
                right: -40,
                top: -30,
                child: _Circle(size: 180, opacity: 0.18),
              ),
              const Positioned(
                right: 40,
                bottom: -50,
                child: _Circle(size: 120, opacity: 0.14),
              ),
              Positioned(
                right: 18,
                bottom: 14,
                child: Icon(
                  Icons.local_cafe_rounded,
                  size: 96,
                  color: Colors.white.withOpacity(0.35),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SEASONAL · NOVEMBER',
                      style: AppTextStyles.eyebrow
                          .copyWith(color: AppColors.roast),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.seasonalTitle,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: AppColors.espresso,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 220),
                      child: Text(
                        l10n.seasonalBody,
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.65,
                          color: AppColors.roast,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 9,
                      ),
                      decoration: const ShapeDecoration(
                        color: AppColors.espresso,
                        shape: StadiumBorder(),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.seasonalCta,
                            style: const TextStyle(
                              color: AppColors.paper,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: AppColors.paper,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }
}

class _NewsPreview extends ConsumerWidget {
  const _NewsPreview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(newsProvider);
    return news.when(
      skipLoadingOnRefresh: !news.hasError,
      skipError: news.hasValue,
      data: (snapshot) => Column(
        children: ListTile.divideTiles(
          context: context,
          tiles: snapshot.data.take(3).map((n) => NewsTile(item: n)),
        ).toList(),
      ),
      loading: () => const Column(
        children: [
          SizedBox(height: 12),
          Skeleton(height: 56),
          SizedBox(height: 12),
          Skeleton(height: 56),
        ],
      ),
      error: (error, _) => ErrorView(
        error: error,
        compact: true,
        onRetry: () => ref.invalidate(newsProvider),
      ),
    );
  }
}
