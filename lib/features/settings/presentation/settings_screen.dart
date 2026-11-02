import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/dev/dev_settings.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/storage/local_store.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/common.dart';
import '../../auth/application/auth_controller.dart';
import '../../coupons/application/coupon_controller.dart';
import '../../news/application/news_providers.dart';
import '../../orders/application/cart_controller.dart';
import '../../orders/application/order_controllers.dart';
import '../../points/application/points_providers.dart';
import '../../points/domain/member_code.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<bool> _confirm(
    BuildContext context, {
    required String title,
    required String action,
    String? body,
  }) async {
    final l10n = context.l10n;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: body == null ? null : Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel,
                style: const TextStyle(color: AppColors.inkMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(action),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _resetData(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await _confirm(
      context,
      title: l10n.devResetData,
      action: l10n.devResetData,
      body: l10n.devResetConfirm,
    );
    if (!confirmed) return;
    await ref.read(localStoreProvider).clear();
    ref
      ..invalidate(cartControllerProvider)
      ..invalidate(pointSummaryProvider)
      ..invalidate(couponListProvider)
      ..invalidate(orderHistoryProvider)
      ..invalidate(readNewsProvider)
      ..invalidate(devSettingsProvider)
      ..invalidate(appSettingsProvider)
      ..invalidate(authControllerProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(authControllerProvider).valueOrNull;
    final settings = ref.watch(appSettingsProvider);
    final config = ref.watch(appConfigProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: PageTitle(eyebrow: 'Settings', title: l10n.settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        children: [
          if (user != null)
            SurfaceCard(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.caramelSoft,
                    child: Text(
                      user.displayName.characters.first,
                      style:
                          AppTextStyles.display(22, color: AppColors.caramel),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.displayName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${l10n.memberNumber} ${formatMemberNumber(user.memberNumber)}',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.inkMuted),
                        ),
                        const SizedBox(height: 8),
                        Pill(
                          label: l10n.linkedWithLine,
                          color: AppColors.lineBrand.withOpacity(0.12),
                          textColor: const Color(0xFF04833A),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          _Section(
            title: l10n.general,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(l10n.language,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    SegmentedButton<String>(
                      showSelectedIcon: false,
                      style: const ButtonStyle(
                          visualDensity: VisualDensity.compact),
                      segments: const [
                        ButtonSegment(value: 'ja', label: Text('日本語')),
                        ButtonSegment(value: 'en', label: Text('English')),
                      ],
                      selected: {settings.locale.languageCode},
                      onSelectionChanged: (s) => ref
                          .read(appSettingsProvider.notifier)
                          .setLocale(Locale(s.first)),
                    ),
                  ],
                ),
              ),
              SwitchListTile(
                title: Text(l10n.pushNotifications,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(l10n.pushNotificationsSub),
                value: settings.pushNotificationsEnabled,
                onChanged: (v) => ref
                    .read(appSettingsProvider.notifier)
                    .setPushNotificationsEnabled(v),
              ),
              _LinkTile(
                icon: Icons.receipt_long_outlined,
                label: l10n.orderHistory,
                onTap: () => context.push(AppRoutes.orders),
              ),
              _LinkTile(
                icon: Icons.toll_outlined,
                label: l10n.pointsHistory,
                onTap: () => context.push(AppRoutes.points),
              ),
            ],
          ),
          if (config.showDevTools) const _DevToolsSection(),
          _Section(
            title: l10n.aboutApp,
            children: [
              _InfoTile(label: l10n.version, value: '1.0.0'),
              _InfoTile(
                label: l10n.environment,
                value: config.flavor.name.toUpperCase(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                child: Text(
                  l10n.demoNotice,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.inkMuted, height: 1.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          if (config.showDevTools) ...[
            OutlinedButton(
              onPressed: () => _resetData(context, ref),
              child: Text(l10n.devResetData),
            ),
            const SizedBox(height: 12),
          ],
          OutlinedButton(
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.danger),
            onPressed: () async {
              final confirmed = await _confirm(
                context,
                title: l10n.logoutConfirm,
                action: l10n.logout,
              );
              if (confirmed) {
                await ref.read(authControllerProvider.notifier).signOut();
              }
            },
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }
}

class _DevToolsSection extends ConsumerWidget {
  const _DevToolsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final dev = ref.watch(devSettingsProvider);
    final config = ref.watch(appConfigProvider);
    return _Section(
      title: l10n.devTools,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(l10n.devFailureRate,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    '${(dev.failureRate * 100).round()}%',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: AppColors.caramel),
                  ),
                ],
              ),
            ),
            Slider(
              value: dev.failureRate,
              max: 0.5,
              divisions: 10,
              onChanged: (v) =>
                  ref.read(devSettingsProvider.notifier).setFailureRate(v),
            ),
          ],
        ),
        SwitchListTile(
          title: Text(l10n.devSimulateOffline,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(l10n.devSimulateOfflineSub),
          value: dev.simulateOffline,
          onChanged: (v) =>
              ref.read(devSettingsProvider.notifier).setSimulateOffline(v),
        ),
        _InfoTile(label: 'API', value: Uri.parse(config.apiBaseUrl).host),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 10),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.inkMuted,
              ),
            ),
          ),
          SurfaceCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: ListTile.divideTiles(context: context, tiles: children)
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile(
      {required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.caramel),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing:
          const Icon(Icons.chevron_right_rounded, color: AppColors.inkMuted),
      onTap: onTap,
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: Text(value, style: const TextStyle(color: AppColors.inkMuted)),
    );
  }
}
