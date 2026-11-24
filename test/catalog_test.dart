import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/catalog_data.dart';
import 'package:flutter_application_4/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('У каждого товара есть отдельное фото в ресурсах приложения', () async {
    expect(
      products.map((p) => p.imageAsset).toSet(),
      hasLength(products.length),
    );
    for (final product in products) {
      final data = await rootBundle.load(product.imageAsset);
      final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
      final frame = await codec.getNextFrame();
      expect(frame.image.width, greaterThan(0), reason: product.name);
      frame.image.dispose();
      codec.dispose();
    }
  });

  testWidgets('Категории и избранное работают в обоих видах каталога', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 780));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const MainApp());

    final grid = tester.widget<GridView>(find.byType(GridView).first);
    expect(grid.childrenDelegate.estimatedChildCount, 18);
    for (final category in Category.values) {
      final tab = find.widgetWithText(Tab, category.label);
      await tester.ensureVisible(tab);
      await tester.tap(tab);
      await tester.pumpAndSettle();
      final items = products.where((p) => p.category == category);
      expect(items.length, 3);
      for (final product in items) {
        expect(find.text(product.name).hitTestable(), findsOneWidget);
        expect(find.text(product.priceLabel).hitTestable(), findsOneWidget);
      }
    }

    const name = 'Геймпад Xbox';
    await tester.tap(
      find.byTooltip('Добавить в избранное').hitTestable().first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Показать список'));
    await tester.pumpAndSettle();
    expect(find.byType(Divider).hitTestable(), findsNWidgets(2));
    expect(
      find.byTooltip('Убрать из избранного').hitTestable(),
      findsOneWidget,
    );
    await tester.tap(find.text('Избранное'));
    await tester.pumpAndSettle();
    expect(find.text(name).hitTestable(), findsOneWidget);
    await tester.tap(find.byTooltip('Убрать из избранного').hitTestable());
    await tester.pumpAndSettle();
    expect(
      find.text('В избранном пока нет товаров').hitTestable(),
      findsOneWidget,
    );
    await tester.tap(find.text('Главная'));
    await tester.pumpAndSettle();
    expect(find.text(name).hitTestable(), findsOneWidget);
    expect(
      find.byTooltip('Добавить в избранное').hitTestable(),
      findsNWidgets(3),
    );
    await tester.tap(find.text('Профиль'));
    await tester.pumpAndSettle();
    expect(find.text('Профиль пользователя').hitTestable(), findsOneWidget);
  });
}
