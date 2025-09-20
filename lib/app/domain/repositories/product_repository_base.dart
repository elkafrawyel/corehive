import '../../data/models/product_model.dart';

abstract class ProductRepositoryBase {
  List<Product> getAllProducts();
  List<Product> getFeaturedProducts();
  List<Product> getBestSellers();
  List<Product> getFlashDeals();
  List<Product> getBrands();
  List<Product> getRecentlyViewed();
  List<String> getCategories();
  Map<String, List<String>> getSubCategoriesMap();
}
