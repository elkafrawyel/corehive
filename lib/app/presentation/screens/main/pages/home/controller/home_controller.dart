import 'package:get/get.dart';
import '../../../../../../domain/repositories/product_repository_base.dart';
import '../../../../../../data/models/product_model.dart';

class HomeController extends GetxController {
  final ProductRepositoryBase productRepo;
  HomeController({required this.productRepo});

  var products = <Product>[].obs;
  var featuredProducts = <Product>[].obs;
  var bestSellers = <Product>[].obs;
  var flashDeals = <Product>[].obs;
  var brands = <Product>[].obs;
  var recentlyViewed = <Product>[].obs;
  var categories = <String>[].obs;
  var subCategoriesMap = <String, List<String>>{}.obs;
  var deliveryAddress = ''.obs;

  @override
  void onInit() {
    super.onInit();
    products.assignAll(productRepo.getAllProducts());
    featuredProducts.assignAll(productRepo.getFeaturedProducts());
    bestSellers.assignAll(productRepo.getBestSellers());
    flashDeals.assignAll(productRepo.getFlashDeals());
    brands.assignAll(productRepo.getBrands());
    recentlyViewed.assignAll(productRepo.getRecentlyViewed());
    categories.assignAll(productRepo.getCategories());
    subCategoriesMap.assignAll(productRepo.getSubCategoriesMap());
    deliveryAddress.value = '123 Main St, City, Country';
  }
}
