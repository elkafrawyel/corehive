import 'package:get/get.dart';
import 'package:corehive_store/app/data/repositories/product_repository.dart';
import 'package:corehive_store/app/data/models/product_model.dart';
import 'package:corehive_store/app/config/clients/api/api_result.dart';

class SearchController extends GetxController {
  bool isLoadingMore = false;
  static SearchController get to => Get.find();
  void fetchResults() => _fetchResults();
  List<String> get categories => productRepository.getCategories();

  double get minPrice => 0;
  double get maxPrice => 2000;

  double get selectedMinPrice => (filters['minPrice'] ?? minPrice).toDouble();
  double get selectedMaxPrice => (filters['maxPrice'] ?? maxPrice).toDouble();

  List<int> get ratings => [5, 4, 3, 2, 1];
  double get selectedRating => (filters['minRating'] ?? 0).toDouble();

  List<String> get selectedCategories => filters['category'] ?? <String>[];

  void toggleCategory(String cat) {
    List<String> updated = List<String>.from(selectedCategories);
    if (updated.contains(cat)) {
      updated.remove(cat);
    } else {
      updated.add(cat);
    }
    filters['category'] = updated;
    update();
  }

  void setPriceRange(double min, double max) {
    filters['minPrice'] = min.round();
    filters['maxPrice'] = max.round();
    update();
  }

  void setRating(double rating) {
    filters['minRating'] = rating;
    update();
  }

  final ProductRepository productRepository;
  SearchController({required this.productRepository});

  var query = ''.obs;
  var filters = <String, dynamic>{}.obs;
  ApiResult apiResult = ApiStart<List<Product>>();
  int page = 1;
  final int pageSize = 10;
  bool hasMore = true;

  void search(String value) {
    if (value.isEmpty && filters.isEmpty) {
      apiResult = ApiStart();
      update();
    } else {
      query.value = value;
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(query, (_) => _fetchResults());
  }

  void setFilter(String key, dynamic value) {
    if (key == 'category') {
      final selected = filters['category'] ?? <String>[];
      List<String> updated = List<String>.from(selected);
      if (updated.contains(value)) {
        updated.remove(value);
      } else {
        updated.add(value);
      }
      filters['category'] = updated;
    } else {
      filters[key] = value;
    }
    update();
  }

  void clearFilters() {
    filters.clear();
    _fetchResults();
  }

  void _fetchResults({bool reset = true}) {
    if (reset) {
      page = 1;
      hasMore = true;
      apiResult = ApiLoading<List<Product>>();
      update();
    }
    Future.delayed(const Duration(seconds: 2), () {
      final result = productRepository.searchProducts(
        query: query.value,
        filters: filters,
        page: page,
        pageSize: pageSize,
      );
      if (result is ApiSuccess<List<Product>>) {
        final products = result.data;
        hasMore = products.length == pageSize;
        apiResult = result;
      } else {
        hasMore = false;
        apiResult = result;
      }
      update();
    });
  }

  void loadMore() {
    if (!hasMore || apiResult is ApiLoading<List<Product>>) return;
    page++;
    isLoadingMore = true;
    update();
    Future.delayed(const Duration(seconds: 2), () {
      final result = productRepository.searchProducts(
        query: query.value,
        filters: filters,
        page: page,
        pageSize: pageSize,
      );
      if (result is ApiSuccess<List<Product>>) {
        final products = result.data;
        hasMore = products.length == pageSize;
        // Merge with previous results
        final prev = apiResult is ApiSuccess<List<Product>>
            ? (apiResult as ApiSuccess<List<Product>>).data
            : <Product>[];
        apiResult = ApiSuccess<List<Product>>([...prev, ...products]);
      } else {
        hasMore = false;
        apiResult = result;
      }
      isLoadingMore = false;
      update();
    });
  }
}
