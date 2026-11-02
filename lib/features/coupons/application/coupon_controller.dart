import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/response_cache.dart';
import '../data/coupon_repository.dart';
import '../domain/coupon.dart';

final couponListProvider =
    AsyncNotifierProvider<CouponListController, Snapshot<List<Coupon>>>(
  CouponListController.new,
);

final couponByIdProvider =
    Provider.family<AsyncValue<Coupon?>, String>((ref, id) {
  return ref.watch(couponListProvider).whenData(
      (snapshot) => snapshot.data.firstWhereOrNull((c) => c.id == id));
});

class CouponListController extends AsyncNotifier<Snapshot<List<Coupon>>> {
  static const _cacheKey = 'coupons';
  static final _codec =
      CacheCodec.listOf<Coupon>(Coupon.fromJson, (c) => c.toJson());

  @override
  Future<Snapshot<List<Coupon>>> build() {
    return ref.watch(responseCacheProvider).fetch(
          key: _cacheKey,
          request: ref.watch(couponRepositoryProvider).fetchCoupons,
          codec: _codec,
        );
  }

  /// Redeems on the server, then patches local state and the offline cache
  /// so the change is visible immediately without a refetch.
  Future<Coupon> redeem(String couponId) async {
    final redeemed = await ref.read(couponRepositoryProvider).redeem(couponId);
    final current = state.valueOrNull;
    if (current != null) {
      final updated = [
        for (final c in current.data) c.id == couponId ? redeemed : c,
      ];
      state = AsyncData(current.copyWith(data: updated));
      await ref.read(responseCacheProvider).write(_cacheKey, updated, _codec);
    }
    return redeemed;
  }
}
