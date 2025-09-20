import 'package:get/get.dart';
import 'package:corehive_store/app/presentation/screens/main/controllers/nav_controller.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/cart/controller/cart_controller.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/profile/controller/profile_controller.dart';
import 'package:corehive_store/app/presentation/screens/main/pages/orders/controller/orders_controller.dart';

import '../../../../data/repositories/product_repository.dart';
import '../../../../data/repositories/shipping_address_repository.dart';
import '../../../../domain/repositories/product_repository_base.dart';
import '../../shipping_address/controller/shipping_address_controller.dart';
import '../pages/home/controller/home_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // repositories
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut(() => ShippingAddressRepository());

    // controllers
    Get.lazyPut<HomeController>(
      () => HomeController(productRepo: Get.find<ProductRepository>()),
    );
    Get.lazyPut<ShippingAddressController>(
      () => ShippingAddressController(
        repository: Get.find<ShippingAddressRepository>(),
      ),
    );
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<NavController>(() => NavController());
    Get.lazyPut<OrdersController>(() => OrdersController());
  }
}
