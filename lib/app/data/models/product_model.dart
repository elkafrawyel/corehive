class Product {
  final String id;
  final String imageUrl;
  final List<String>? images;
  final String title;
  final String price;
  final String category;
  final String? originalPrice;
  final double? rating;
  final int? reviewCount;
  bool isWishlisted;
  final bool isOnSale;
  final int? discountPercentage;
  final String? description;
  final String? buyer;
  final Map<String, String>? properties;
  final List<ProductReview>? reviews;

  Product({
    required this.id,
    required this.imageUrl,
    this.images,
    required this.title,
    required this.price,
    required this.category,
    this.originalPrice,
    this.rating,
    this.reviewCount,
    this.isWishlisted = false,
    this.isOnSale = false,
    this.discountPercentage,
    this.description,
    this.buyer,
    this.properties,
    this.reviews,
  });
}

class ProductReview {
  final String user;
  final String comment;
  final int rating;

  ProductReview({
    required this.user,
    required this.comment,
    required this.rating,
  });
}
