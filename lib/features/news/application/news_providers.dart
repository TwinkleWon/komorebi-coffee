import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/cache/response_cache.dart';
import '../../../core/storage/local_store.dart';
import '../data/news_repository.dart';
import '../domain/news_item.dart';

final _codec =
    CacheCodec.listOf<NewsItem>(NewsItem.fromJson, (n) => n.toJson());

final newsProvider = FutureProvider<Snapshot<List<NewsItem>>>((ref) {
  return ref.watch(responseCacheProvider).fetch(
        key: 'news',
        request: ref.watch(newsRepositoryProvider).fetchNews,
        codec: _codec,
      );
});

/// IDs of news items the user has opened. Purely client-side state.
final readNewsProvider =
    NotifierProvider<ReadNewsController, Set<String>>(ReadNewsController.new);

class ReadNewsController extends Notifier<Set<String>> {
  static const _key = 'news.read_ids';

  @override
  Set<String> build() {
    final json = ref.watch(localStoreProvider).readJson(_key);
    return json is List ? json.cast<String>().toSet() : <String>{};
  }

  void markRead(Iterable<String> ids) {
    final next = {...state, ...ids};
    if (next.length == state.length) return;
    state = next;
    ref.read(localStoreProvider).writeJson(_key, next.toList());
  }
}

final unreadNewsCountProvider = Provider<int>((ref) {
  final news = ref.watch(newsProvider).valueOrNull?.data ?? const [];
  final read = ref.watch(readNewsProvider);
  return news.where((n) => !read.contains(n.id)).length;
});
