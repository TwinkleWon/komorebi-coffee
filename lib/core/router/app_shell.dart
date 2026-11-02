import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/coupons/application/coupon_controller.dart';
import '../../features/menu/application/menu_providers.dart';
import '../../features/news/application/news_providers.dart';
import '../../features/orders/application/order_controllers.dart';
import '../../features/points/application/points_providers.dart';
import '../../features/stores/application/store_providers.dart';
import '../l10n/l10n.dart';
import '../network/connectivity.dart';
import '../theme/app_theme.dart';

/// Bottom navigation scaffold shared by the five main tabs.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    // When connectivity returns, refresh everything so cached data is
    // replaced with fresh data without the user having to pull to refresh.
    ref.listen<bool>(isOnlineProvider, (previous, online) {
      if (previous == false && online) {
        ref
          ..invalidate(pointSummaryProvider)
          ..invalidate(couponListProvider)
          ..invalidate(storeListProvider)
          ..invalidate(menuProvider)
          ..invalidate(newsProvider)
          ..invalidate(orderHistoryProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.backOnline)),
        );
      }
    });

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const OfflineBanner(),
          DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.line)),
            ),
            child: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home_rounded),
                  label: l10n.navHome,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.local_cafe_outlined),
                  selectedIcon: const Icon(Icons.local_cafe_rounded),
                  label: l10n.navOrder,
                ),
                NavigationDestination(
                  icon: const _CardTabIcon(),
                  label: l10n.navCard,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.confirmation_number_outlined),
                  selectedIcon: const Icon(Icons.confirmation_number_rounded),
                  label: l10n.navCoupons,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.storefront_outlined),
                  selectedIcon: const Icon(Icons.storefront_rounded),
                  label: l10n.navStores,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The member card is the most used feature, so its tab gets a filled badge.
class _CardTabIcon extends StatelessWidget {
  const _CardTabIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.espresso,
        borderRadius: BorderRadius.circular(10),
      ),
      child:
          const Icon(Icons.qr_code_2_rounded, color: AppColors.paper, size: 20),
    );
  }
}

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final online = ref.watch(isOnlineProvider);
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: online
          ? const SizedBox(width: double.infinity)
          : Container(
              width: double.infinity,
              color: AppColors.roast,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.wifi_off_rounded,
                      size: 16, color: AppColors.caramelSoft),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      context.l10n.offlineBanner,
                      style: const TextStyle(
                        color: AppColors.paper,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
