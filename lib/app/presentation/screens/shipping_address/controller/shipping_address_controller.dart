import 'package:get/get.dart';
import '../../../../data/repositories/shipping_address_repository.dart';
import '../../../../data/models/shipping_address_model.dart';

class ShippingAddressController extends GetxController {
  final ShippingAddressRepository repository;
  RxList<ShippingAddress> addresses = <ShippingAddress>[].obs;
  Rx<ShippingAddress?> primaryAddress = Rx<ShippingAddress?>(null);

  ShippingAddressController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    addresses.value = repository.getAllAddresses();
    primaryAddress.value = repository.getPrimaryAddress();
  }

  void selectPrimaryAddress(ShippingAddress address) {
    repository.selectPrimaryAddress(address);
    addresses.value = repository.getAllAddresses();
    primaryAddress.value = repository.getPrimaryAddress();
    addresses.refresh();
  }

  void addAddress(ShippingAddress address) {
    repository.addAddress(address);
    addresses.value = repository.getAllAddresses();
    addresses.refresh();
  }

  void deleteAddress(ShippingAddress address) {
    repository.deleteAddress(address);
    addresses.value = repository.getAllAddresses();
    addresses.refresh();
  }

  void editAddress(ShippingAddress address, ShippingAddress updated) {
    repository.editAddress(address, updated);
    addresses.value = repository.getAllAddresses();
    addresses.refresh();
  }
}
