import 'package:get/get.dart';
import '../../../../data/repositories/shipping_address_repository.dart';
import '../../../../data/models/shipping_address_model.dart';

class ShippingAddressController extends GetxController {
  final ShippingAddressRepository repository;
  List<ShippingAddress> addresses = <ShippingAddress>[];
  Rx<ShippingAddress?> primaryAddress = Rx<ShippingAddress?>(null);

  ShippingAddressController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    addresses = repository.getAllAddresses();
    update();
    primaryAddress.value = repository.getPrimaryAddress();
  }

  void selectPrimaryAddress(ShippingAddress address) {
    repository.selectPrimaryAddress(address);
    addresses = repository.getAllAddresses();
    primaryAddress.value = repository.getPrimaryAddress();
    update();
  }

  void addAddress(ShippingAddress address) {
    repository.addAddress(address);
    addresses = repository.getAllAddresses();
    update();
  }

  void deleteAddress(ShippingAddress address) {
    repository.deleteAddress(address);
    addresses = repository.getAllAddresses();
    update();
  }

  void editAddress(ShippingAddress address, ShippingAddress updated) {
    repository.editAddress(address, updated);
    addresses = repository.getAllAddresses();
    update();
  }
}
