import 'package:flutter/material.dart';
import 'package:corehive_store/app/presentation/screens/search/components/product_list_empty_view.dart';
import 'package:corehive_store/app/presentation/screens/search/components/product_list_view.dart';
import 'package:corehive_store/app/presentation/screens/search/components/product_list_prompt_view.dart';
import 'package:corehive_store/app/presentation/screens/search/controller/search_controller.dart'
    as ch;
import 'package:get/get.dart';
import 'package:corehive_store/app/presentation/screens/search/components/product_list_shimmer_view.dart';

import '../../../../data/models/product_model.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ch.SearchController>(
      init: ch.SearchController(productRepository: Get.find()),
      dispose: (state) => Get.delete<ch.SearchController>(),
      builder: (controller) {
        final result = controller.apiResult;

        if (result.isStart) {
          return const ProductListPromptView();
        } else if (result.isLoading) {
          return const ProductListShimmerView();
        } else if (result.isEmpty) {
          return const ProductListEmptyView();
        } else if (result.isSuccess) {
          final isLoadingMore = controller.isLoadingMore;
          final products = result.dataResult as List<Product>;

          return Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 100 &&
                      controller.hasMore &&
                      !isLoadingMore) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: ProductListView(products: products),
              ),
              if (isLoadingMore)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: LinearProgressIndicator(
                    minHeight: 4,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
            ],
          );
        } else if (result.isFailure) {
          return const SizedBox();
        } else {
          return const SizedBox(); // fallback
        }
      },
    );
  }
}
