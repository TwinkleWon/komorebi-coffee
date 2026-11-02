import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/coupons/presentation/coupon_detail_screen.dart';
import '../../features/coupons/presentation/coupon_list_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/menu/presentation/menu_screen.dart';
import '../../features/news/presentation/news_screens.dart';
import '../../features/orders/presentation/cart_screen.dart';
import '../../features/orders/presentation/order_detail_screen.dart';
import '../../features/orders/presentation/order_history_screen.dart';
import '../../features/points/presentation/member_card_screen.dart';
import '../../features/points/presentation/point_history_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/stores/presentation/store_detail_screen.dart';
import '../../features/stores/presentation/store_list_screen.dart';
import 'app_shell.dart';

abstract final class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';

  // Bottom navigation tabs.
  static const home = '/home';
  static const order = '/order';
  static const card = '/card';
  static const coupons = '/coupons';
  static const stores = '/stores';

  // Full-screen pages pushed above the tab bar.
  static const cart = '/cart';
  static const news = '/news';
  static const points = '/points';
  static const orders = '/orders';
  static const settings = '/settings';
  static String coupon(String id) => '/coupon/$id';
  static String store(String id) => '/store/$id';
  static String orderDetail(String id) => '/orders/$id';
  static String newsDetail(String id) => '/news/$id';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  // Re-runs `redirect` whenever the session changes.
  final refresh = ValueNotifier<int>(0);
  ref.listen(authControllerProvider, (_, __) => refresh.value++);

  final router = GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final location = state.matchedLocation;

      if (auth.isLoading && !auth.hasValue) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }
      final signedIn = auth.valueOrNull != null;
      if (!signedIn) {
        return location == AppRoutes.login ? null : AppRoutes.login;
      }
      if (location == AppRoutes.splash || location == AppRoutes.login) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => AppShell(navigationShell: shell),
        branches: [
          _branch(AppRoutes.home, const HomeScreen()),
          _branch(AppRoutes.order, const MenuScreen()),
          _branch(AppRoutes.card, const MemberCardScreen()),
          _branch(AppRoutes.coupons, const CouponListScreen()),
          _branch(AppRoutes.stores, const StoreListScreen()),
        ],
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (_, __) => const CartScreen(),
      ),
      GoRoute(
        path: '/coupon/:id',
        builder: (_, state) =>
            CouponDetailScreen(couponId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/store/:id',
        builder: (_, state) =>
            StoreDetailScreen(storeId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.orders,
        builder: (_, __) => const OrderHistoryScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (_, state) => OrderDetailScreen(
              orderId: state.pathParameters['id']!,
              justPlaced: state.extra == true,
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.news,
        builder: (_, __) => const NewsListScreen(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (_, state) =>
                NewsDetailScreen(newsId: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.points,
        builder: (_, __) => const PointHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (_, __) => const SettingsScreen(),
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
});

StatefulShellBranch _branch(String path, Widget screen) => StatefulShellBranch(
      routes: [GoRoute(path: path, builder: (_, __) => screen)],
    );
