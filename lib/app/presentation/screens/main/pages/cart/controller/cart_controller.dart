import 'package:get/get.dart';

import '../../../../../../domain/entities/cart_model.dart';

class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();
  var items = <CartItem>[].obs;

  void addItem(CartItem item) {
    items.add(item);
  }

  void increase(CartItem item) => item.quantity.value++;
  void decrease(CartItem item) {
    if (item.quantity.value > 1) item.quantity.value--;
  }

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + item.total);
}
