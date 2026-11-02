import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Flavor { dev, stg, prod }

/// Build-time configuration for each flavor.
///
/// Each `main_<flavor>.dart` entrypoint passes one of the presets below to
/// [bootstrap], which injects it through [appConfigProvider].
class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.apiBaseUrl,
    required this.defaultFailureRate,
  });

  final Flavor flavor;

  /// Base URL of the real API (used once mock repositories are replaced).
  final String apiBaseUrl;

  /// Probability that a simulated request fails. Lets reviewers see the
  /// loading / error / retry states without touching any code.
  final double defaultFailureRate;

  bool get showDevTools => flavor != Flavor.prod;

  static const dev = AppConfig(
    flavor: Flavor.dev,
    apiBaseUrl: 'https://api.dev.komorebi-coffee.example',
    defaultFailureRate: 0.15,
  );

  static const stg = AppConfig(
    flavor: Flavor.stg,
    apiBaseUrl: 'https://api.stg.komorebi-coffee.example',
    defaultFailureRate: 0.05,
  );

  static const prod = AppConfig(
    flavor: Flavor.prod,
    apiBaseUrl: 'https://api.komorebi-coffee.example',
    defaultFailureRate: 0,
  );
}

final appConfigProvider = Provider<AppConfig>(
  (ref) => throw UnimplementedError('appConfigProvider must be overridden'),
);
