import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/clock.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/common.dart';
import '../../orders/application/cart_controller.dart';
import '../application/store_providers.dart';
import '../domain/cafe_store.dart';
import 'store_map.dart';
import 'store_widgets.dart';

class StoreDetailScreen extends ConsumerWidget {
  const StoreDetailScreen({super.key, required this.storeId});

  final String storeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final store = ref.watch(storeByIdProvider(storeId));
    final now = ref.watch(clockProvider)();
    final current = store.valueOrNull;

    return Scaffold(
      appBar: AppBar(),
      body: AsyncValueView(
        value: store,
        onRetry: () => ref.invalidate(storeListProvider),
        data: (store) => store == null
            ? EmptyState(
                icon: Icons.search_off_rounded,
                message: l10n.errorNotFound,
              )
            : _StoreDetailBody(store: store, now: now),
      ),
      bottomNavigationBar: current == null
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: current.mobileOrder
                    ? FilledButton.icon(
                        onPressed: () {
                          ref
                              .read(cartControllerProvider.notifier)
                              .selectStore(current);
                          context.go(AppRoutes.order);
                        },
                        icon: const Icon(Icons.local_cafe_outlined, size: 20),
                        label: Text(l10n.storeOrderHere),
                      )
                    : Text(
                        l10n.storeNoMobileOrder,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: AppColors.inkMuted, fontSize: 13),
                      ),
              ),
            ),
    );
  }
}

class _StoreDetailBody extends StatelessWidget {
  const _StoreDetailBody({required this.store, required this.now});

  final CafeStore store;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SizedBox(
            height: 180,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: storeLatLng(store),
                initialZoom: 15.5,
                interactionOptions:
                    const InteractionOptions(flags: InteractiveFlag.none),
              ),
              children: [
                storeTileLayer(),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: storeLatLng(store),
                      width: 44,
                      height: 44,
                      child: const StoreMarker(selected: true),
                    ),
                  ],
                ),
                storeMapAttribution(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(store.area.toUpperCase(), style: AppTextStyles.eyebrow),
        const SizedBox(height: 4),
        Text(store.name,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24)),
        const SizedBox(height: 10),
        OpenStatusLabel(store: store, now: now),
        const SizedBox(height: 24),
        SurfaceCard(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.congestionTitle,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.inkMuted),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      congestionLabel(l10n, store.congestion),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: store.congestion == null
                            ? AppColors.inkMuted
                            : congestionColor(store.congestion),
                      ),
                    ),
                  ],
                ),
              ),
              CongestionMeter(
                  level: store.congestion, showLabel: false, scale: 1.6),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionLabel(
                  icon: Icons.schedule_rounded, label: l10n.storeHours),
              const SizedBox(height: 12),
              _HoursRow(
                  label: l10n.weekdays, hours: store.weekdayHours, l10n: l10n),
              const SizedBox(height: 6),
              _HoursRow(
                  label: l10n.weekends, hours: store.weekendHours, l10n: l10n),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),
              _SectionLabel(
                  icon: Icons.place_outlined, label: l10n.storeAddress),
              const SizedBox(height: 8),
              Text(store.address, style: const TextStyle(fontSize: 14)),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(),
              ),
              _SectionLabel(icon: Icons.call_outlined, label: l10n.storePhone),
              const SizedBox(height: 8),
              Text(store.phone, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(l10n.storeFeatures,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final feature in store.features)
              _FeatureChip(
                  icon: featureIcon(feature),
                  label: featureLabel(l10n, feature)),
            if (store.mobileOrder)
              _FeatureChip(
                icon: Icons.phone_iphone_rounded,
                label: l10n.featureMobileOrder,
              ),
          ],
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.caramel),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.inkMuted),
        ),
      ],
    );
  }
}

class _HoursRow extends StatelessWidget {
  const _HoursRow(
      {required this.label, required this.hours, required this.l10n});

  final String label;
  final BusinessHours hours;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(fontSize: 14))),
        Text(
          hours.isAllDay ? l10n.storeOpen24h : '${hours.open} – ${hours.close}',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ],
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.roast),
          const SizedBox(width: 6),
          Text(label,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
