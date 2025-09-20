import '../../domain/repositories/product_repository_base.dart';
import '../models/product_model.dart';

class ProductRepository extends ProductRepositoryBase {
  @override
  List<Product> getAllProducts() {
    return [
      Product(
        id: '1',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Apple iPhone 14 Pro',
        price: '999.99',
        originalPrice: '1099.99',
        rating: 4.8,
        reviewCount: 1200,
        isWishlisted: true,
        isOnSale: true,
        discountPercentage: 9,
      ),
      Product(
        id: '2',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Samsung Galaxy S23 Ultra',
        price: '1199.99',
        originalPrice: '1299.99',
        rating: 4.7,
        reviewCount: 950,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 8,
      ),
      Product(
        id: '3',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Sony WH-1000XM5 Wireless Headphones',
        price: '348.00',
        originalPrice: '399.00',
        rating: 4.6,
        reviewCount: 2100,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 13,
      ),
      Product(
        id: '4',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Apple MacBook Air M2',
        price: '1099.00',
        originalPrice: '1199.00',
        rating: 4.9,
        reviewCount: 800,
        isWishlisted: true,
        isOnSale: true,
        discountPercentage: 8,
      ),
      Product(
        id: '5',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Instant Pot Duo 7-in-1',
        price: '89.99',
        originalPrice: '99.99',
        rating: 4.7,
        reviewCount: 5000,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 10,
      ),
      Product(
        id: '6',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Fitbit Charge 5',
        price: '129.95',
        originalPrice: '149.95',
        rating: 4.5,
        reviewCount: 3200,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 13,
      ),
      Product(
        id: '7',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Levi’s Men’s 501 Original Jeans',
        price: '59.99',
        originalPrice: '69.99',
        rating: 4.6,
        reviewCount: 2100,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 14,
      ),
      Product(
        id: '8',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Adidas Women’s Cloudfoam Pure 2.0',
        price: '49.95',
        originalPrice: '59.95',
        rating: 4.7,
        reviewCount: 1800,
        isWishlisted: true,
        isOnSale: true,
        discountPercentage: 17,
      ),
      Product(
        id: '9',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Echo Dot (5th Gen)',
        price: '49.99',
        originalPrice: '59.99',
        rating: 4.8,
        reviewCount: 9000,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 17,
      ),
      Product(
        id: '10',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Kindle Paperwhite',
        price: '139.99',
        originalPrice: '159.99',
        rating: 4.9,
        reviewCount: 6500,
        isWishlisted: true,
        isOnSale: true,
        discountPercentage: 13,
      ),
      Product(
        id: '11',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Ninja Professional Blender',
        price: '89.99',
        originalPrice: '99.99',
        rating: 4.8,
        reviewCount: 3500,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 10,
      ),
      Product(
        id: '12',
        imageUrl:
            'https://m.media-amazon.com/images/I/71Q9d6N9lPL._AC_SL1500_.jpg',
        title: 'Dyson V11 Torque Drive Cordless Vacuum',
        price: '599.99',
        originalPrice: '649.99',
        rating: 4.7,
        reviewCount: 1200,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 8,
      ),
      Product(
        id: '13',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'The Ordinary Niacinamide 10% + Zinc 1%',
        price: '6.00',
        originalPrice: '8.00',
        rating: 4.6,
        reviewCount: 5000,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 25,
      ),
      Product(
        id: '14',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Maybelline Lash Sensational Mascara',
        price: '8.99',
        originalPrice: '10.99',
        rating: 4.7,
        reviewCount: 3200,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 18,
      ),
      Product(
        id: '15',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Wilson Evolution Basketball',
        price: '64.95',
        originalPrice: '74.95',
        rating: 4.8,
        reviewCount: 1100,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 13,
      ),
      Product(
        id: '16',
        imageUrl:
            'https://m.media-amazon.com/images/I/61Q9d6N9lPL._AC_SL1500_.jpg',
        title: 'Spalding NBA Street Basketball',
        price: '19.99',
        originalPrice: '24.99',
        rating: 4.7,
        reviewCount: 900,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 20,
      ),
      Product(
        id: '17',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Harry Potter Box Set: Books 1-7',
        price: '55.99',
        originalPrice: '69.99',
        rating: 4.9,
        reviewCount: 15000,
        isWishlisted: true,
        isOnSale: true,
        discountPercentage: 20,
      ),
      Product(
        id: '18',
        imageUrl:
            'https://m.media-amazon.com/images/I/81YOuOGFCJL._AC_SL1500_.jpg',
        title: 'LEGO Classic Bricks and Animals',
        price: '59.99',
        originalPrice: '69.99',
        rating: 4.8,
        reviewCount: 4000,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 14,
      ),
      Product(
        id: '19',
        imageUrl:
            'https://m.media-amazon.com/images/I/81YOuOGFCJL._AC_SL1500_.jpg',
        title: 'Melissa & Doug Wooden Puzzles',
        price: '19.99',
        originalPrice: '24.99',
        rating: 4.7,
        reviewCount: 2500,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 20,
      ),
      Product(
        id: '20',
        imageUrl:
            'https://m.media-amazon.com/images/I/81YOuOGFCJL._AC_SL1500_.jpg',
        title: 'Purina ONE SmartBlend Dry Dog Food',
        price: '27.99',
        originalPrice: '32.99',
        rating: 4.8,
        reviewCount: 8000,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 15,
      ),
    ];
  }

  @override
  List<Product> getFeaturedProducts() {
    final products = getAllProducts();
    return products.take(6).toList();
  }

  @override
  List<Product> getBestSellers() {
    final products = getAllProducts();
    return products.skip(6).take(6).toList();
  }

  @override
  List<Product> getFlashDeals() {
    final products = getAllProducts();
    return products.skip(12).take(4).toList();
  }

  @override
  List<Product> getBrands() {
    final products = getAllProducts();
    return products.take(4).toList();
  }

  @override
  List<Product> getRecentlyViewed() {
    final products = getAllProducts();
    return [products[0], products[2]];
  }

  @override
  List<String> getCategories() {
    return [
      'Electronics',
      'Fashion',
      'Home',
      'Beauty',
      'Sports',
      'Books',
      'Toys',
      'Groceries',
    ];
  }

  @override
  Map<String, List<String>> getSubCategoriesMap() {
    return {
      'Electronics': [
        'Phones',
        'Laptops',
        'Cameras',
        'Audio',
        'Wearables',
        'Accessories',
      ],
      'Clothing': ['Men', 'Women', 'Kids', 'Shoes', 'Accessories'],
      'Home & Kitchen': [
        'Furniture',
        'Appliances',
        'Cookware',
        'Decor',
        'Storage',
      ],
      'Beauty': ['Makeup', 'Skincare', 'Haircare', 'Fragrance', 'Tools'],
      'Books': ['Fiction', 'Non-Fiction', 'Children', 'Comics', 'Textbooks'],
      'Sports': ['Fitness', 'Outdoor', 'Team Sports', 'Equipment', 'Footwear'],
      'Toys & Games': [
        'Educational',
        'Board Games',
        'Action Figures',
        'Puzzles',
        'Outdoor Toys',
      ],
      'Health & Personal Care': [
        'Supplements',
        'Medical',
        'Personal Hygiene',
        'Wellness',
        'Devices',
      ],
      'Automotive': [
        'Car Care',
        'Accessories',
        'Tools',
        'Parts',
        'Motorcycles',
      ],
      'Pet Supplies': ['Food', 'Toys', 'Grooming', 'Beds', 'Health'],
    };
  }
}
