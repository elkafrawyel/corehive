import 'package:get/get.dart';
import 'package:corehive_store/app/presentation/screens/main/controllers/nav_controller.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/cart/controller/cart_controller.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/profile/controller/profile_controller.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/orders/controller/orders_controller.dart';

import '../../shipping_address/controller/shipping_address_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<NavController>(() => NavController());
    Get.lazyPut<OrdersController>(() => OrdersController());
    Get.lazyPut<ShippingAddressController>(() => ShippingAddressController());
  }
}
