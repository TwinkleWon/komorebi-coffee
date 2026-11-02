import 'dart:math';

import '../../../core/error/app_exception.dart';
import '../../../core/mock/mock_assets.dart';
import '../../../core/network/network_simulator.dart';
import '../../../core/storage/local_store.dart';
import '../../../core/time/clock.dart';
import '../domain/coupon.dart';
import 'coupon_repository.dart';

/// Reads coupons from `assets/mock/coupons.json` and keeps redemptions on the
/// device, standing in for server-side state.
class MockCouponRepository implements CouponRepository {
  MockCouponRepository({
    required MockAssets assets,
    required NetworkSimulator simulator,
    required LocalStore store,
    required Clock clock,
    Random? random,
  })  : _assets = assets,
        _simulator = simulator,
        _store = store,
        _clock = clock,
        _random = random ?? Random();

  static const _redemptionsKey = 'mock_server.coupon_redemptions';

  final MockAssets _assets;
  final NetworkSimulator _simulator;
  final LocalStore _store;
  final Clock _clock;
  final Random _random;

  @override
  Future<List<Coupon>> fetchCoupons() => _simulator(_loadAll);

  @override
  Future<Coupon> redeem(String couponId) {
    return _simulator(() async {
      final coupons = await _loadAll();
      final coupon = coupons.where((c) => c.id == couponId).firstOrNull;
      if (coupon == null) throw const NotFoundException();
      if (coupon.isUsed) throw const CouponAlreadyUsedException();
      final now = _clock();
      if (coupon.isExpiredAt(now)) throw const CouponExpiredException();

      final redeemed = coupon.copyWith(
        usedAt: now,
        redemptionCode: _newCode(),
      );
      await _store.writeJson(_redemptionsKey, {
        ..._redemptions(),
        couponId: {
          'usedAt': now.toIso8601String(),
          'code': redeemed.redemptionCode,
        },
      });
      return redeemed;
    });
  }

  Future<List<Coupon>> _loadAll() async {
    final rows = await _assets.list('coupons');
    final redemptions = _redemptions();
    final now = _clock();
    return [
      for (final row in rows)
        _toCoupon(row, now, redemptions[row['id']] as Map?),
    ];
  }

  /// The fixture stores expiry relative to today so the demo never goes
  /// stale; this mimics the shape a real API would return.
  Coupon _toCoupon(Map<String, dynamic> row, DateTime now, Map? redemption) {
    final days = row['expiresInDays'] as int;
    final expiresAt = DateTime(now.year, now.month, now.day + days, 23, 59, 59);
    return Coupon.fromJson({
      ...row,
      'expiresAt': expiresAt.toIso8601String(),
      if (redemption != null) ...{
        'usedAt': redemption['usedAt'],
        'redemptionCode': redemption['code'],
      },
    });
  }

  Map<String, dynamic> _redemptions() {
    final json = _store.readJson(_redemptionsKey);
    return json is Map ? Map<String, dynamic>.from(json) : {};
  }

  String _newCode() => 'KMB-${1000 + _random.nextInt(9000)}';
}
