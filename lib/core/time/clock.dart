import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef Clock = DateTime Function();

/// Injectable "now" so time-dependent logic (opening hours, coupon expiry,
/// order status) can be tested deterministically.
final clockProvider = Provider<Clock>((ref) => DateTime.now);

/// Emits the current time periodically for screens that show live status.
final nowTickerProvider = StreamProvider.autoDispose<DateTime>((ref) {
  final clock = ref.watch(clockProvider);
  return Stream.periodic(const Duration(seconds: 5), (_) => clock());
});
