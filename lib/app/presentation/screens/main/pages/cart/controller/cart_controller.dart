import 'package:corehive_store/app/config/information_viewer.dart';
import 'package:corehive_store/app/data/repositories/shipping_address_repository.dart';
import 'package:get/get.dart';
import '../../../../../../data/models/cart_model.dart';
import '../../../../../../data/models/shipping_address_model.dart';
import '../../../../../../data/repositories/cart_repository.dart';

class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();
  final CartRepository cartRepository;
  final ShippingAddressRepository shippingAddressRepository;
  CartController({
    required this.cartRepository,
    required this.shippingAddressRepository,
  });
  var items = <CartModel>[].obs;
  Rx<ShippingAddress?> primaryAddress = Rx<ShippingAddress?>(null);

  @override
  void onInit() {
    super.onInit();
    items.value = cartRepository.getAllCartItems();
    primaryAddress.value = shippingAddressRepository.getPrimaryAddress();
  }

  void addItem(CartModel item) {
    final existing = items.firstWhereOrNull((e) => e.id == item.id);
    if (existing != null) {
      if (item.quantity.value != existing.quantity.value) {
        existing.quantity.value = item.quantity.value;
        cartRepository.updateCartItem(existing, existing);
        items.value = cartRepository.getAllCartItems();
        InformationViewer.showSuccessToast(msg: 'Product quantity updated.');
        return;
      }
      InformationViewer.showSnackBar(msg: 'Product already in cart.');
    } else {
      cartRepository.addCartItem(item);
      InformationViewer.showSuccessToast(msg: 'Product Added to cart.');
      items.value = cartRepository.getAllCartItems();
    }
  }

  void removeItem(CartModel item) {
    cartRepository.removeCartItem(item);
    items.value = cartRepository.getAllCartItems();
  }

  void updateItem(CartModel item, CartModel updated) {
    cartRepository.updateCartItem(item, updated);
    items.value = cartRepository.getAllCartItems();
  }

  void clearCart() {
    cartRepository.clearCart();
    items.value = cartRepository.getAllCartItems();
  }

  void increase(CartModel item) {
    item.quantity.value++;
  }

  void decrease(CartModel item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
    }
  }

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity.value));

  void reloadShippingAddress() {
    primaryAddress.value = shippingAddressRepository.getPrimaryAddress();
  }
}
