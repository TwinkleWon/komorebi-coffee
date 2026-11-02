import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../storage/local_store.dart';

class DevSettings {
  const DevSettings({required this.failureRate, this.simulateOffline = false});

  final double failureRate;
  final bool simulateOffline;

  DevSettings copyWith({double? failureRate, bool? simulateOffline}) =>
      DevSettings(
        failureRate: failureRate ?? this.failureRate,
        simulateOffline: simulateOffline ?? this.simulateOffline,
      );
}

final devSettingsProvider =
    NotifierProvider<DevSettingsController, DevSettings>(
  DevSettingsController.new,
);

/// Runtime knobs for demoing error handling. Hidden in the prod flavor.
class DevSettingsController extends Notifier<DevSettings> {
  static const _key = 'dev_settings';

  @override
  DevSettings build() {
    final defaults = DevSettings(
      failureRate: ref.watch(appConfigProvider).defaultFailureRate,
    );
    final json = ref.watch(localStoreProvider).readJson(_key);
    if (json is! Map) return defaults;
    return DevSettings(
      failureRate:
          (json['failureRate'] as num?)?.toDouble() ?? defaults.failureRate,
      simulateOffline: json['simulateOffline'] as bool? ?? false,
    );
  }

  void setFailureRate(double value) =>
      _update(state.copyWith(failureRate: value));

  void setSimulateOffline(bool value) =>
      _update(state.copyWith(simulateOffline: value));

  void _update(DevSettings next) {
    state = next;
    ref.read(localStoreProvider).writeJson(_key, {
      'failureRate': next.failureRate,
      'simulateOffline': next.simulateOffline,
    });
  }
}
