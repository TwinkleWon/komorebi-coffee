import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mockAssetsProvider =
    Provider<MockAssets>((ref) => MockAssets(rootBundle));

/// Loads the fake API responses bundled under `assets/mock/`.
class MockAssets {
  MockAssets(this._bundle);

  final AssetBundle _bundle;
  final _cache = <String, Future<List<Map<String, dynamic>>>>{};

  Future<List<Map<String, dynamic>>> list(String name) {
    return _cache.putIfAbsent(name, () async {
      final raw = await _bundle.loadString('assets/mock/$name.json');
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    });
  }
}
