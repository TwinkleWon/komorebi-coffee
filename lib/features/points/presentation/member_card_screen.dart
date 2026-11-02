import 'dart:async';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/clock.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/skeleton.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/domain/app_user.dart';
import '../application/points_providers.dart';
import '../domain/member_code.dart';
import '../domain/point_transaction.dart';
import 'point_widgets.dart';

class MemberCardScreen extends ConsumerWidget {
  const MemberCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(authControllerProvider).valueOrNull;
    final summary = ref.watch(pointSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: PageTitle(eyebrow: 'Membership', title: l10n.cardTitle),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            safeRefresh(() => ref.refresh(pointSummaryProvider.future)),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
          children: [
            if (user != null)
              MemberCard(user: user, summary: summary.valueOrNull?.data),
            const SizedBox(height: 14),
            Text(
              l10n.cardInstruction,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppColors.inkMuted),
            ),
            const SizedBox(height: 24),
            summary.when(
              skipLoadingOnRefresh: !summary.hasError,
              skipError: summary.hasValue,
              data: (snapshot) => Column(
                children: [
                  StaleDataNotice(snapshot: snapshot),
                  _RankProgressCard(summary: snapshot.data),
                ],
              ),
              loading: () =>
                  const Skeleton(height: 120, radius: AppTheme.radius),
              error: (error, _) => SurfaceCard(
                padding: EdgeInsets.zero,
                child: ErrorView(
                  error: error,
                  compact: true,
                  onRetry: () => ref.invalidate(pointSummaryProvider),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SurfaceCard(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              onTap: () => context.push(AppRoutes.points),
              child: Row(
                children: [
                  const Icon(Icons.receipt_long_outlined,
                      color: AppColors.caramel),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      l10n.pointsHistory,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded,
                      color: AppColors.inkMuted),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The physical-card look: dark roast with a white code panel.
class MemberCard extends StatelessWidget {
  const MemberCard({super.key, required this.user, this.summary});

  final AppUser user;
  final PointSummary? summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF55402F), AppColors.espresso],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.espresso.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'KOMOREBI',
                style: AppTextStyles.display(20, color: AppColors.paper)
                    .copyWith(letterSpacing: 2.5),
              ),
              const Spacer(),
              if (summary != null) RankBadge(rank: summary!.rank),
            ],
          ),
          const SizedBox(height: 18),
          MemberCodePanel(memberNumber: user.memberNumber),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  user.displayName,
                  style: const TextStyle(
                    color: AppColors.paper,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              if (summary != null)
                PointsText(points: summary!.balance, size: 26),
            ],
          ),
        ],
      ),
    );
  }
}

/// QR + barcode that rotate every minute, with a countdown.
class MemberCodePanel extends ConsumerStatefulWidget {
  const MemberCodePanel({super.key, required this.memberNumber});

  final String memberNumber;

  @override
  ConsumerState<MemberCodePanel> createState() => _MemberCodePanelState();
}

class _MemberCodePanelState extends ConsumerState<MemberCodePanel> {
  late MemberCode _code;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _code = _current();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _code = _current());
    });
  }

  MemberCode _current() =>
      MemberCode.at(widget.memberNumber, ref.read(clockProvider)());

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final progress = _code.secondsRemaining / MemberCode.period.inSeconds;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: BarcodeWidget(
              key: ValueKey(_code.payload),
              barcode: Barcode.qrCode(),
              data: _code.payload,
              width: 168,
              height: 168,
              color: AppColors.espresso,
              drawText: false,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox.square(
                dimension: 14,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 2,
                  backgroundColor: AppColors.line,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                l10n.cardRefreshIn(_code.secondsRemaining),
                style:
                    const TextStyle(fontSize: 11.5, color: AppColors.inkMuted),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BarcodeWidget(
            barcode: Barcode.code128(),
            data: widget.memberNumber,
            height: 54,
            color: AppColors.espresso,
            drawText: false,
          ),
          const SizedBox(height: 8),
          Text(
            formatMemberNumber(widget.memberNumber),
            style: const TextStyle(
              fontSize: 13,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _RankProgressCard extends StatelessWidget {
  const _RankProgressCard({required this.summary});

  final PointSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final next = summary.rank.next;
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RankBadge(rank: summary.rank, onDark: false),
              const Spacer(),
              Text(
                l10n.lifetimePoints(formatPoints(summary.lifetimeEarned)),
                style: const TextStyle(fontSize: 12, color: AppColors.inkMuted),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: summary.rankProgress,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            next == null
                ? l10n.topRank
                : l10n.nextRank(
                    next.label,
                    formatPoints(summary.pointsToNextRank!),
                  ),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
