import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/local_store.dart';

class AppSettings {
  const AppSettings({
    this.locale = const Locale('ja'),
    this.pushNotificationsEnabled = true,
  });

  /// Japanese is the default regardless of the device language.
  final Locale locale;
  final bool pushNotificationsEnabled;

  AppSettings copyWith({Locale? locale, bool? pushNotificationsEnabled}) =>
      AppSettings(
        locale: locale ?? this.locale,
        pushNotificationsEnabled:
            pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      );
}

final appSettingsProvider =
    NotifierProvider<AppSettingsController, AppSettings>(
  AppSettingsController.new,
);

class AppSettingsController extends Notifier<AppSettings> {
  static const _key = 'app_settings';

  @override
  AppSettings build() {
    final json = ref.watch(localStoreProvider).readJson(_key);
    if (json is! Map) return const AppSettings();
    return AppSettings(
      locale: Locale(json['locale'] as String? ?? 'ja'),
      pushNotificationsEnabled: json['push'] as bool? ?? true,
    );
  }

  void setLocale(Locale locale) => _update(state.copyWith(locale: locale));

  // TODO(phase2): register / unregister the FCM token with the backend here.
  void setPushNotificationsEnabled(bool enabled) =>
      _update(state.copyWith(pushNotificationsEnabled: enabled));

  void _update(AppSettings next) {
    state = next;
    ref.read(localStoreProvider).writeJson(_key, {
      'locale': next.locale.languageCode,
      'push': next.pushNotificationsEnabled,
    });
  }
}
