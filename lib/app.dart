import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/app_config.dart';
import 'core/l10n/l10n.dart';
import 'core/router/app_router.dart';
import 'core/settings/app_settings.dart';
import 'core/theme/app_theme.dart';

class KomorebiApp extends ConsumerWidget {
  const KomorebiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(appSettingsProvider.select((s) => s.locale));
    final flavor = ref.watch(appConfigProvider).flavor;

    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
      builder: (context, child) {
        if (flavor == Flavor.prod) return child!;
        // Corner ribbon so screenshots from dev / stg are never mistaken
        // for production.
        return Banner(
          message: flavor.name.toUpperCase(),
          location: BannerLocation.topEnd,
          textDirection: TextDirection.ltr,
          layoutDirection: TextDirection.ltr,
          color: flavor == Flavor.dev ? AppColors.matcha : AppColors.caramel,
          child: child,
        );
      },
    );
  }
}
