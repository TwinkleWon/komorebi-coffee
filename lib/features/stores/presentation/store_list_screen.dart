import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/cache/response_cache.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/clock.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/common.dart';
import '../application/store_providers.dart';
import '../domain/cafe_store.dart';
import 'store_map.dart';
import 'store_widgets.dart';

class StoreListScreen extends ConsumerWidget {
  const StoreListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = ref.watch(storeListProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: PageTitle(eyebrow: 'Stores', title: context.l10n.storesTitle),
      ),
      body: AsyncValueView(
        value: stores,
        onRetry: () => ref.invalidate(storeListProvider),
        data: (snapshot) => _StoresBody(snapshot: snapshot),
      ),
    );
  }
}

class _StoresBody extends ConsumerStatefulWidget {
  const _StoresBody({required this.snapshot});

  final Snapshot<List<CafeStore>> snapshot;

  @override
  ConsumerState<_StoresBody> createState() => _StoresBodyState();
}

class _StoresBodyState extends ConsumerState<_StoresBody> {
  final _mapController = MapController();
  String? _selectedId;

  void _focus(CafeStore store) {
    setState(() => _selectedId = store.id);
    _mapController.move(storeLatLng(store), 14);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stores = widget.snapshot.data;
    final now = ref.watch(clockProvider)();

    return RefreshIndicator(
      onRefresh: () => safeRefresh(() => ref.refresh(storeListProvider.future)),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  height: 240,
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCameraFit: CameraFit.coordinates(
                        coordinates: stores.map(storeLatLng).toList(),
                        padding: const EdgeInsets.all(36),
                      ),
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                      ),
                      onTap: (_, __) => setState(() => _selectedId = null),
                    ),
                    children: [
                      storeTileLayer(),
                      MarkerLayer(
                        markers: [
                          for (final store in stores)
                            Marker(
                              point: storeLatLng(store),
                              width: store.id == _selectedId ? 44 : 32,
                              height: store.id == _selectedId ? 44 : 32,
                              child: GestureDetector(
                                onTap: () => _focus(store),
                                child: StoreMarker(
                                  selected: store.id == _selectedId,
                                  dimmed: !store.isOpenAt(now),
                                ),
                              ),
                            ),
                        ],
                      ),
                      storeMapAttribution(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: StaleDataNotice(snapshot: widget.snapshot)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            sliver: SliverList.separated(
              itemCount: stores.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final store = stores[index];
                return StoreTile(
                  store: store,
                  now: now,
                  selected: store.id == _selectedId,
                  onTap: () => context.push(AppRoutes.store(store.id)),
                  onLocate: () => _focus(store),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StoreTile extends StatelessWidget {
  const StoreTile({
    super.key,
    required this.store,
    required this.now,
    required this.onTap,
    this.onLocate,
    this.selected = false,
  });

  final CafeStore store;
  final DateTime now;
  final VoidCallback onTap;
  final VoidCallback? onLocate;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radius + 1),
        border: Border.all(
          color: selected ? AppColors.caramel : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: SurfaceCard(
        padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.area.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.inkMuted,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    store.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OpenStatusLabel(store: store, now: now),
                ],
              ),
            ),
            CongestionMeter(level: store.congestion),
            if (onLocate != null) ...[
              const SizedBox(width: 6),
              IconButton(
                onPressed: onLocate,
                icon: const Icon(Icons.my_location_rounded, size: 20),
                color: AppColors.inkMuted,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
