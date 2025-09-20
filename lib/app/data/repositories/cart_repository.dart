import '../models/cart_model.dart';

class CartRepository {
  final List<CartModel> _cartItems = [
    CartModel(
      id: 'CART-1001',
      productName: 'Wireless Headphones',
      productImage:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
      quantity: 2,
      price: 120.0,
      shippingCost: 15.0,
    ),
    CartModel(
      id: 'CART-1002',
      productName: 'Smart Watch',
      productImage:
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      quantity: 1,
      price: 200.0,
      shippingCost: 10.0,
    ),
  ];

  List<CartModel> getAllCartItems() => List.unmodifiable(_cartItems);

  void addCartItem(CartModel item) {
    _cartItems.add(item);
  }

  void removeCartItem(CartModel item) {
    _cartItems.removeWhere((i) => i.id == item.id);
  }

  void updateCartItem(CartModel item, CartModel updated) {
    final idx = _cartItems.indexWhere((i) => i.id == item.id);
    if (idx != -1) _cartItems[idx] = updated;
  }

  void clearCart() {
    _cartItems.clear();
  }
}
