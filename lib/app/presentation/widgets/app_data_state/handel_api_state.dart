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
    return apiResult.when(
      start: () => const SizedBox(),
      loading: () => shimmerLoader ?? const AppLoadingView(),
      empty: (message) => emptyView ?? AppEmptyView(emptyText: message),
      success: (_) => child,
      failure: (message, _) => AppErrorView(
        error: message,
        retry: retry,
      ),
    );
  }
}
