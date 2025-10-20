import '../../data/models/shipping_address_model.dart';

class ShippingAddressRepository {
  final List<ShippingAddress> _addresses = [
    ShippingAddress(
      id: '1',
      name: 'John Doe',
      address: '123 Main St, Springfield',
      phone: '+1234567890',
      isPrimary: true,
    ),
    ShippingAddress(
      id: '2',
      name: 'Jane Smith',
      address: '456 Elm St, Shelbyville',
      phone: '+0987654321',
      isPrimary: false,
    ),
  ];

  List<ShippingAddress> getAllAddresses() => List.unmodifiable(_addresses);

  ShippingAddress? getPrimaryAddress() =>
      _addresses.firstWhere((a) => a.isPrimary, orElse: () => _addresses.first);

  void addAddress(ShippingAddress address) {
    _addresses.add(address);
  }

  void deleteAddress(ShippingAddress address) {
    _addresses.removeWhere((a) => a.id == address.id);
  }

  void editAddress(ShippingAddress address, ShippingAddress updated) {
    final idx = _addresses.indexWhere((a) => a.id == address.id);
    if (idx != -1) _addresses[idx] = updated;
  }

  void selectPrimaryAddress(ShippingAddress address) {
    for (var addr in _addresses) {
      addr.isPrimary = false;
    }
    address.isPrimary = true;
  }
}
