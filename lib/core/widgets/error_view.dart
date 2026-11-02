import 'package:flutter/material.dart';

import '../error/error_presenter.dart';
import '../l10n/l10n.dart';
import '../theme/app_theme.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.error,
    this.onRetry,
    this.compact = false,
  });

  final Object error;
  final VoidCallback? onRetry;

  /// Inline variant for errors inside a card rather than a whole page.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final description = describeError(l10n, error);
    final theme = Theme.of(context);

    if (compact) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(description.icon, color: AppColors.caramel, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(description.title, style: theme.textTheme.bodyMedium),
            ),
            if (onRetry != null)
              TextButton(onPressed: onRetry, child: Text(l10n.retry)),
          ],
        ),
      );
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: AppColors.caramelSoft,
                shape: BoxShape.circle,
              ),
              child: Icon(description.icon, color: AppColors.caramel, size: 32),
            ),
            const SizedBox(height: 20),
            Text(
              description.title,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description.message,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.inkMuted),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
