import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';
import '../domain/app_user.dart';

/// Session state: `null` means signed out. While the stored session is being
/// restored the state is loading, which the router maps to the splash screen.
final authControllerProvider =
    AsyncNotifierProvider<AuthController, AppUser?>(AuthController.new);

class AuthController extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() =>
      ref.watch(authRepositoryProvider).restoreSession();

  /// Throws on failure so the login screen can show the error inline while
  /// the session state stays "signed out".
  Future<void> signInWithLine() async {
    final user = await ref.read(authRepositoryProvider).signInWithLine();
    state = AsyncData(user);
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData(null);
  }
}
