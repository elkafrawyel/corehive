import 'package:get/get.dart';
import 'package:corehive_store/app/data/repositories/product_repository.dart';
import 'package:corehive_store/app/data/models/product_model.dart';

class SearchController extends GetxController {
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
    _fetchResults();
  }

  void setPriceRange(double min, double max) {
    filters['minPrice'] = min.round();
    filters['maxPrice'] = max.round();
    _fetchResults();
  }

  void setRating(double rating) {
    filters['minRating'] = rating;
    _fetchResults();
  }

  final ProductRepository productRepository;
  SearchController({required this.productRepository});

  var query = ''.obs;
  var filters = <String, dynamic>{}.obs;
  var results = <Product>[].obs;

  void search(String value) {
    query.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    debounce(
      query,
      (_) => _fetchResults(),
      time: const Duration(milliseconds: 400),
    );
  }

  void setFilter(String key, dynamic value) {
    if (key == 'category') {
      // Multi-select: value is a String (category)
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
    _fetchResults();
  }

  void clearFilters() {
    filters.clear();
    _fetchResults();
  }

  void _fetchResults() {
    results.value = _searchProducts(query.value, filters);
  }

  List<Product> _searchProducts(String query, Map<String, dynamic> filters) {
    List<Product> products = productRepository.getAllProducts();
    if (query.isNotEmpty) {
      products = products
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    // Multi-select category filter
    if (filters.containsKey('category') &&
        filters['category'] is List<String> &&
        (filters['category'] as List<String>).isNotEmpty) {
      final selectedCategories = filters['category'] as List<String>;
      products = products.where((p) {
        // You may want to match category field if available, here we match title for demo
        return selectedCategories.any(
          (cat) => p.title.toLowerCase().contains(cat.toLowerCase()),
        );
      }).toList();
    }
    // Add more filter logic as needed
    return products;
  }
}
