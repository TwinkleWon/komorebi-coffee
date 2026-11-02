import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) =>
      throw UnimplementedError('sharedPreferencesProvider must be overridden'),
);

final localStoreProvider = Provider<LocalStore>(
  (ref) => LocalStore(ref.watch(sharedPreferencesProvider)),
);

/// Thin JSON wrapper around [SharedPreferences].
///
/// Corrupted entries are treated as missing rather than crashing the app, which
/// matters after schema changes between app versions.
class LocalStore {
  LocalStore(this._prefs);

  final SharedPreferences _prefs;

  Object? readJson(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return null;
    try {
      return jsonDecode(raw);
    } on FormatException {
      return null;
    }
  }

  Future<void> writeJson(String key, Object? value) =>
      _prefs.setString(key, jsonEncode(value));

  Future<void> remove(String key) => _prefs.remove(key);

  Future<void> clear() => _prefs.clear();
}
