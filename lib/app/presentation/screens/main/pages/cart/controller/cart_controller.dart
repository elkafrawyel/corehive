import 'package:get/get.dart';
import '../../../../../../data/models/cart_model.dart';
import '../../../../../../data/models/shipping_address_model.dart';
import '../../../../../../data/repositories/shipping_address_repository.dart';
import '../../../../../../data/repositories/cart_repository.dart';

class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();
  final CartRepository cartRepository;
  CartController({required this.cartRepository});
  var items = <CartModel>[].obs;

  Rx<ShippingAddress> selectedAddress = Rx<ShippingAddress>(
    ShippingAddress(id: '', name: '', address: '', phone: '', isPrimary: false),
  );

  @override
  void onInit() {
    super.onInit();
    items.value = cartRepository.getAllCartItems();
  }

  void selectAddress(ShippingAddress address) {
    selectedAddress.value = address;
  }

  void addItem(CartModel item) {
    cartRepository.addCartItem(item);
    items.value = cartRepository.getAllCartItems();
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
}
