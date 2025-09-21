import 'package:flutter/material.dart';
import 'package:corehive_store/app/data/models/product_model.dart';
import 'package:corehive_store/app/presentation/screens/search/components/search_product_card.dart';

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
