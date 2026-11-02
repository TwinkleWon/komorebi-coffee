import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon.freezed.dart';
part 'coupon.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum CouponKind { percentOff, yenOff, freeItem, sizeUp }

@freezed
class Coupon with _$Coupon {
  const Coupon._();

  const factory Coupon({
    required String id,
    required String title,
    required String description,
    required CouponKind kind,
    @Default(0) int value,
    required DateTime expiresAt,
    @Default(<String>[]) List<String> conditions,
    DateTime? usedAt,

    /// Code shown to staff after redemption.
    String? redemptionCode,
  }) = _Coupon;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  bool get isUsed => usedAt != null;

  bool isExpiredAt(DateTime now) => now.isAfter(expiresAt);

  bool isAvailableAt(DateTime now) => !isUsed && !isExpiredAt(now);

  /// Calendar days until expiry; 0 means "expires today".
  int daysLeft(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final end = DateTime(expiresAt.year, expiresAt.month, expiresAt.day);
    return end.difference(today).inDays;
  }
}
