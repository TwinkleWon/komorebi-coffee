import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_assets.dart';
import '../../../core/network/network_simulator.dart';
import '../../../core/storage/local_store.dart';
import '../../../core/time/clock.dart';
import '../domain/coupon.dart';
import 'mock_coupon_repository.dart';

abstract interface class CouponRepository {
  Future<List<Coupon>> fetchCoupons();

  /// Marks the coupon as used and returns it with a redemption code.
  /// Throws [CouponAlreadyUsedException] / [CouponExpiredException].
  Future<Coupon> redeem(String couponId);
}

/// When the API is ready, this is the only line that changes:
/// `return ApiCouponRepository(ref.watch(apiClientProvider));`
final couponRepositoryProvider = Provider<CouponRepository>(
  (ref) => MockCouponRepository(
    assets: ref.watch(mockAssetsProvider),
    simulator: ref.watch(networkSimulatorProvider),
    store: ref.watch(localStoreProvider),
    clock: ref.watch(clockProvider),
  ),
);
