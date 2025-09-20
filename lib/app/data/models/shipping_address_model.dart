class ShippingAddress {
  final String id;
  final String name;
  final String address;
  final String phone;
  bool isPrimary;

  ShippingAddress({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.isPrimary,
  });
}
