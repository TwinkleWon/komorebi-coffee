import 'package:flutter_test/flutter_test.dart';
import 'package:komorebi_coffee/features/coupons/domain/coupon.dart';
import 'package:komorebi_coffee/features/orders/domain/order.dart';
import 'package:komorebi_coffee/features/points/domain/member_code.dart';
import 'package:komorebi_coffee/features/points/domain/point_transaction.dart';
import 'package:komorebi_coffee/features/stores/domain/cafe_store.dart';

void main() {
  group('CafeStore opening hours', () {
    const store = CafeStore(
      id: 's',
      name: 'Test',
      area: 'Shibuya',
      address: '',
      phone: '',
      latitude: 0,
      longitude: 0,
      weekdayHours: BusinessHours(open: '07:00', close: '22:00'),
      weekendHours: BusinessHours(open: '09:00', close: '20:00'),
    );
    final wednesday = DateTime(2026, 11, 4);
    final saturday = DateTime(2026, 11, 7);

    test('uses weekday and weekend hours', () {
      expect(store.isOpenAt(wednesday.add(const Duration(hours: 7))), isTrue);
      expect(store.isOpenAt(saturday.add(const Duration(hours: 8))), isFalse);
      expect(store.isOpenAt(saturday.add(const Duration(hours: 9))), isTrue);
    });

    test('closing time is exclusive', () {
      expect(store.isOpenAt(wednesday.add(const Duration(hours: 22))), isFalse);
    });

    test('next opening time is today before opening, tomorrow after closing',
        () {
      expect(store.nextOpeningTime(wednesday.add(const Duration(hours: 6))),
          '07:00');
      expect(
        store.nextOpeningTime(DateTime(2026, 11, 6, 23)), // Friday night
        '09:00', // Saturday hours
      );
    });

    test('24h stores are always open', () {
      const allDay = BusinessHours(open: '00:00', close: '24:00');
      final s = store.copyWith(weekdayHours: allDay);
      expect(allDay.isAllDay, isTrue);
      expect(s.isOpenAt(DateTime(2026, 11, 4, 23, 59)), isTrue);
      expect(s.isOpenAt(DateTime(2026, 11, 4, 0, 0)), isTrue);
    });
  });

  group('Coupon', () {
    final now = DateTime(2026, 11, 4, 15);
    Coupon coupon(DateTime expiresAt) => Coupon(
          id: 'c',
          title: '',
          description: '',
          kind: CouponKind.yenOff,
          expiresAt: expiresAt,
        );

    test('expires at the end of its last day', () {
      final c = coupon(DateTime(2026, 11, 4, 23, 59, 59));
      expect(c.daysLeft(now), 0);
      expect(c.isAvailableAt(now), isTrue);
      expect(c.isAvailableAt(DateTime(2026, 11, 5)), isFalse);
    });

    test('used coupons are not available', () {
      final c = coupon(DateTime(2026, 12, 1)).copyWith(usedAt: now);
      expect(c.isAvailableAt(now), isFalse);
    });
  });

  group('PointSummary', () {
    PointTransaction tx(int amount, int minute) => PointTransaction(
          id: '$amount-$minute',
          amount: amount,
          reason: amount > 0 ? PointReason.orderEarn : PointReason.orderSpend,
          createdAt: DateTime(2026, 11, 4, 10, minute),
        );

    test('balance subtracts spending but lifetime does not', () {
      final s =
          PointSummary.fromTransactions([tx(300, 0), tx(-100, 1), tx(250, 2)]);
      expect(s.balance, 450);
      expect(s.lifetimeEarned, 550);
      expect(s.rank, MemberRank.roast);
      expect(s.pointsToNextRank, 950);
      expect(s.transactions.first.createdAt.minute, 2, reason: 'newest first');
    });

    test('rank thresholds', () {
      expect(MemberRank.fromLifetimePoints(0), MemberRank.bean);
      expect(MemberRank.fromLifetimePoints(499), MemberRank.bean);
      expect(MemberRank.fromLifetimePoints(500), MemberRank.roast);
      expect(MemberRank.fromLifetimePoints(1500), MemberRank.reserve);
      expect(MemberRank.reserve.next, isNull);
    });
  });

  group('MemberCode', () {
    const number = '8100123456789012';

    test('is stable within a window and rotates after it', () {
      final t0 = DateTime.utc(2026, 11, 4, 10, 0, 0);
      final a = MemberCode.at(number, t0);
      final b = MemberCode.at(number, t0.add(const Duration(seconds: 59)));
      final c = MemberCode.at(number, t0.add(const Duration(seconds: 60)));
      expect(a.payload, b.payload);
      expect(a.payload, isNot(c.payload));
      expect(a.secondsRemaining, 60);
      expect(b.secondsRemaining, 1);
    });

    test('formats the member number in groups of four', () {
      expect(formatMemberNumber(number), '8100 1234 5678 9012');
    });
  });

  group('Order status', () {
    final created = DateTime(2026, 11, 4, 10);
    final order = Order(
      id: 'o',
      number: 101,
      storeId: 's',
      storeName: '',
      lines: const [],
      subtotal: 0,
      total: 0,
      createdAt: created,
      pickupAt: created.add(const Duration(minutes: 5)),
    );

    test('moves from received to preparing to ready', () {
      expect(order.statusAt(created), OrderStatus.received);
      expect(order.statusAt(created.add(const Duration(minutes: 2))),
          OrderStatus.preparing);
      expect(order.statusAt(created.add(const Duration(minutes: 5))),
          OrderStatus.ready);
    });
  });
}
