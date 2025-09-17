import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CartItem {
  final String title;
  final String imageUrl;
  final double price;
  RxInt quantity;

  CartItem({
    required this.title,
    required this.imageUrl,
    required this.price,
    int quantity = 1,
  }) : quantity = quantity.obs;

  double get total => price * quantity.value;
}