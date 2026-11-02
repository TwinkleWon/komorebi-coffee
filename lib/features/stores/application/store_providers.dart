import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/response_cache.dart';
import '../data/store_repository.dart';
import '../domain/cafe_store.dart';

final _codec =
    CacheCodec.listOf<CafeStore>(CafeStore.fromJson, (s) => s.toJson());

final storeListProvider = FutureProvider<Snapshot<List<CafeStore>>>((ref) {
  return ref.watch(responseCacheProvider).fetch(
        key: 'stores',
        request: ref.watch(storeRepositoryProvider).fetchStores,
        codec: _codec,
      );
});

final storeByIdProvider =
    Provider.family<AsyncValue<CafeStore?>, String>((ref, id) {
  return ref.watch(storeListProvider).whenData(
      (snapshot) => snapshot.data.firstWhereOrNull((s) => s.id == id));
});
