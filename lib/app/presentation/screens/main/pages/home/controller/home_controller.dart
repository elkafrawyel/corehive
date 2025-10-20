import 'package:corehive_store/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';
import '../../../../../../data/models/product_model.dart';
import '../../../../../../data/models/user_model.dart';
import '../../../../../../data/repositories/product_repository.dart';

class HomeController extends GetxController {
  final ProductRepository productRepo;
  final UserRepository userRepository;
  HomeController({required this.productRepo, required this.userRepository});
  static HomeController get to => Get.find<HomeController>();

  var products = <Product>[].obs;
  var featuredProducts = <Product>[].obs;
  var bestSellers = <Product>[].obs;
  var flashDeals = <Product>[].obs;
  var brands = <Product>[].obs;
  var recentlyViewed = <Product>[].obs;
  var categories = <String>[].obs;
  var subCategoriesMap = <String, List<String>>{}.obs;
  var deliveryAddress = ''.obs;
  Rx<UserModel?> userModel = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    products.assignAll(productRepo.allProducts);
    featuredProducts.assignAll(productRepo.getFeaturedProducts());
    bestSellers.assignAll(productRepo.getBestSellers());
    flashDeals.assignAll(productRepo.getFlashDeals());
    brands.assignAll(productRepo.getBrands());
    recentlyViewed.assignAll(productRepo.getRecentlyViewed());
    categories.assignAll(productRepo.getCategories());
    subCategoriesMap.assignAll(productRepo.getSubCategoriesMap());
    deliveryAddress.value = '123 Main St, City, Country';
    userModel.value = userRepository.getUser();
  }

  void refreshProducts() {
    products.assignAll(productRepo.allProducts);
  }

  void setDeliveryAddress(String address) {
    deliveryAddress.value = address;
  }

  bool get isNoProducts => products.isEmpty;
  bool get isNoFeaturedProducts => featuredProducts.isEmpty;
  bool get isNoBestSellers => bestSellers.isEmpty;
  bool get isNoFlashDeals => flashDeals.isEmpty;
  bool get isNoBrands => brands.isEmpty;
  bool get isNoRecentlyViewed => recentlyViewed.isEmpty;
  bool get isNoCategories => categories.isEmpty;
}
