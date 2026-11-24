import 'package:flutter/material.dart';

import 'catalog_data.dart';
import 'product_collection.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  static const sections = ['Каталог товаров', 'Избранное', 'Профиль'];
  final favorites = <Product>{};
  int section = 0;
  bool grid = true;

  void toggleFavorite(Product product) {
    setState(() {
      if (!favorites.remove(product)) favorites.add(product);
    });
  }

  ProductCollection collection(
    Iterable<Product> items, {
    required bool asGrid,
  }) {
    return ProductCollection(
      items: items.toList(),
      grid: asGrid,
      favorites: favorites,
      onToggle: toggleFavorite,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Category.values.length + 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(sections[section]),
          actions: [
            if (section == 0)
              IconButton(
                tooltip: grid ? 'Показать список' : 'Показать сетку',
                icon: Icon(grid ? Icons.view_list_outlined : Icons.grid_view),
                onPressed: () => setState(() => grid = !grid),
              ),
          ],
          bottom: section == 0
              ? TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    const Tab(text: 'Все товары'),
                    for (final category in Category.values)
                      Tab(text: category.label),
                  ],
                )
              : null,
        ),
        body: SafeArea(
          child: IndexedStack(
            index: section,
            children: [
              TabBarView(
                children: [
                  collection(products, asGrid: grid),
                  for (final category in Category.values)
                    collection(
                      products.where((p) => p.category == category),
                      asGrid: grid,
                    ),
                ],
              ),
              if (favorites.isEmpty)
                const Center(child: Text('В избранном пока нет товаров'))
              else
                collection(favorites, asGrid: false),
              const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_circle_outlined, size: 72),
                    SizedBox(height: 12),
                    Text(
                      'Профиль пользователя',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: section,
          onTap: (index) => setState(() => section = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Избранное',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}
