import 'package:flutter/material.dart';

import '../domain/menu_item.dart';

/// Illustrated stand-in for product photography: a tinted tile with a soft
/// highlight and a category glyph.
class ProductThumb extends StatelessWidget {
  const ProductThumb({super.key, required this.item, this.size = 76});

  final MenuItem item;
  final double size;

  static IconData iconFor(MenuCategory category) => switch (category) {
        MenuCategory.coffee => Icons.coffee_rounded,
        MenuCategory.tea => Icons.emoji_food_beverage_rounded,
        MenuCategory.seasonal => Icons.local_cafe_rounded,
        MenuCategory.food => Icons.bakery_dining_rounded,
      };

  static Color toneOf(MenuItem item) =>
      Color(int.parse('FF${item.tone}', radix: 16));

  @override
  Widget build(BuildContext context) {
    final tone = toneOf(item);
    final light = Color.lerp(tone, Colors.white, 0.55)!;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.26),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [light, tone],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -size * 0.15,
            top: -size * 0.2,
            child: Container(
              width: size * 0.7,
              height: size * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.18),
              ),
            ),
          ),
          Center(
            child: Icon(
              iconFor(item.category),
              size: size * 0.42,
              color: Colors.white.withOpacity(0.92),
            ),
          ),
        ],
      ),
    );
  }
}
