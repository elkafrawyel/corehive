import 'package:get/get.dart';

class CartModel {
  final String id;
  final String productName;
  final String productImage;
  RxInt quantity;
  final double price;
  final double shippingCost;

  CartModel({
    required this.id,
    required this.productName,
    required this.productImage,
    required int quantity,
    required this.price,
    required this.shippingCost,
  }) : quantity = quantity.obs;

  copyWith({
    String? id,
    String? productName,
    String? productImage,
    int? quantity,
    double? price,
    double? shippingCost,
  }) {
    return CartModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      quantity: quantity ?? this.quantity.value,
      price: price ?? this.price,
      shippingCost: shippingCost ?? this.shippingCost,
    );
  }
}
