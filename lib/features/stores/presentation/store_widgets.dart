import 'package:flutter/material.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_theme.dart';
import '../domain/cafe_store.dart';

/// "Open · until 22:00" with a status dot.
class OpenStatusLabel extends StatelessWidget {
  const OpenStatusLabel({super.key, required this.store, required this.now});

  final CafeStore store;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final open = store.isOpenAt(now);
    final hours = store.hoursOn(now);
    final label = hours.isAllDay
        ? l10n.storeOpen24h
        : open
            ? l10n.storeOpenUntil(hours.close)
            : l10n.storeClosedOpensAt(store.nextOpeningTime(now));
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: open ? AppColors.matcha : AppColors.inkMuted,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: open ? AppColors.matcha : AppColors.inkMuted,
          ),
        ),
      ],
    );
  }
}

String congestionLabel(AppLocalizations l10n, Congestion? level) =>
    switch (level) {
      Congestion.low => l10n.congestionLow,
      Congestion.moderate => l10n.congestionModerate,
      Congestion.high => l10n.congestionHigh,
      null => l10n.congestionClosed,
    };

Color congestionColor(Congestion? level) => switch (level) {
      Congestion.low => AppColors.matcha,
      Congestion.moderate => AppColors.caramel,
      Congestion.high => AppColors.danger,
      null => AppColors.line,
    };

/// Three ascending bars, filled according to the crowd level.
class CongestionMeter extends StatelessWidget {
  const CongestionMeter({
    super.key,
    required this.level,
    this.showLabel = true,
    this.scale = 1,
  });

  final Congestion? level;
  final bool showLabel;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final filled = level == null ? 0 : level!.index + 1;
    final color = congestionColor(level);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (var i = 0; i < 3; i++)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 1.5 * scale),
                width: 6 * scale,
                height: (8 + i * 6) * scale,
                decoration: BoxDecoration(
                  color: i < filled ? color : AppColors.line,
                  borderRadius: BorderRadius.circular(3 * scale),
                ),
              ),
          ],
        ),
        if (showLabel) ...[
          const SizedBox(height: 6),
          Text(
            congestionLabel(context.l10n, level),
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: level == null ? AppColors.inkMuted : color,
            ),
          ),
        ],
      ],
    );
  }
}

String featureLabel(AppLocalizations l10n, StoreFeature feature) =>
    switch (feature) {
      StoreFeature.wifi => l10n.featureWifi,
      StoreFeature.power => l10n.featurePower,
      StoreFeature.terrace => l10n.featureTerrace,
      StoreFeature.roastery => l10n.featureRoastery,
    };

IconData featureIcon(StoreFeature feature) => switch (feature) {
      StoreFeature.wifi => Icons.wifi_rounded,
      StoreFeature.power => Icons.power_outlined,
      StoreFeature.terrace => Icons.deck_outlined,
      StoreFeature.roastery => Icons.local_fire_department_outlined,
    };
