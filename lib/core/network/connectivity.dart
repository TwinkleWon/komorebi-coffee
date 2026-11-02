import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dev/dev_settings.dart';

/// Raw connectivity reported by the OS.
final connectivityStatusProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();
  yield _hasNetwork(await connectivity.checkConnectivity());
  yield* connectivity.onConnectivityChanged.map(_hasNetwork);
});

bool _hasNetwork(List<ConnectivityResult> results) =>
    results.any((r) => r != ConnectivityResult.none);

/// Effective online state, combining the OS status with the dev-tools
/// "simulate offline" switch.
final isOnlineProvider = Provider<bool>((ref) {
  final simulateOffline =
      ref.watch(devSettingsProvider.select((s) => s.simulateOffline));
  if (simulateOffline) return false;
  // Assume online until the platform answers, so the first frame never
  // flashes an offline banner.
  return ref.watch(connectivityStatusProvider).valueOrNull ?? true;
});
