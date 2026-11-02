import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/error/error_presenter.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../application/points_providers.dart';
import '../domain/point_transaction.dart';

/// Dark card on the home screen with the point balance and a shortcut to the
/// member card.
class PointSummaryCard extends ConsumerWidget {
  const PointSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final summary = ref.watch(pointSummaryProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 20, 16, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.roast, AppColors.espresso],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: summary.when(
              skipLoadingOnRefresh: !summary.hasError,
              skipError: summary.hasValue,
              data: (snapshot) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        l10n.pointsBalance,
                        style: const TextStyle(
                          color: AppColors.caramelSoft,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      RankBadge(rank: snapshot.data.rank),
                    ],
                  ),
                  const SizedBox(height: 6),
                  PointsText(points: snapshot.data.balance),
                ],
              ),
              loading: () => const SizedBox(
                height: 58,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              error: (error, _) => Row(
                children: [
                  Flexible(
                    child: Text(
                      describeError(l10n, error).title,
                      style: const TextStyle(color: AppColors.paper),
                    ),
                  ),
                  TextButton(
                    onPressed: () => ref.invalidate(pointSummaryProvider),
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: AppColors.paper.withOpacity(0.1),
            shape: const StadiumBorder(),
            child: InkWell(
              customBorder: const StadiumBorder(),
              onTap: () => context.go(AppRoutes.card),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.qr_code_2_rounded,
                        color: AppColors.paper, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      l10n.showMemberCard,
                      style: const TextStyle(
                        color: AppColors.paper,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PointsText extends StatelessWidget {
  const PointsText({
    super.key,
    required this.points,
    this.size = 38,
    this.color = AppColors.paper,
  });

  final int points;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(formatPoints(points),
            style: AppTextStyles.display(size, color: color)),
        const SizedBox(width: 4),
        Text(
          'pt',
          style:
              AppTextStyles.display(size * 0.42, color: color.withOpacity(0.8)),
        ),
      ],
    );
  }
}

class RankBadge extends StatelessWidget {
  const RankBadge({super.key, required this.rank, this.onDark = true});

  final MemberRank rank;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final color = onDark ? AppColors.caramelSoft : AppColors.caramel;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.6)),
      ),
      child: Text(
        rank.label,
        style: AppTextStyles.eyebrow.copyWith(
          color: color,
          fontSize: 10,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
