import 'package:flutter/material.dart';
import '../../../config/clients/api/api_result.dart';
import 'app_empty_view.dart';
import 'app_error_view.dart';
import 'app_loading_view.dart';

class HandleApiState<T> extends StatelessWidget {
  final ApiResult<T> apiResult;
  final Widget child;
  final Widget? shimmerLoader;
  final Widget? emptyView;
  final VoidCallback? retry;

  const HandleApiState({
    super.key,
    required this.apiResult,
    required this.child,
    this.shimmerLoader,
    this.emptyView,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    if (apiResult.isStart) {
      return const SizedBox();
    } else if (apiResult.isLoading) {
      return shimmerLoader ?? const AppLoadingView();
    } else if (apiResult.isEmpty) {
      return emptyView ?? AppEmptyView(emptyText: apiResult.emptyMessage);
    } else if (apiResult.isSuccess) {
      return child;
    } else if (apiResult.isFailure) {
      return AppErrorView(error: apiResult.errorResult, retry: retry);
    } else {
      return const SizedBox(); // fallback (shouldn’t happen ideally)
    }
  }
}
