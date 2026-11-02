import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/time/clock.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../stores/application/store_providers.dart';
import '../../stores/presentation/store_widgets.dart';
import '../application/cart_controller.dart';

Future<void> showStorePickerSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (_) => const StorePickerSheet(),
  );
}

class StorePickerSheet extends ConsumerWidget {
  const StorePickerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final stores = ref.watch(storeListProvider);
    final selectedId =
        ref.watch(cartControllerProvider.select((c) => c.store?.id));
    final now = ref.watch(clockProvider)();

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: Text(l10n.selectStore,
                style: Theme.of(context).textTheme.titleLarge),
          ),
          Flexible(
            child: AsyncValueView(
              value: stores,
              onRetry: () => ref.invalidate(storeListProvider),
              data: (snapshot) => ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                itemCount: snapshot.data.length,
                separatorBuilder: (_, __) =>
                    const Divider(indent: 12, endIndent: 12),
                itemBuilder: (context, index) {
                  final store = snapshot.data[index];
                  final enabled = store.mobileOrder;
                  return ListTile(
                    enabled: enabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    title: Text(
                      store.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: enabled
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: OpenStatusLabel(store: store, now: now),
                            )
                          : Text(
                              l10n.storeNoMobileOrder,
                              style: const TextStyle(fontSize: 12),
                            ),
                    ),
                    trailing: store.id == selectedId
                        ? const Icon(Icons.check_circle_rounded,
                            color: AppColors.matcha)
                        : null,
                    onTap: () {
                      ref
                          .read(cartControllerProvider.notifier)
                          .selectStore(store);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
