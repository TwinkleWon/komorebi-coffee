import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/network_simulator.dart';
import '../../../core/storage/local_store.dart';
import '../../../core/time/clock.dart';
import '../../points/data/point_ledger.dart';
import '../domain/app_user.dart';
import 'mock_auth_repository.dart';

abstract interface class AuthRepository {
  /// Returns the signed-in user from a persisted session, if any.
  Future<AppUser?> restoreSession();

  /// Signs in with LINE. Throws an [AppException] on failure.
  Future<AppUser> signInWithLine();

  Future<void> signOut();
}

/// Phase 2: replace with an Amplify / Cognito implementation that federates
/// LINE Login through a custom OIDC identity provider.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => MockAuthRepository(
    simulator: ref.watch(networkSimulatorProvider),
    store: ref.watch(localStoreProvider),
    ledger: ref.watch(pointLedgerProvider),
    clock: ref.watch(clockProvider),
  ),
);
