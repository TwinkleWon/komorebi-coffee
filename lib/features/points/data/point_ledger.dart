import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/local_store.dart';
import '../domain/point_transaction.dart';

final pointLedgerProvider = Provider<PointLedger>(
  (ref) => PointLedger(ref.watch(localStoreProvider)),
);

/// Plays the role of the backend's point database while there is no API.
///
/// Persisted on the device so balances and history survive app restarts.
/// Mock repositories write to it; the UI never touches it directly.
class PointLedger {
  PointLedger(this._store);

  static const _key = 'mock_server.point_ledger';

  final LocalStore _store;

  List<PointTransaction> all() {
    final json = _store.readJson(_key);
    if (json is! List) return [];
    return json
        .map((e) =>
            PointTransaction.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  int get balance => all().fold(0, (sum, t) => sum + t.amount);

  Future<void> append(PointTransaction transaction) async {
    final current = all();
    // Ledger writes are idempotent by transaction id.
    if (current.any((t) => t.id == transaction.id)) return;
    await _store.writeJson(
      _key,
      [...current, transaction].map((t) => t.toJson()).toList(),
    );
  }
}
