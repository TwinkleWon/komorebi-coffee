import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/response_cache.dart';
import '../data/menu_repository.dart';
import '../domain/menu_item.dart';

final _codec =
    CacheCodec.listOf<MenuItem>(MenuItem.fromJson, (m) => m.toJson());

final menuProvider = FutureProvider<Snapshot<List<MenuItem>>>((ref) {
  return ref.watch(responseCacheProvider).fetch(
        key: 'menu',
        request: ref.watch(menuRepositoryProvider).fetchMenu,
        codec: _codec,
      );
});
