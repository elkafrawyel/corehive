import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:corehive_store/app/config/theme/color_extension.dart';
import '../../../config/clients/storage/storage_client.dart';
import '../app_data_state/handel_api_state.dart';
import '../app_text.dart';
import 'paginated_controller/data/config_data.dart';
import 'paginated_controller/paginated_controller.dart';

class AppPaginatedListview<T> extends StatefulWidget {
  final Widget Function(T item) child;
  final Widget? shimmerLoading;
  final Widget? emptyView;

  /// Optional API config
  final ConfigData<T>? configData;

  /// Optional fake data generator (only used when configData == null)
  final List<T> Function()? fakeDataGenerator;

  const AppPaginatedListview({
    super.key,
    required this.child,
    this.configData,
    this.fakeDataGenerator,
    this.shimmerLoading,
    this.emptyView,
  });

  @override
  State<AppPaginatedListview<T>> createState() =>
      AppPaginatedListviewState<T>();
}

class AppPaginatedListviewState<T> extends State<AppPaginatedListview<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Get.find<PaginationController<T>>().callMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Refresh API manually
  void refreshApi({bool loading = true}) {
    Get.find<PaginationController<T>>().refreshApiCall(loading: loading);
  }

  /// Update a single item (requires equality operator on model)
  void updateSingleItem(T item) {
    final controller = Get.find<PaginationController<T>>();
    final index =
    controller.paginationList.indexWhere((element) => element == item);
    if (index != -1) {
      controller.paginationList[index] = item;
      controller.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaginationController<T>>(
      init: PaginationController<T>(
        configData: widget.configData,
        fakeDataGenerator: widget.fakeDataGenerator,
      ),
      builder: (controller) {
        return HandleApiState(
          apiResult: controller.apiResult,
          emptyView: widget.emptyView,
          shimmerLoader: widget.shimmerLoading == null
              ? null
              : ListView.builder(
            controller: _scrollController,
            itemCount: 10,
            itemBuilder: (_, __) => widget.shimmerLoading!,
          ),
          child: RefreshIndicator(
            backgroundColor: context.kPrimaryColor,
            color: context.kColorOnPrimary,
            onRefresh: controller.refreshApiCall,
            child: controller.apiResult.isEmpty
                ? widget.emptyView ?? const SizedBox()
                : ListView.builder(
              controller: _scrollController,
              itemCount: controller.paginationList.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.paginationList.length) {
                  return widget.child(controller.paginationList[index]);
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 12),
                    child: Center(
                      child: controller.loadingMoreEnd
                          ? _loadingMoreEndView(context)
                          : controller.loadingMore
                          ? _loadingMoreView(context)
                          : const SizedBox(),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _loadingMoreView(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      const SizedBox(width: 10),
      AppText(
        text: StorageClient().isAr()
            ? 'يتم تحميل مزيد من البيانات'
            : 'Loading more data...',
        fontWeight: FontWeight.w700,
        color: context.kHintTextColor,
      ),
    ],
  );

  Widget _loadingMoreEndView(BuildContext context) => AppText(
    text: StorageClient().isAr()
        ? 'لا يوجد المزيد من البيانات'
        : 'End of the data',
    fontWeight: FontWeight.w700,
    color: context.kHintTextColor,
  );
}
