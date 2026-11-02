import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mock/mock_assets.dart';
import '../../../core/network/network_simulator.dart';
import '../../../core/time/clock.dart';
import '../domain/news_item.dart';

abstract interface class NewsRepository {
  Future<List<NewsItem>> fetchNews();
}

final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => MockNewsRepository(
    assets: ref.watch(mockAssetsProvider),
    simulator: ref.watch(networkSimulatorProvider),
    clock: ref.watch(clockProvider),
  ),
);

class MockNewsRepository implements NewsRepository {
  MockNewsRepository({
    required MockAssets assets,
    required NetworkSimulator simulator,
    required Clock clock,
  })  : _assets = assets,
        _simulator = simulator,
        _clock = clock;

  final MockAssets _assets;
  final NetworkSimulator _simulator;
  final Clock _clock;

  @override
  Future<List<NewsItem>> fetchNews() => _simulator(() async {
        final rows = await _assets.list('news');
        final now = _clock();
        final today = DateTime(now.year, now.month, now.day, 10);
        return [
          for (final row in rows)
            NewsItem.fromJson({
              ...row,
              'publishedAt': today
                  .subtract(Duration(days: row['daysAgo'] as int))
                  .toIso8601String(),
            }),
        ];
      });
}
