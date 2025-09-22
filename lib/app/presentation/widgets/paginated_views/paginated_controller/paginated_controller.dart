import 'package:get/get.dart';
import 'package:corehive_store/app/presentation/widgets/paginated_views/paginated_controller/data/meta.dart';
import '../../../../config/clients/api/api_client.dart';
import '../../../../config/clients/api/api_result.dart';
import 'data/config_data.dart';
import 'data/pagination_response.dart';

class PaginationController<T> extends GetxController {
  PaginationController({this.configData, this.fakeDataGenerator});

  num page = 1;
  num perPage = 15;
  bool isLastPage = false;
  bool _loadingMore = false;
  bool _loadingMoreEnd = false;
  bool paginate = true;

  final _page = 'page';
  final _perPage = 'per_page';
  final _paginate = 'paginate';

  PaginationResponse<T>? paginationResponse;
  List<T> paginationList = [];

  ApiResult _apiResult = const ApiStart();
  ApiResult get apiResult => _apiResult;
  set apiResult(ApiResult value) {
    _apiResult = value;
    update();
  }

  /// Optional API configuration
  ConfigData<T>? configData;

  /// Optional fake data generator
  final List<T> Function()? fakeDataGenerator;

  bool get loadingMore => _loadingMore;
  set loadingMore(bool value) {
    _loadingMore = value;
    update();
  }

  bool get loadingMoreEnd => _loadingMoreEnd;
  set loadingMoreEnd(bool value) {
    _loadingMoreEnd = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    callApi();
  }

  /// Main API call
  Future<ApiResult> callApi({bool loading = true}) async {
    if (loading) apiResult = const ApiLoading();

    final result = configData == null && fakeDataGenerator != null
        ? await _makeFakeRequest(page)
        : await _makeRealRequest(page);

    if (result.isSuccess) {
      paginationResponse = result.dataResult;
      paginationList = paginationResponse?.data ?? [];
      isLastPage = paginationList.length < perPage;

      apiResult = paginationList.isEmpty
          ? ApiEmpty(configData?.emptyListMessage ?? "No data found")
          : ApiSuccess(paginationList);
    } else {
      apiResult = result;
    }

    return apiResult;
  }

  /// Load next page
  Future<ApiResult> callMoreData() async {
    if (loadingMoreEnd || loadingMore) return apiResult;

    if (isLastPage) {
      loadingMoreEnd = true;
      return apiResult;
    }

    page++;
    loadingMore = true;

    final result = configData == null && fakeDataGenerator != null
        ? await _makeFakeRequest(page)
        : await _makeRealRequest(page);

    if (result.isSuccess) {
      paginationResponse = result.dataResult;
      final newData = paginationResponse?.data ?? [];

      isLastPage = newData.length < perPage;
      paginationList.addAll(newData);

      apiResult = paginationList.isEmpty
          ? ApiEmpty(configData?.emptyListMessage ?? "No data found")
          : ApiSuccess(paginationList);
    } else {
      apiResult = result;
    }

    loadingMore = false;
    return apiResult;
  }

  /// Refresh list and restart pagination
  Future<ApiResult> refreshApiCall({bool loading = true}) async {
    page = 1;
    loadingMoreEnd = false;
    loadingMore = false;
    if (loading) paginationList.clear();
    return await callApi(loading: loading);
  }

  /// 🔹 Real API request
  Future<ApiResult> _makeRealRequest(num page) async {
    if (configData == null) return const ApiFailure("Config data not provided");

    if (configData!.isPostRequest) {
      return await APIClient.instance.post<PaginationResponse>(
        endPoint: '${configData!.apiEndPoint}?$_paginate=$paginate',
        fromJson: (json) => PaginationResponse<T>.fromJson(
          (json is Map && json.containsKey('data')) ? json['data'] : json,
          fromJson: configData!.fromJson,
        ),
        requestBody: {
          ...(configData?.parameters ?? {}),
          _page: page,
          _perPage: perPage,
        },
      );
    } else {
      String path =
          '${configData!.apiEndPoint}?$_paginate=$paginate&$_page=$page&$_perPage=$perPage';

      if ((configData?.parameters ?? {}).isNotEmpty) {
        configData!.parameters!.forEach((key, value) {
          path += '&$key=$value';
        });
      }

      return await APIClient.instance.get(
        endPoint: path,
        fromJson: (json) => PaginationResponse<T>.fromJson(
          (json is Map && json.containsKey('data')) ? json['data'] : json,
          fromJson: configData!.fromJson,
        ),
      );
    }
  }

  /// 🔹 Fake data request (for testing)
  Future<ApiResult> _makeFakeRequest(num page) async {
    if (fakeDataGenerator == null) return const ApiFailure("Fake data generator not provided");

    // simulate 2-second network delay
    await Future.delayed(const Duration(seconds: 2));

    final fake = fakeDataGenerator!();

    return ApiSuccess(
      PaginationResponse<T>(
        data: fake,
        meta: Meta(
          lastPage: 999, // fake last page
        ),
      ),
    );
  }
}
