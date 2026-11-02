import 'dart:math';

import '../../../core/network/network_simulator.dart';
import '../../../core/storage/local_store.dart';
import '../../../core/time/clock.dart';
import '../../points/data/point_ledger.dart';
import '../../points/domain/point_transaction.dart';
import '../domain/app_user.dart';
import 'auth_repository.dart';

/// Simulates LINE Login. The "server-side" account survives sign-out, so
/// signing in again restores the same member and point balance.
class MockAuthRepository implements AuthRepository {
  MockAuthRepository({
    required NetworkSimulator simulator,
    required LocalStore store,
    required PointLedger ledger,
    required Clock clock,
    Random? random,
  })  : _simulator = simulator,
        _store = store,
        _ledger = ledger,
        _clock = clock,
        _random = random ?? Random();

  static const _sessionKey = 'auth.session';
  static const _accountKey = 'mock_server.account';
  static const welcomeBonus = 100;

  final NetworkSimulator _simulator;
  final LocalStore _store;
  final PointLedger _ledger;
  final Clock _clock;
  final Random _random;

  @override
  Future<AppUser?> restoreSession() async {
    // Reading a local token is fast but not instant; keeps the splash visible
    // long enough to not flicker.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    final json = _store.readJson(_sessionKey);
    if (json is! Map) return null;
    return AppUser.fromJson(Map<String, dynamic>.from(json));
  }

  @override
  Future<AppUser> signInWithLine() {
    return _simulator(() async {
      final existing = _store.readJson(_accountKey);
      final user = existing is Map
          ? AppUser.fromJson(Map<String, dynamic>.from(existing))
          : await _register();
      await _store.writeJson(_sessionKey, user.toJson());
      return user;
    });
  }

  @override
  Future<void> signOut() => _store.remove(_sessionKey);

  Future<AppUser> _register() async {
    final now = _clock();
    final digits = List.generate(12, (_) => _random.nextInt(10)).join();
    final user = AppUser(
      id: 'u_${now.microsecondsSinceEpoch}',
      displayName: 'Hanako',
      memberNumber: '8100$digits',
      joinedAt: now,
    );
    await _store.writeJson(_accountKey, user.toJson());
    await _ledger.append(
      PointTransaction(
        id: 'tx_welcome',
        amount: welcomeBonus,
        reason: PointReason.welcome,
        createdAt: now,
      ),
    );
    return user;
  }
}
