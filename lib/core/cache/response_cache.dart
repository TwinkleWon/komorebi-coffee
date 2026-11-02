import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error/app_exception.dart';
import '../storage/local_store.dart';
import '../time/clock.dart';

/// Data together with where it came from.
class Snapshot<T> {
  const Snapshot({
    required this.data,
    required this.fetchedAt,
    this.isFromCache = false,
  });

  final T data;
  final DateTime fetchedAt;

  /// `true` when the network request failed and this is the last saved copy.
  final bool isFromCache;

  Snapshot<T> copyWith({T? data}) => Snapshot(
        data: data ?? this.data,
        fetchedAt: fetchedAt,
        isFromCache: isFromCache,
      );
}

/// Converts a value to and from a JSON-compatible structure.
class CacheCodec<T> {
  const CacheCodec({required this.encode, required this.decode});

  final Object? Function(T value) encode;
  final T Function(Object? json) decode;

  static CacheCodec<List<E>> listOf<E>(
    E Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic> Function(E value) toJson,
  ) {
    return CacheCodec(
      encode: (list) => list.map(toJson).toList(),
      decode: (json) => (json! as List)
          .map((e) => fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }
}

final responseCacheProvider = Provider<ResponseCache>(
  (ref) => ResponseCache(
    ref.watch(localStoreProvider),
    clock: ref.watch(clockProvider),
  ),
);

/// Network-first cache: always tries the network, saves successful responses,
/// and falls back to the last saved copy when the failure is transient
/// (offline, timeout, 5xx). Business errors are never masked by the cache.
class ResponseCache {
  ResponseCache(this._store, {required Clock clock}) : _clock = clock;

  final LocalStore _store;
  final Clock _clock;

  static String _storageKey(String key) => 'cache.$key';

  Future<Snapshot<T>> fetch<T>({
    required String key,
    required Future<T> Function() request,
    required CacheCodec<T> codec,
  }) async {
    try {
      final data = await request();
      final now = _clock();
      await _save(key, data, codec, now);
      return Snapshot(data: data, fetchedAt: now);
    } on AppException catch (e) {
      if (!e.isTransient) rethrow;
      final cached = read(key, codec);
      if (cached == null) rethrow;
      return cached;
    }
  }

  /// Replaces the cached copy, e.g. after a successful mutation.
  Future<void> write<T>(String key, T data, CacheCodec<T> codec) =>
      _save(key, data, codec, _clock());

  Snapshot<T>? read<T>(String key, CacheCodec<T> codec) {
    final json = _store.readJson(_storageKey(key));
    if (json is! Map) return null;
    try {
      return Snapshot(
        data: codec.decode(json['data']),
        fetchedAt: DateTime.parse(json['savedAt'] as String),
        isFromCache: true,
      );
    } on Object {
      // A cache entry written by an older schema is simply ignored.
      return null;
    }
  }

  Future<void> _save<T>(String key, T data, CacheCodec<T> codec, DateTime at) {
    return _store.writeJson(_storageKey(key), {
      'savedAt': at.toIso8601String(),
      'data': codec.encode(data),
    });
  }
}
