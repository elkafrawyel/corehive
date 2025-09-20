import 'package:corehive_store/app/presentation/screens/search/components/search_bar.dart'
    as sb;
import 'package:corehive_store/app/presentation/screens/search/components/filter_bottom_sheet.dart';
import 'package:corehive_store/app/presentation/screens/search/components/product_list.dart';
import 'package:corehive_store/app/presentation/widgets/app_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/presentation/screens/search/controller/search_controller.dart'
    as ch;

class SearchScreen extends StatelessWidget {
  final ch.SearchController controller = Get.find<ch.SearchController>();
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: sb.SearchBar(onChanged: controller.search),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: ProductList(controller: controller),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showAppModalBottomSheet(
      context: context,
      child: FilterBottomSheet(controller: controller),
    );
  }
}
