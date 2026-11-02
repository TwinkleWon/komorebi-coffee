import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/app_theme.dart';
import '../domain/cafe_store.dart';

/// Light, low-contrast basemap that lets the brand markers stand out.
TileLayer storeTileLayer() => TileLayer(
      urlTemplate:
          'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
      subdomains: const ['a', 'b', 'c', 'd'],
      userAgentPackageName: 'com.example.komorebi_coffee',
    );

Widget storeMapAttribution() => const RichAttributionWidget(
      showFlutterMapAttribution: false,
      attributions: [
        TextSourceAttribution('OpenStreetMap contributors'),
        TextSourceAttribution('CARTO'),
      ],
    );

LatLng storeLatLng(CafeStore store) => LatLng(store.latitude, store.longitude);

class StoreMarker extends StatelessWidget {
  const StoreMarker({super.key, required this.selected, this.dimmed = false});

  final bool selected;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.espresso : AppColors.surface,
        border: Border.all(
          color: dimmed ? AppColors.inkMuted : AppColors.caramel,
          width: selected ? 0 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.espresso.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        Icons.local_cafe_rounded,
        size: selected ? 22 : 16,
        color: selected
            ? AppColors.paper
            : dimmed
                ? AppColors.inkMuted
                : AppColors.caramel,
      ),
    );
  }
}
