import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komorebi_coffee/core/config/app_config.dart';
import 'package:komorebi_coffee/core/l10n/l10n.dart';
import 'package:komorebi_coffee/core/network/connectivity.dart';
import 'package:komorebi_coffee/core/network/network_simulator.dart';
import 'package:komorebi_coffee/core/storage/local_store.dart';
import 'package:komorebi_coffee/core/theme/app_theme.dart';
import 'package:komorebi_coffee/core/time/clock.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Wednesday morning, when every fixture store is open.
final fixedNow = DateTime(2026, 11, 4, 10, 30);

/// Overrides that make the app deterministic: empty storage, a fixed clock,
/// no latency and no injected failures.
Future<List<Override>> testOverrides({
  Map<String, Object> prefs = const {},
  DateTime? now,
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final instance = await SharedPreferences.getInstance();
  final clock = now ?? fixedNow;
  return [
    appConfigProvider.overrideWithValue(AppConfig.dev),
    sharedPreferencesProvider.overrideWithValue(instance),
    networkSimulatorProvider.overrideWithValue(NetworkSimulator.instant()),
    connectivityStatusProvider.overrideWith((ref) => Stream.value(true)),
    clockProvider.overrideWithValue(() => clock),
  ];
}

Future<ProviderContainer> createTestContainer({
  List<Override> overrides = const [],
  DateTime? now,
}) async {
  final container = ProviderContainer(
    overrides: [...await testOverrides(now: now), ...overrides],
  );
  return container;
}

/// Wraps [child] in the app theme and Japanese localization.
Widget buildTestApp({
  required Widget child,
  required List<Override> overrides,
}) {
  return ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      locale: const Locale('ja'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: child,
    ),
  );
}
