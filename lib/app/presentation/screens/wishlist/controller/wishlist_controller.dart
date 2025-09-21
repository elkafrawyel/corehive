import 'package:get/state_manager.dart';

import '../../../../data/models/product_model.dart';
import '../../../../data/repositories/product_repository.dart';

class WishlistController extends GetxController {
  final ProductRepository productRepo;

  WishlistController({required this.productRepo});

  var wishlist = <Product>[];

  @override
  void onInit() {
    super.onInit();
    loadWishlistedProducts();
  }

  void loadWishlistedProducts() {
    wishlist = productRepo.getWishlistedProducts();
    update();
  }

  void refreshWishlistedProducts() {
    wishlist = productRepo.getWishlistedProducts();
    update();
  }

  void remove(Product product) {
    bool removed = productRepo.removeFromWishlist(product.id);
    if (removed) {
      wishlist.removeWhere((p) => p.id == product.id);
      update();
    }
  }

  bool get isNoWishlist => wishlist.isEmpty;
}
