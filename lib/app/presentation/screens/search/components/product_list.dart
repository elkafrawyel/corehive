import 'package:flutter/material.dart';
import 'package:corehive_store/app/presentation/screens/search/components/search_product_card.dart';
import 'package:corehive_store/app/presentation/screens/search/controller/search_controller.dart'
    as ch;
import 'package:get/get.dart';

class ProductList extends StatelessWidget {
  final ch.SearchController controller;
  const ProductList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final results = controller.results;
      if (results.isEmpty) {
        return const Center(child: Text('No products found'));
      }
      return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final product = results[index];
          return SearchProductCard(product: product);
        },
      );
    });
  }
}
