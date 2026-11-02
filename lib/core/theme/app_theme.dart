import 'package:flutter/material.dart';

/// Warm, paper-like palette inspired by roasted beans and afternoon light.
abstract final class AppColors {
  static const paper = Color(0xFFF6F1EA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFEEE6DC);
  static const espresso = Color(0xFF2B211B);
  static const roast = Color(0xFF4A3628);
  static const ink = Color(0xFF2B211B);
  static const inkMuted = Color(0xFF8C8077);
  static const line = Color(0xFFE5DCD1);
  static const caramel = Color(0xFFB8794B);
  static const caramelSoft = Color(0xFFF1E1D1);
  static const matcha = Color(0xFF6F8460);
  static const matchaSoft = Color(0xFFE3E9DA);
  static const danger = Color(0xFFB0503C);
  static const lineBrand = Color(0xFF06C755);
}

abstract final class AppTextStyles {
  static const serif = 'DMSerifDisplay';

  /// Small English label shown above Japanese headings ("COUPON", "STORES").
  static const eyebrow = TextStyle(
    fontFamily: serif,
    fontSize: 12,
    letterSpacing: 2.4,
    height: 1.2,
    color: AppColors.caramel,
  );

  static TextStyle display(double size, {Color color = AppColors.ink}) =>
      TextStyle(
        fontFamily: serif,
        fontSize: size,
        height: 1.1,
        letterSpacing: 0.4,
        color: color,
      );
}

abstract final class AppTheme {
  static const radius = 20.0;

  static ThemeData light() {
    const scheme = ColorScheme.light(
      primary: AppColors.espresso,
      onPrimary: AppColors.paper,
      secondary: AppColors.caramel,
      onSecondary: Colors.white,
      tertiary: AppColors.matcha,
      surface: AppColors.paper,
      onSurface: AppColors.ink,
      onSurfaceVariant: AppColors.inkMuted,
      surfaceContainerLowest: AppColors.surface,
      surfaceContainerLow: AppColors.surface,
      surfaceContainer: AppColors.surface,
      surfaceContainerHigh: AppColors.surfaceMuted,
      surfaceContainerHighest: AppColors.surfaceMuted,
      outline: AppColors.line,
      outlineVariant: AppColors.line,
      error: AppColors.danger,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.paper,
      splashFactory: InkSparkle.splashFactory,
    );

    final text = base.textTheme.apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    );

    return base.copyWith(
      textTheme: text.copyWith(
        titleLarge: text.titleLarge?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
        titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        bodyMedium: text.bodyMedium?.copyWith(height: 1.55),
        bodySmall: text.bodySmall?.copyWith(color: AppColors.inkMuted),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.paper,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 20,
        titleTextStyle: TextStyle(
          color: AppColors.ink,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.espresso,
          foregroundColor: AppColors.paper,
          disabledBackgroundColor: AppColors.line,
          minimumSize: const Size.fromHeight(54),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.line, width: 1.2),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.caramel,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          side: const WidgetStatePropertyAll(
            BorderSide(color: AppColors.line),
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.espresso
                : AppColors.surface,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.paper
                : AppColors.ink,
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.espresso,
        side: const BorderSide(color: AppColors.line),
        shape: const StadiumBorder(),
        labelStyle: const TextStyle(
          color: AppColors.ink,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: const TextStyle(
          color: AppColors.paper,
          fontWeight: FontWeight.w600,
        ),
        showCheckmark: false,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.caramelSoft,
        height: 68,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? AppColors.ink
                : AppColors.inkMuted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.ink
                : AppColors.inkMuted,
          ),
        ),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: AppColors.ink,
        unselectedLabelColor: AppColors.inkMuted,
        indicatorColor: AppColors.espresso,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: AppColors.line,
        labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.matcha
              : AppColors.line,
        ),
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.caramel,
        thumbColor: AppColors.caramel,
        inactiveTrackColor: AppColors.line,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.line,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.espresso,
        contentTextStyle: TextStyle(color: AppColors.paper),
        actionTextColor: AppColors.caramelSoft,
        shape: StadiumBorder(),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: AppColors.line,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.caramel,
        linearTrackColor: AppColors.line,
      ),
    );
  }
}
