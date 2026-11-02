import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komorebi_coffee/features/auth/application/auth_controller.dart';
import 'package:komorebi_coffee/features/auth/presentation/login_screen.dart';
import 'package:komorebi_coffee/features/menu/domain/menu_item.dart';
import 'package:komorebi_coffee/features/menu/presentation/menu_item_sheet.dart';
import 'package:komorebi_coffee/features/orders/application/cart_controller.dart';

import '../helpers/test_app.dart';

const _latte = MenuItem(
  id: 'm_latte',
  name: 'カフェラテ',
  nameEn: 'Caffè Latte',
  description: 'test',
  category: MenuCategory.coffee,
  price: 480,
  customizable: true,
);

void main() {
  testWidgets('menu sheet adds the chosen options to the cart', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      buildTestApp(
        overrides: await testOverrides(),
        child: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showMenuItemSheet(context, _latte),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    // Default M / HOT: ¥530.
    expect(find.text('カートに追加 · ¥530'), findsOneWidget);

    await tester.tap(find.text('L +¥100'));
    await tester.tap(find.text('ICED'));
    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pumpAndSettle();
    expect(find.text('カートに追加 · ¥1,160'), findsOneWidget);

    await tester.tap(find.text('カートに追加 · ¥1,160'));
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(Scaffold).first),
    );
    final line = container.read(cartControllerProvider).lines.single;
    expect(line.size, DrinkSize.l);
    expect(line.temperature, Temperature.iced);
    expect(line.quantity, 2);
    expect(find.text('カートに追加しました'), findsOneWidget);
  });

  testWidgets('LINE login signs the user in', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        overrides: await testOverrides(),
        child: const LoginScreen(),
      ),
    );
    final container = ProviderScope.containerOf(
      tester.element(find.byType(LoginScreen)),
    );
    // Let the session restore (no stored session) finish.
    container.read(authControllerProvider);
    await tester.pump(const Duration(milliseconds: 700));
    expect(container.read(authControllerProvider).valueOrNull, isNull);

    await tester.tap(find.text('LINEでログイン'));
    // Sign-in chains several storage writes; give each one a frame.
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    final user = container.read(authControllerProvider).valueOrNull;
    expect(user, isNotNull);
    expect(user!.memberNumber, hasLength(16));
  });
}
