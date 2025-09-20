class CartModel {
  final String id;
  final String productName;
  final String productImage;
  final int quantity;
  final double price;
  final double shippingCost;

  CartModel({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.price,
    required this.shippingCost,
  });
}
