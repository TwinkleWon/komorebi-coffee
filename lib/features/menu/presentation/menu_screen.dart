import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/common.dart';
import '../../orders/application/cart_controller.dart';
import '../../orders/presentation/store_picker_sheet.dart';
import '../application/menu_providers.dart';
import '../domain/menu_item.dart';
import 'menu_item_sheet.dart';
import 'product_thumb.dart';

String categoryLabel(AppLocalizations l10n, MenuCategory? category) =>
    switch (category) {
      null => l10n.categoryAll,
      MenuCategory.coffee => l10n.categoryCoffee,
      MenuCategory.tea => l10n.categoryTea,
      MenuCategory.seasonal => l10n.categorySeasonal,
      MenuCategory.food => l10n.categoryFood,
    };

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  MenuCategory? _category;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final menu = ref.watch(menuProvider);
    final cart = ref.watch(cartControllerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: PageTitle(eyebrow: 'Mobile Order', title: l10n.orderTitle),
        actions: [
          IconButton(
            tooltip: l10n.orderHistory,
            onPressed: () => context.push(AppRoutes.orders),
            icon: const Icon(Icons.receipt_long_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: PickupStoreCard(),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                for (final category in [null, ...MenuCategory.values])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(categoryLabel(l10n, category)),
                      selected: _category == category,
                      onSelected: (_) => setState(() => _category = category),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _category == category
                            ? AppColors.paper
                            : AppColors.ink,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: AsyncValueView(
              value: menu,
              onRetry: () => ref.invalidate(menuProvider),
              data: (snapshot) {
                final items = snapshot.data
                    .where((m) => _category == null || m.category == _category)
                    .toList();
                return RefreshIndicator(
                  onRefresh: () =>
                      safeRefresh(() => ref.refresh(menuProvider.future)),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    children: [
                      StaleDataNotice(snapshot: snapshot),
                      ...ListTile.divideTiles(
                        context: context,
                        tiles: items.map((item) => MenuItemTile(item: item)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: cart.isEmpty ? null : const _CartBar(),
    );
  }
}

class MenuItemTile extends StatelessWidget {
  const MenuItemTile({super.key, required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return InkWell(
      onTap: item.available ? () => showMenuItemSheet(context, item) : null,
      child: Opacity(
        opacity: item.available ? 1 : 0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              ProductThumb(item: item),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.isNew || !item.available)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: item.available
                            ? const Pill(
                                label: 'NEW',
                                color: AppColors.matchaSoft,
                                textColor: AppColors.matcha,
                              )
                            : Pill(
                                label: l10n.soldOut,
                                color: AppColors.surfaceMuted,
                                textColor: AppColors.inkMuted,
                              ),
                      ),
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.nameEn,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppTextStyles.serif,
                        fontSize: 12,
                        color: AppColors.inkMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatYen(item.price),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              if (item.available)
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.line),
                  ),
                  child: const Icon(Icons.add_rounded, size: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shows the selected pickup store, or prompts to choose one.
class PickupStoreCard extends ConsumerWidget {
  const PickupStoreCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final store = ref.watch(cartControllerProvider.select((c) => c.store));
    return SurfaceCard(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      onTap: () => showStorePickerSheet(context),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.caramelSoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.storefront_outlined,
                color: AppColors.caramel, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.pickupStore,
                  style:
                      const TextStyle(fontSize: 11, color: AppColors.inkMuted),
                ),
                const SizedBox(height: 2),
                Text(
                  store?.name ?? l10n.selectStoreHint,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight:
                        store == null ? FontWeight.w500 : FontWeight.w700,
                    color: store == null ? AppColors.caramel : AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
          Text(
            store == null ? l10n.selectStore : l10n.changeStore,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.caramel,
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.caramel),
        ],
      ),
    );
  }
}

class _CartBar extends ConsumerWidget {
  const _CartBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final cart = ref.watch(cartControllerProvider);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
        child: Material(
          color: AppColors.espresso,
          shape: const StadiumBorder(),
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: () => context.push(AppRoutes.cart),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 14, 16, 14),
              child: Row(
                children: [
                  const Icon(Icons.shopping_bag_outlined,
                      color: AppColors.paper, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    l10n.viewCart,
                    style: const TextStyle(
                      color: AppColors.paper,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${l10n.itemCount(cart.itemCount)} · ${formatYen(cart.subtotal)}',
                    style: const TextStyle(
                        color: AppColors.caramelSoft, fontSize: 13),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.chevron_right_rounded,
                      color: AppColors.paper),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
