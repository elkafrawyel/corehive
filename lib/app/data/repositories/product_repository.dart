import '../models/product_model.dart';

class ProductRepository {
  List<Product> getAllProducts() {
    return [
      // Electronics
      Product(
        id: '1',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Apple iPhone 14 Pro',
        price: '999.99',
        category: 'Electronics',
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
            'https://m.media-amazon.com/images/I/71Q9d6N9lPL._AC_SL1500_.jpg',
        title: 'Sony WH-1000XM5 Wireless Headphones',
        price: '348.00',
        category: 'Electronics',
        originalPrice: '399.00',
        rating: 4.6,
        reviewCount: 2100,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 13,
      ),
      // Fashion
      Product(
        id: '3',
        imageUrl:
            'https://m.media-amazon.com/images/I/81QpkIctqPL._AC_UL1500_.jpg',
        title: 'Levi’s Men’s 501 Original Jeans',
        price: '59.99',
        category: 'Fashion',
        originalPrice: '69.99',
        rating: 4.6,
        reviewCount: 2100,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 14,
      ),
      Product(
        id: '4',
        imageUrl:
            'https://m.media-amazon.com/images/I/71p2rHh7YlL._AC_UL1500_.jpg',
        title: 'Adidas Women’s Cloudfoam Pure 2.0',
        price: '49.95',
        category: 'Fashion',
        originalPrice: '59.95',
        rating: 4.7,
        reviewCount: 1800,
        isWishlisted: true,
        isOnSale: true,
        discountPercentage: 17,
      ),
      // Home
      Product(
        id: '5',
        imageUrl:
            'https://m.media-amazon.com/images/I/81vpsIs58WL._AC_SL1500_.jpg',
        title: 'Instant Pot Duo 7-in-1',
        price: '89.99',
        category: 'Home',
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
            'https://m.media-amazon.com/images/I/71Q9d6N9lPL._AC_SL1500_.jpg',
        title: 'Dyson V11 Torque Drive Cordless Vacuum',
        price: '599.99',
        category: 'Home',
        originalPrice: '649.99',
        rating: 4.7,
        reviewCount: 1200,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 8,
      ),
      // Beauty
      Product(
        id: '7',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'The Ordinary Niacinamide 10% + Zinc 1%',
        price: '6.00',
        category: 'Beauty',
        originalPrice: '8.00',
        rating: 4.6,
        reviewCount: 5000,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 25,
      ),
      Product(
        id: '8',
        imageUrl:
            'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
        title: 'Maybelline Lash Sensational Mascara',
        price: '8.99',
        category: 'Beauty',
        originalPrice: '10.99',
        rating: 4.7,
        reviewCount: 3200,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 18,
      ),
      // Sports
      Product(
        id: '9',
        imageUrl:
            'https://m.media-amazon.com/images/I/81vpsIs58WL._AC_SL1500_.jpg',
        title: 'Wilson Evolution Basketball',
        price: '64.95',
        category: 'Sports',
        originalPrice: '74.95',
        rating: 4.8,
        reviewCount: 1100,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 13,
      ),
      Product(
        id: '10',
        imageUrl:
            'https://m.media-amazon.com/images/I/61Q9d6N9lPL._AC_SL1500_.jpg',
        title: 'Spalding NBA Street Basketball',
        price: '19.99',
        category: 'Sports',
        originalPrice: '24.99',
        rating: 4.7,
        reviewCount: 900,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 20,
      ),
      // Books
      Product(
        id: '11',
        imageUrl:
            'https://m.media-amazon.com/images/I/81YOuOGFCJL._AC_SL1500_.jpg',
        title: 'Harry Potter Box Set: Books 1-7',
        price: '55.99',
        category: 'Books',
        originalPrice: '69.99',
        rating: 4.9,
        reviewCount: 15000,
        isWishlisted: true,
        isOnSale: true,
        discountPercentage: 20,
      ),
      Product(
        id: '12',
        imageUrl:
            'https://m.media-amazon.com/images/I/81YOuOGFCJL._AC_SL1500_.jpg',
        title: 'Kindle Paperwhite',
        price: '139.99',
        category: 'Books',
        originalPrice: '159.99',
        rating: 4.9,
        reviewCount: 6500,
        isWishlisted: true,
        isOnSale: true,
        discountPercentage: 13,
      ),
      // Toys
      Product(
        id: '13',
        imageUrl:
            'https://m.media-amazon.com/images/I/81YOuOGFCJL._AC_SL1500_.jpg',
        title: 'LEGO Classic Bricks and Animals',
        price: '59.99',
        category: 'Toys',
        originalPrice: '69.99',
        rating: 4.8,
        reviewCount: 4000,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 14,
      ),
      Product(
        id: '14',
        imageUrl:
            'https://m.media-amazon.com/images/I/81YOuOGFCJL._AC_SL1500_.jpg',
        title: 'Melissa & Doug Wooden Puzzles',
        price: '19.99',
        category: 'Toys',
        originalPrice: '24.99',
        rating: 4.7,
        reviewCount: 2500,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 20,
      ),
      // Groceries
      Product(
        id: '15',
        imageUrl:
            'https://m.media-amazon.com/images/I/81YOuOGFCJL._AC_SL1500_.jpg',
        title: 'Purina ONE SmartBlend Dry Dog Food',
        price: '27.99',
        category: 'Groceries',
        originalPrice: '32.99',
        rating: 4.8,
        reviewCount: 8000,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 15,
      ),
      Product(
        id: '16',
        imageUrl:
            'https://m.media-amazon.com/images/I/81YOuOGFCJL._AC_SL1500_.jpg',
        title: 'Nature Valley Crunchy Granola Bars',
        price: '12.99',
        category: 'Groceries',
        originalPrice: '15.99',
        rating: 4.7,
        reviewCount: 5000,
        isWishlisted: false,
        isOnSale: true,
        discountPercentage: 19,
      ),
    ];
  }

  List<Product> getFeaturedProducts() {
    final products = getAllProducts();
    return products.take(6).toList();
  }

  List<Product> getBestSellers() {
    final products = getAllProducts();
    return products.skip(6).take(6).toList();
  }

  List<Product> getFlashDeals() {
    final products = getAllProducts();
    return products.skip(12).take(4).toList();
  }

  List<Product> getBrands() {
    final products = getAllProducts();
    return products.take(4).toList();
  }

  List<Product> getRecentlyViewed() {
    final products = getAllProducts();
    return [products[0], products[2]];
  }

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
