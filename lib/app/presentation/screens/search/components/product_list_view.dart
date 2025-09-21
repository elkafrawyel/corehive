import 'package:flutter/material.dart';
import 'package:corehive_store/app/data/models/product_model.dart';

import '../../../widgets/product_cards/search_product_card.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;
  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return SearchProductCard(product: product);
      },
    );
  }
}
