import 'package:flutter/material.dart';

import '../../../../../../data/models/product_model.dart';
import 'product_card.dart';

class HorizontalListView extends StatelessWidget {
  final List<Product> products;
  const HorizontalListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product, isInHorizontalList: true);
        },
      ),
    );
  }
}
