import 'package:corehive_store/app/data/models/cart_model.dart';
import 'package:corehive_store/app/data/repositories/product_repository.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/cart/controller/cart_controller.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

import '../../../../config/helpers/logging_helper.dart';
import '../../../../config/information_viewer.dart';
import '../../../../data/models/product_model.dart';
import '../../wishlist/controller/wishlist_controller.dart';

class ProductDetailsController extends GetxController {
  final String productId;
  Product? product;
  final ProductRepository productRepo;

  static ProductDetailsController get to => Get.find();

  ProductDetailsController({
    required this.productId,
    required this.productRepo,
  });

  RxInt selectedImageIndex = 0.obs;
  RxInt selectedQuantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    loadProduct();
  }

  loadProduct() {
    product = productRepo.getProductById(productId);
    if (product == null) return;
    product!.isWishlisted = productRepo.isWishlisted(product!.id);
    AppLogger.log('isWishlisted: ${product!.isWishlisted}', useGetX: true);
  }

  void _addToWishlist(Product product) {
    productRepo.addToWishlist(product.id);
    product.isWishlisted = true;
    update();
    InformationViewer.showSuccessToast(msg: 'Added to wishlist');
    if (Get.isRegistered<WishlistController>()) {
      Get.find<WishlistController>().refreshWishlistedProducts();
    }
  }

  void _removeFromWishlist(Product product) {
    bool removed = productRepo.removeFromWishlist(product.id);
    if (removed) {
      product.isWishlisted = false;
      update();
      if (Get.isRegistered<WishlistController>()) {
        Get.find<WishlistController>().refreshWishlistedProducts();
      }
      InformationViewer.showSuccessToast(msg: 'Removed from wishlist');
    } else {
      InformationViewer.showErrorToast(msg: 'Failed to remove from wishlist');
    }
  }

  void toggleWishlist() {
    if(product==null)return;

    if (product!.isWishlisted) {
      _removeFromWishlist(product!);
    } else {
      _addToWishlist(product!);
    }
  }

  void addToCartWithQuantity() {
    if(product==null)return;

    CartController.to.addItem(
      CartModel(
        id: product!.id,
        productName: product!.title,
        price: double.parse(product!.price),
        productImage: product!.imageUrl,
        quantity: selectedQuantity.value,
        shippingCost: 15.0,
      ),
    );
  }

  void setQuantity(int quantity) {
    selectedQuantity.value = quantity;
  }

  void selectImage(int index) {
    selectedImageIndex.value = index;
  }

  void decrementQuantity() {
    if (selectedQuantity.value > 1) {
      selectedQuantity.value--;
    }
  }

  void incrementQuantity() {
    selectedQuantity.value++;
  }
}
