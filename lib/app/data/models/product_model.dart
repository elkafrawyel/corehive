class Product {
  final String id;
  final String imageUrl;
  final String title;
  final String price;
  final String? originalPrice;
  final double? rating;
  final int? reviewCount;
  final bool isWishlisted;
  final bool isOnSale;
  final int? discountPercentage;

  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.originalPrice,
    this.rating,
    this.reviewCount,
    this.isWishlisted = false,
    this.isOnSale = false,
    this.discountPercentage,
  });
}
