import 'package:flutter_test/flutter_test.dart';
import 'package:komorebi_coffee/core/cache/response_cache.dart';
import 'package:komorebi_coffee/core/error/app_exception.dart';
import 'package:komorebi_coffee/core/storage/local_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late ResponseCache cache;
  final codec = CacheCodec<List<String>>(
    encode: (v) => v,
    decode: (json) => (json! as List).cast<String>(),
  );
  var now = DateTime(2026, 11, 4, 9);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final store = LocalStore(await SharedPreferences.getInstance());
    cache = ResponseCache(store, clock: () => now);
  });

  test('returns fresh data and saves it', () async {
    final result = await cache.fetch(
      key: 'k',
      request: () async => ['a'],
      codec: codec,
    );

    expect(result.data, ['a']);
    expect(result.isFromCache, isFalse);
    expect(cache.read('k', codec)?.data, ['a']);
  });

  test('falls back to the saved copy on a transient failure', () async {
    await cache.fetch(key: 'k', request: () async => ['saved'], codec: codec);
    final savedAt = now;
    now = now.add(const Duration(hours: 1));

    final result = await cache.fetch<List<String>>(
      key: 'k',
      request: () => throw const NetworkException(),
      codec: codec,
    );

    expect(result.data, ['saved']);
    expect(result.isFromCache, isTrue);
    expect(result.fetchedAt, savedAt);
  });

  test('rethrows when nothing is cached', () {
    expect(
      cache.fetch<List<String>>(
        key: 'empty',
        request: () => throw const RequestTimeoutException(),
        codec: codec,
      ),
      throwsA(isA<RequestTimeoutException>()),
    );
  });

  test('never hides business errors behind the cache', () async {
    await cache.fetch(key: 'k', request: () async => ['saved'], codec: codec);

    expect(
      cache.fetch<List<String>>(
        key: 'k',
        request: () => throw const CouponExpiredException(),
        codec: codec,
      ),
      throwsA(isA<CouponExpiredException>()),
    );
  });

  test('4xx responses are not treated as transient', () {
    expect(const ServerException(404).isTransient, isFalse);
    expect(const ServerException(503).isTransient, isTrue);
  });
}
