import 'package:flutter/material.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../domain/coupon.dart';

/// A paper ticket with punched notches and a perforated divider.
class CouponTicket extends StatelessWidget {
  const CouponTicket({
    super.key,
    required this.coupon,
    required this.now,
    this.onTap,
  });

  static const _stubWidth = 104.0;

  final Coupon coupon;
  final DateTime now;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final available = coupon.isAvailableAt(now);
    final days = coupon.daysLeft(now);
    final urgent = available && days <= 1;

    final status = coupon.isUsed
        ? l10n.couponUsed
        : coupon.isExpiredAt(now)
            ? l10n.couponExpired
            : null;

    return ClipPath(
      clipper: const TicketClipper(notchX: _stubWidth),
      child: Material(
        color: AppColors.surface,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: _stubWidth,
                  color: available
                      ? AppColors.caramelSoft
                      : AppColors.surfaceMuted,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: CouponValue(coupon: coupon, muted: !available),
                  ),
                ),
                const _Perforation(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          coupon.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.5,
                            height: 1.4,
                            color:
                                available ? AppColors.ink : AppColors.inkMuted,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 14,
                              color: urgent
                                  ? AppColors.danger
                                  : AppColors.inkMuted,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                status ??
                                    '${l10n.couponExpiresOn(formatDate(coupon.expiresAt, l10n.localeName))}'
                                        ' · ${l10n.couponDaysLeft(days)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: urgent
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: urgent
                                      ? AppColors.danger
                                      : AppColors.inkMuted,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

/// The big value label on the ticket stub ("20%OFF", "¥100", "FREE").
class CouponValue extends StatelessWidget {
  const CouponValue({
    super.key,
    required this.coupon,
    this.muted = false,
    this.scale = 1,
  });

  final Coupon coupon;
  final bool muted;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final color = muted ? AppColors.inkMuted : AppColors.roast;
    final (main, sub) = switch (coupon.kind) {
      CouponKind.percentOff => ('${coupon.value}%', 'OFF'),
      CouponKind.yenOff => (formatYen(coupon.value), 'OFF'),
      CouponKind.freeItem => ('FREE', 'DRINK'),
      CouponKind.sizeUp => ('SIZE', 'UP'),
    };
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(main, style: AppTextStyles.display(26 * scale, color: color)),
          const SizedBox(height: 2),
          Text(
            sub,
            style: AppTextStyles.eyebrow.copyWith(
              color: color,
              fontSize: 11 * scale,
              letterSpacing: 3,
            ),
          ),
        ],
      ),
    );
  }
}

/// Dashed vertical line. Painted rather than laid out so it works inside
/// [IntrinsicHeight].
class _Perforation extends StatelessWidget {
  const _Perforation();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 1,
      child: CustomPaint(painter: _DashPainter()),
    );
  }
}

class _DashPainter extends CustomPainter {
  const _DashPainter();

  static const _dash = 4.0;
  static const _gap = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.line
      ..strokeWidth = size.width;
    final x = size.width / 2;
    for (var y = 12.0; y < size.height - 12; y += _dash + _gap) {
      canvas.drawLine(Offset(x, y), Offset(x, y + _dash), paint);
    }
  }

  @override
  bool shouldRepaint(_DashPainter oldDelegate) => false;
}

/// Rounded rectangle with semicircular notches at the top and bottom of the
/// perforation line.
class TicketClipper extends CustomClipper<Path> {
  const TicketClipper({required this.notchX, this.radius = 18, this.notch = 9});

  final double notchX;
  final double radius;
  final double notch;

  @override
  Path getClip(Size size) {
    final body = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );
    final holes = Path()
      ..addOval(Rect.fromCircle(center: Offset(notchX, 0), radius: notch))
      ..addOval(
        Rect.fromCircle(center: Offset(notchX, size.height), radius: notch),
      );
    return Path.combine(PathOperation.difference, body, holes);
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) =>
      oldClipper.notchX != notchX ||
      oldClipper.radius != radius ||
      oldClipper.notch != notch;
}
