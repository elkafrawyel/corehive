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
        return controller.apiResult.when(
          start: () => const ProductListPromptView(),
          loading: () => const ProductListShimmerView(),
          empty: (String message) {
            return const ProductListEmptyView();
          },
          success: (data) {
            final isLoadingMore = controller.isLoadingMore;
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
                  child: ProductListView(products: data as List<Product>),
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
          },
          failure: (String error, dynamic data) => SizedBox(),
        );
      },
    );
  }
}
