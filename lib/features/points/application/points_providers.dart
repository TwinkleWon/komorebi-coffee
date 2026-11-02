import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/response_cache.dart';
import '../data/point_repository.dart';
import '../domain/point_transaction.dart';

final _codec = CacheCodec<PointSummary>(
  encode: (summary) => summary.toJson(),
  decode: (json) =>
      PointSummary.fromJson(Map<String, dynamic>.from(json! as Map)),
);

final pointSummaryProvider = FutureProvider<Snapshot<PointSummary>>((ref) {
  return ref.watch(responseCacheProvider).fetch(
        key: 'points',
        request: ref.watch(pointRepositoryProvider).fetchSummary,
        codec: _codec,
      );
});
