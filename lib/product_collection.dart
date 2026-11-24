import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'catalog_data.dart';

class ProductCollection extends StatelessWidget {
  const ProductCollection({
    super.key,
    required this.items,
    required this.grid,
    required this.favorites,
    required this.onToggle,
  });

  final List<Product> items;
  final bool grid;
  final Set<Product> favorites;
  final ValueChanged<Product> onToggle;

  Widget favoriteButton(Product product) {
    final selected = favorites.contains(product);
    return IconButton(
      tooltip: selected ? 'Убрать из избранного' : 'Добавить в избранное',
      icon: Icon(selected ? Icons.favorite : Icons.favorite_border),
      color: selected ? const Color(0xffa73450) : Colors.black54,
      onPressed: () => onToggle(product),
    );
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    if (!grid) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = items[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            leading: SizedBox(
              width: 60,
              height: 52,
              child: Image.asset(
                product.imageAsset,
                fit: BoxFit.contain,
                excludeFromSemantics: true,
              ),
            ),
            title: Text(product.name, style: titleStyle),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  product.category.icon,
                  size: 16,
                  color: product.category.color,
                ),
                const SizedBox(width: 6),
                Flexible(child: Text(product.priceLabel)),
              ],
            ),
            trailing: favoriteButton(product),
          );
        },
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale = MediaQuery.textScalerOf(context).scale(16) / 16;
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth >= 650 ? 3 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 110 + 90 * math.max(1.0, textScale),
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final product = items[index];
            final category = product.category;
            return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xffdce3dd)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 2),
                            child: Image.asset(
                              product.imageAsset,
                              fit: BoxFit.contain,
                              excludeFromSemantics: true,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: favoriteButton(product),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: titleStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              category.icon,
                              size: 16,
                              color: category.color,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                product.priceLabel,
                                style: TextStyle(color: category.color),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
