import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/error_presenter.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_theme.dart';
import '../application/auth_controller.dart';
import 'brand_backdrop.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _submitting = false;

  Future<void> _signIn() async {
    setState(() => _submitting = true);
    try {
      await ref.read(authControllerProvider.notifier).signInWithLine();
      // The router redirects to home once the session is set.
    } on Object catch (error) {
      if (!mounted) return;
      showErrorSnackBar(context, error, onRetry: _signIn);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: BrandBackdrop(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 20),
            child: Column(
              children: [
                const Spacer(flex: 3),
                const BrandLogo(),
                const SizedBox(height: 28),
                Text(
                  l10n.loginTagline,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.caramelSoft,
                    fontSize: 14,
                    letterSpacing: 1.2,
                    height: 1.8,
                  ),
                ),
                const Spacer(flex: 4),
                _LineButton(
                  label: l10n.loginWithLine,
                  loading: _submitting,
                  onPressed: _submitting ? null : _signIn,
                ),
                const SizedBox(height: 18),
                Text(
                  l10n.loginTerms,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.paper.withOpacity(0.55),
                    fontSize: 11,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.loginDemoNote,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.caramelSoft.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LineButton extends StatelessWidget {
  const _LineButton({
    required this.label,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final bool loading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.lineBrand,
        disabledBackgroundColor: AppColors.lineBrand.withOpacity(0.7),
        foregroundColor: Colors.white,
        disabledForegroundColor: Colors.white,
      ),
      child: loading
          ? const SizedBox.square(
              dimension: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: Colors.white,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chat_bubble_rounded, size: 20),
                const SizedBox(width: 10),
                Text(label),
              ],
            ),
    );
  }
}
