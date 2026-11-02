import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Dark roast background with soft pools of light, like sun filtering
/// through leaves ("komorebi").
class BrandBackdrop extends StatelessWidget {
  const BrandBackdrop({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3A2A20), AppColors.espresso, Color(0xFF1E1713)],
        ),
      ),
      child: Stack(
        children: [
          const _LightSpot(
              alignment: Alignment(-1.1, -0.9), size: 320, opacity: 0.22),
          const _LightSpot(
              alignment: Alignment(1.2, -0.35), size: 220, opacity: 0.14),
          const _LightSpot(
              alignment: Alignment(-0.4, 0.15), size: 140, opacity: 0.10),
          const _LightSpot(
              alignment: Alignment(0.9, 0.9), size: 260, opacity: 0.08),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

class _LightSpot extends StatelessWidget {
  const _LightSpot({
    required this.alignment,
    required this.size,
    required this.opacity,
  });

  final Alignment alignment;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF4C98F).withOpacity(opacity),
          ),
        ),
      ),
    );
  }
}

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 56 : 68,
          height: compact ? 56 : 68,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.caramelSoft.withOpacity(0.5)),
          ),
          child: Icon(
            Icons.eco_outlined,
            color: AppColors.caramelSoft,
            size: compact ? 26 : 30,
          ),
        ),
        SizedBox(height: compact ? 16 : 22),
        Text(
          'KOMOREBI',
          style: AppTextStyles.display(
            compact ? 34 : 44,
            color: AppColors.paper,
          ).copyWith(letterSpacing: 3),
        ),
        const SizedBox(height: 6),
        Text(
          'COFFEE',
          style: AppTextStyles.eyebrow.copyWith(
            color: AppColors.caramelSoft,
            letterSpacing: 9,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
