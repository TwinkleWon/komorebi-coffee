@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komorebi_coffee/features/auth/domain/app_user.dart';
import 'package:komorebi_coffee/features/coupons/domain/coupon.dart';
import 'package:komorebi_coffee/features/coupons/presentation/coupon_ticket.dart';
import 'package:komorebi_coffee/features/points/domain/point_transaction.dart';
import 'package:komorebi_coffee/features/points/presentation/member_card_screen.dart';

import '../helpers/test_app.dart';

/// Update with: flutter test --update-goldens --tags golden
void main() {
  Future<void> pumpGolden(WidgetTester tester, Widget child) async {
    tester.view.physicalSize = const Size(390, 640) * 2;
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      buildTestApp(
        overrides: await testOverrides(),
        child: Scaffold(
          body: Padding(padding: const EdgeInsets.all(20), child: child),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('coupon tickets in every state', (tester) async {
    Coupon coupon(String id, CouponKind kind, int value, int days,
            {bool used = false}) =>
        Coupon(
          id: id,
          title: 'Coupon $id',
          description: '',
          kind: kind,
          value: value,
          expiresAt: DateTime(
              fixedNow.year, fixedNow.month, fixedNow.day + days, 23, 59),
          usedAt: used ? fixedNow : null,
        );

    await pumpGolden(
      tester,
      Column(
        children: [
          for (final c in [
            coupon('a', CouponKind.percentOff, 20, 7),
            coupon('b', CouponKind.yenOff, 100, 0),
            coupon('c', CouponKind.freeItem, 0, 30),
            coupon('d', CouponKind.sizeUp, 0, 14, used: true),
            coupon('e', CouponKind.percentOff, 10, -3),
          ]) ...[
            CouponTicket(coupon: c, now: fixedNow),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );

    await expectLater(
      find.byType(Column).first,
      matchesGoldenFile('goldens/coupon_tickets.png'),
    );
  });

  testWidgets('member card', (tester) async {
    final user = AppUser(
      id: 'u',
      displayName: 'Hanako',
      memberNumber: '8100123456789012',
      joinedAt: fixedNow,
    );
    final summary = PointSummary.fromTransactions([
      PointTransaction(
        id: 't',
        amount: 640,
        reason: PointReason.orderEarn,
        createdAt: fixedNow,
      ),
    ]);

    await pumpGolden(tester, MemberCard(user: user, summary: summary));

    await expectLater(
      find.byType(MemberCard),
      matchesGoldenFile('goldens/member_card.png'),
    );
  });
}
