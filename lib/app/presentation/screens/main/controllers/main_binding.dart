import 'package:get/get.dart';
import 'package:corehive_store/app/presentation/screens/main/controllers/nav_controller.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/cart/controller/cart_controller.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/profile/controller/profile_controller.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/orders/controller/orders_controller.dart';

import '../../../../data/repositories/cart_repository.dart';
import '../../../../data/repositories/product_repository.dart';
import '../../../../data/repositories/shipping_address_repository.dart';
import '../../shipping_address/controller/shipping_address_controller.dart';
import '../pages/home/controller/home_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // repositories
    Get.lazyPut(() => ProductRepository());
    Get.lazyPut(() => ShippingAddressRepository());
    Get.lazyPut(() => CartRepository());

    // controllers
    Get.lazyPut(
      () => HomeController(productRepo: Get.find<ProductRepository>()),
    );
    Get.lazyPut(
      () => ShippingAddressController(
        repository: Get.find<ShippingAddressRepository>(),
      ),
    );
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(
      () => CartController(cartRepository: Get.find<CartRepository>()),
    );
    Get.lazyPut(() => NavController());
    Get.lazyPut(() => OrdersController());
  }
}
