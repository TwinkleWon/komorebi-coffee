import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../orders/application/cart_controller.dart';
import '../../orders/domain/cart.dart';
import '../domain/menu_item.dart';
import 'product_thumb.dart';

Future<void> showMenuItemSheet(BuildContext context, MenuItem item) {
  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (_) => MenuItemSheet(item: item),
  );
}

class MenuItemSheet extends ConsumerStatefulWidget {
  const MenuItemSheet({super.key, required this.item});

  final MenuItem item;

  @override
  ConsumerState<MenuItemSheet> createState() => _MenuItemSheetState();
}

class _MenuItemSheetState extends ConsumerState<MenuItemSheet> {
  late DrinkSize? _size = widget.item.customizable ? DrinkSize.m : null;
  late Temperature? _temperature =
      widget.item.customizable ? Temperature.hot : null;
  int _quantity = 1;

  CartLine get _line => CartLine(
        item: widget.item,
        size: _size,
        temperature: _temperature,
        quantity: _quantity,
      );

  void _addToCart() {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    ref.read(cartControllerProvider.notifier).add(_line);
    Navigator.pop(context);
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.addedToCart),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final item = widget.item;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: ProductThumb(item: item, size: 132)),
            const SizedBox(height: 20),
            Text(item.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 2),
            Text(
              item.nameEn,
              style: const TextStyle(
                fontFamily: AppTextStyles.serif,
                color: AppColors.inkMuted,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.description,
              style: const TextStyle(
                  color: AppColors.roast, height: 1.7, fontSize: 13.5),
            ),
            if (item.kcal != null) ...[
              const SizedBox(height: 6),
              Text(
                '${item.kcal} kcal',
                style: const TextStyle(color: AppColors.inkMuted, fontSize: 12),
              ),
            ],
            if (item.customizable) ...[
              const SizedBox(height: 22),
              _OptionLabel(l10n.size),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<DrinkSize>(
                  showSelectedIcon: false,
                  segments: [
                    for (final size in DrinkSize.values)
                      ButtonSegment(
                        value: size,
                        label: Text(
                          size.priceDelta == 0
                              ? size.label
                              : '${size.label} +${formatYen(size.priceDelta)}',
                        ),
                      ),
                  ],
                  selected: {_size!},
                  onSelectionChanged: (s) => setState(() => _size = s.first),
                ),
              ),
              const SizedBox(height: 16),
              _OptionLabel(l10n.temperature),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<Temperature>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(
                      value: Temperature.hot,
                      label: Text('HOT'),
                      icon:
                          Icon(Icons.local_fire_department_outlined, size: 18),
                    ),
                    ButtonSegment(
                      value: Temperature.iced,
                      label: Text('ICED'),
                      icon: Icon(Icons.ac_unit_rounded, size: 18),
                    ),
                  ],
                  selected: {_temperature!},
                  onSelectionChanged: (s) =>
                      setState(() => _temperature = s.first),
                ),
              ),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Text(l10n.quantity,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const Spacer(),
                QuantityStepper(
                  value: _quantity,
                  min: 1,
                  onChanged: (v) => setState(() => _quantity = v),
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _addToCart,
              child: Text(l10n.addToCart(formatYen(_line.total))),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionLabel extends StatelessWidget {
  const _OptionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 20,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(999),
        color: AppColors.surface,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: value > min ? () => onChanged(value - 1) : null,
            icon: Icon(
                value == 1 && min == 0
                    ? Icons.delete_outline_rounded
                    : Icons.remove_rounded,
                size: 18),
          ),
          SizedBox(
            width: 24,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: value < max ? () => onChanged(value + 1) : null,
            icon: const Icon(Icons.add_rounded, size: 18),
          ),
        ],
      ),
    );
  }
}
