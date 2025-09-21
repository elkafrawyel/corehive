import 'package:flutter/material.dart';
import 'package:corehive_store/app/presentation/screens/search/components/product_list_empty_view.dart';
import 'package:corehive_store/app/presentation/screens/search/components/product_list_view.dart';
import 'package:corehive_store/app/presentation/screens/search/components/product_list_prompt_view.dart';
import 'package:corehive_store/app/presentation/screens/search/controller/search_controller.dart'
    as ch;
import 'package:get/get.dart';
import 'package:corehive_store/app/presentation/screens/search/components/product_list_shimmer_view.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ch.SearchController>(
      init: ch.SearchController(productRepository: Get.find()),
      dispose: (state) => Get.delete<ch.SearchController>(),
      builder: (controller) {
        final results = controller.results;
        final hasQuery = controller.query.value.isNotEmpty;
        final hasFilters = controller.filters.isNotEmpty;
        final isLoading = controller.isLoading.value;
        if (isLoading) {
          return const ProductListShimmerView();
        }
        if (results.isEmpty && (hasQuery || hasFilters)) {
          return const ProductListEmptyView();
        } else if (results.isEmpty) {
          return const ProductListPromptView();
        }
        return ProductListView(products: results);
      },
    );
  }
}
