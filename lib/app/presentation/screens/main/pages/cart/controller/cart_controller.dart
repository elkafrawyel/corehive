import 'package:get/get.dart';
import '../../../../../../data/models/shipping_address_model.dart';
import '../../../../../../data/repositories/shipping_address_repository.dart';
import '../../../../../../domain/entities/cart_model.dart';

class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();
  var items = <CartItem>[].obs;

  final ShippingAddressRepository addressRepository =
      ShippingAddressRepository();
  Rx<ShippingAddress> selectedAddress = Rx<ShippingAddress>(
    ShippingAddress(id: '', name: '', address: '', phone: '', isPrimary: false),
  );

  void selectAddress(ShippingAddress address) {
    selectedAddress.value = address;
  }

  void addItem(CartItem item) {
    items.add(item);
  }

  void increase(CartItem item) => item.quantity.value++;
  void decrease(CartItem item) {
    if (item.quantity.value > 1) item.quantity.value--;
  }

  double get totalPrice => items.fold(0, (sum, item) => sum + item.total);

  @override
  void onInit() {
    super.onInit();
    final primary = addressRepository.getPrimaryAddress();
    if (primary != null) {
      selectedAddress.value = primary;
    } else {
      final all = addressRepository.getAllAddresses();
      if (all.isNotEmpty) selectedAddress.value = all.first;
    }
    // Demo mobile items
    addItem(
      CartItem(
        title: "iPhone 15 Pro",
        imageUrl:
            "https://images.unsplash.com/photo-1607082349566-187342175e2f",
        price: 1199,
      ),
    );
    addItem(
      CartItem(
        title: "iPhone 14 Pro",
        imageUrl:
            "https://images.unsplash.com/photo-1522202176988-66273c2fd55f",
        price: 999,
      ),
    );
    addItem(
      CartItem(
        title: "iPhone 13",
        imageUrl:
            "https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
        price: 799,
      ),
    );
    addItem(
      CartItem(
        title: "iPhone 12",
        imageUrl:
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        price: 699,
      ),
    );
    addItem(
      CartItem(
        title: "iPhone 12",
        imageUrl:
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        price: 699,
      ),
    );
    addItem(
      CartItem(
        title: "iPhone 12",
        imageUrl:
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e",
        price: 699,
      ),
    );
  }
}
