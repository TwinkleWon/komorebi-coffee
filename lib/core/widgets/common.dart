import 'package:flutter/material.dart';

import '../cache/response_cache.dart';
import '../l10n/l10n.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';

/// App bar title: an English eyebrow above the Japanese page name.
class PageTitle extends StatelessWidget {
  const PageTitle({super.key, required this.eyebrow, required this.title});

  final String eyebrow;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(eyebrow.toUpperCase(), style: AppTextStyles.eyebrow),
        const SizedBox(height: 2),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String eyebrow;
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: PageTitle(eyebrow: eyebrow, title: title)),
        if (actionLabel != null)
          TextButton(onPressed: onAction, child: Text(actionLabel!)),
      ],
    );
  }
}

/// Tells the user they are looking at saved data because the last request
/// failed.
class StaleDataNotice extends StatelessWidget {
  const StaleDataNotice({super.key, required this.snapshot});

  final Snapshot<Object?> snapshot;

  @override
  Widget build(BuildContext context) {
    if (!snapshot.isFromCache) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.caramelSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.history_rounded, size: 18, color: AppColors.caramel),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.l10n.staleData(
                formatDateTime(snapshot.fetchedAt, context.l10n.localeName),
              ),
              style: const TextStyle(fontSize: 12.5, color: AppColors.roast),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: AppColors.line),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.inkMuted),
            ),
            if (action != null) ...[const SizedBox(height: 20), action!],
          ],
        ),
      ),
    );
  }
}

/// White rounded container with a hairline border; the base of most cards.
class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppTheme.radius);
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: const BorderSide(color: AppColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.label,
    this.color = AppColors.caramelSoft,
    this.textColor = AppColors.roast,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

/// Wraps an async action with a pull-to-refresh that never throws.
Future<void> safeRefresh(Future<void> Function() action) async {
  try {
    await action();
  } on Object {
    // Errors are rendered by the screen itself.
  }
}
