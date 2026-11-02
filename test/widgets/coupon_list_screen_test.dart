import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komorebi_coffee/core/error/app_exception.dart';
import 'package:komorebi_coffee/features/coupons/data/coupon_repository.dart';
import 'package:komorebi_coffee/features/coupons/domain/coupon.dart';
import 'package:komorebi_coffee/features/coupons/presentation/coupon_list_screen.dart';
import 'package:komorebi_coffee/features/coupons/presentation/coupon_ticket.dart';

import '../helpers/test_app.dart';

/// Fails the first call, then succeeds.
class _FlakyCouponRepository implements CouponRepository {
  int calls = 0;

  @override
  Future<List<Coupon>> fetchCoupons() async {
    calls++;
    if (calls == 1) throw const NetworkException();
    return [
      Coupon(
        id: 'c1',
        title: 'サイズアップ無料',
        description: '',
        kind: CouponKind.sizeUp,
        expiresAt: fixedNow.add(const Duration(days: 3)),
      ),
    ];
  }

  @override
  Future<Coupon> redeem(String couponId) => throw UnimplementedError();
}

void main() {
  testWidgets('shows available coupons from the mock API', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        overrides: await testOverrides(),
        child: const CouponListScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('使えるクーポン'), findsOneWidget);
    // Sorted by expiry, so the coupon ending today comes first.
    expect(find.text('雨の日限定 ¥50引き'), findsOneWidget);
    // The expired fixture coupon is only in the second tab.
    expect(find.text('夏のアイスコーヒー 10%OFF'), findsNothing);

    await tester.tap(find.text('使用済み・期限切れ'));
    await tester.pumpAndSettle();
    expect(find.text('夏のアイスコーヒー 10%OFF'), findsOneWidget);
  });

  testWidgets('shows an error with retry, then recovers', (tester) async {
    final repo = _FlakyCouponRepository();
    await tester.pumpWidget(
      buildTestApp(
        overrides: [
          ...await testOverrides(),
          couponRepositoryProvider.overrideWithValue(repo),
        ],
        child: const CouponListScreen(),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('オフラインです'), findsOneWidget);
    expect(find.byType(CouponTicket), findsNothing);

    await tester.tap(find.text('再試行'));
    await tester.pump();
    await tester.pump();
    await tester.pumpAndSettle();

    expect(repo.calls, 2);
    expect(find.text('サイズアップ無料'), findsOneWidget);
    expect(find.byIcon(Icons.wifi_off_rounded), findsNothing);
  });
}
