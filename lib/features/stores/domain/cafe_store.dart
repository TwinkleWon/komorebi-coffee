import 'package:freezed_annotation/freezed_annotation.dart';

part 'cafe_store.freezed.dart';
part 'cafe_store.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum StoreFeature { wifi, power, terrace, roastery }

enum Congestion { low, moderate, high }

@freezed
class BusinessHours with _$BusinessHours {
  const BusinessHours._();

  /// [open] and [close] are "HH:mm". "24:00" closes at midnight.
  const factory BusinessHours({required String open, required String close}) =
      _BusinessHours;

  factory BusinessHours.fromJson(Map<String, dynamic> json) =>
      _$BusinessHoursFromJson(json);

  int get openMinutes => _toMinutes(open);
  int get closeMinutes => _toMinutes(close);
  bool get isAllDay => openMinutes == 0 && closeMinutes >= 24 * 60;

  static int _toMinutes(String hhmm) {
    final parts = hhmm.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }
}

@freezed
class CafeStore with _$CafeStore {
  const CafeStore._();

  const factory CafeStore({
    required String id,
    required String name,
    required String area,
    required String address,
    required String phone,
    required double latitude,
    required double longitude,
    required BusinessHours weekdayHours,
    required BusinessHours weekendHours,
    @Default(<StoreFeature>[]) List<StoreFeature> features,
    @Default(true) bool mobileOrder,

    /// Live estimate from the server; `null` while closed.
    Congestion? congestion,
  }) = _CafeStore;

  factory CafeStore.fromJson(Map<String, dynamic> json) =>
      _$CafeStoreFromJson(json);

  BusinessHours hoursOn(DateTime day) =>
      day.weekday >= DateTime.saturday ? weekendHours : weekdayHours;

  bool isOpenAt(DateTime time) {
    final hours = hoursOn(time);
    final minutes = time.hour * 60 + time.minute;
    return minutes >= hours.openMinutes && minutes < hours.closeMinutes;
  }

  /// Opening time to display while closed: today's if it is still ahead,
  /// otherwise tomorrow's.
  String nextOpeningTime(DateTime now) {
    final today = hoursOn(now);
    if (now.hour * 60 + now.minute < today.openMinutes) return today.open;
    return hoursOn(now.add(const Duration(days: 1))).open;
  }
}
