import 'package:corehive_store/app/config/helpers/logging_helper.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';
import '../../config/clients/api/api_result.dart';

class ProductRepository {
  List<Product> getWishlistedProducts() {
    return allProducts.where((p) => p.isWishlisted).toList();
  }

  bool isWishlisted(String productId) {
    return allProducts.any((p) => p.id == productId && p.isWishlisted);
  }

  bool addToWishlist(String productId) {
    final idx = allProducts.indexWhere((p) => p.id == productId);
    if (idx != -1) {
      allProducts[idx].isWishlisted = true;
      return true;
    }
    return false;
  }

  bool removeFromWishlist(String productId) {
    final idx = allProducts.indexWhere((p) => p.id == productId);
    if (idx != -1) {
      allProducts[idx].isWishlisted = false;
      return true;
    }
    return false;
  }

  ApiResult<List<Product>> searchProducts({
    String? query,
    Map<String, dynamic>? filters,
    int page = 1,
    int pageSize = 10,
  }) {
    List<Product> products = allProducts;
    if (query != null && query.isNotEmpty) {
      products = products
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    if (filters != null) {
      // Multi-select category filter
      if (filters.containsKey('category') &&
          filters['category'] is List<String> &&
          (filters['category'] as List<String>).isNotEmpty) {
        final selectedCategories = filters['category'] as List<String>;
        products = products
            .where((p) => selectedCategories.contains(p.category))
            .toList();
      }
      // Rating filter
      if (filters.containsKey('minRating') && filters['minRating'] != null) {
        final minRating = filters['minRating'] as double;
        products = products.where((p) => (p.rating ?? 0) >= minRating).toList();
      }
    }
    // Pagination
    final start = (page - 1) * pageSize;
    final end = start + pageSize;
    final pagedProducts = products.length > start
        ? products.sublist(start, end > products.length ? products.length : end)
        : <Product>[];
    if (pagedProducts.isEmpty) {
      return ApiEmpty<List<Product>>("No products found");
    }
    return ApiSuccess<List<Product>>(pagedProducts);
  }

  List<Product> allProducts = [
    // Electronics
    Product(
      id: '1',
      imageUrl:
          'https://m.media-amazon.com/images/I/61rObEraFTL._AC_SL1500_.jpg',
      images: [
        'https://wowslider.com/sliders/demo-25/data1/images/taj_mahal.jpg',
        'https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
        'https://images.unsplash.com/photo-1521747116042-5a810fda9664?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      ],
      title: 'Apple iPhone 14 Pro',
      price: '999.99',
      category: 'Electronics',
      originalPrice: '1099.99',
      rating: 4.8,
      reviewCount: 1200,
      isWishlisted: false,
      isOnSale: true,
      discountPercentage: 9,
      description:
          'The latest iPhone with advanced camera system, A16 Bionic chip, and ProMotion display.',
      buyer: 'Apple Official Store',
    ),
    Product(
      id: '2',
      imageUrl:
          'https://m.media-amazon.com/images/I/71Q9d6N9lPL._AC_SL1500_.jpg',
      images: [
        'https://wowslider.com/sliders/demo-25/data1/images/taj_mahal.jpg',
        'https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
        'https://images.unsplash.com/photo-1521747116042-5a810fda9664?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      ],
      title: 'Sony WH-1000XM5 Wireless Headphones',
      price: '348.00',
      category: 'Electronics',
      originalPrice: '399.00',
      rating: 4.6,
      reviewCount: 2100,
      isWishlisted: false,
      isOnSale: true,
      discountPercentage: 13,
      description:
          'Industry-leading noise cancellation headphones with up to 30 hours battery life.',
      buyer: 'Sony Authorized Dealer',
    ),
    // Fashion
    Product(
      id: '3',
      imageUrl:
          'https://m.media-amazon.com/images/I/81QpkIctqPL._AC_UL1500_.jpg',
      images: [
        'https://wowslider.com/sliders/demo-25/data1/images/taj_mahal.jpg',
        'https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
        'https://images.unsplash.com/photo-1521747116042-5a810fda9664?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
      ],
      title: 'Levi’s Men’s 501 Original Jeans',
      price: '59.99',
      category: 'Fashion',
      originalPrice: '69.99',
      rating: 4.6,
      reviewCount: 2100,
      isWishlisted: false,
      isOnSale: true,
      discountPercentage: 14,
      description:
          'Classic straight leg jeans with button fly and durable denim fabric.',
      buyer: 'Levi’s Official Store',
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
      isWishlisted: false,
      isOnSale: true,
      discountPercentage: 17,
      description:
          'Lightweight running shoes with Cloudfoam cushioning for all-day comfort.',
      buyer: 'Adidas Official Store',
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
      description:
          'Multi-use programmable pressure cooker, slow cooker, rice cooker, steamer, sauté, yogurt maker & warmer.',
      buyer: 'Instant Pot Official Store',
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
      description:
          'Powerful cordless vacuum with intelligent cleaning modes and LCD screen.',
      buyer: 'Dyson Official Store',
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
      description:
          'High-strength vitamin and mineral blemish formula for clearer skin.',
      buyer: 'The Ordinary Official Store',
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
      description: 'Full fan effect mascara for voluminous, separated lashes.',
      buyer: 'Maybelline Official Store',
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
      description:
          'High-quality indoor basketball with cushion core technology for superior grip.',
      buyer: 'Wilson Sports',
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
      description:
          'Durable outdoor basketball designed for street play and rough surfaces.',
      buyer: 'Spalding Sports',
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
      isWishlisted: false,
      isOnSale: true,
      discountPercentage: 20,
      description:
          'Complete set of the magical Harry Potter series by J.K. Rowling.',
      buyer: 'Scholastic Books',
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
      isWishlisted: false,
      isOnSale: true,
      discountPercentage: 13,
      description:
          'Waterproof e-reader with high-resolution display and adjustable warm light.',
      buyer: 'Amazon Devices',
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
      description:
          'Creative building set with colorful bricks and animal figures for imaginative play.',
      buyer: 'LEGO Official Store',
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
      description:
          'Set of durable wooden puzzles for early learning and problem-solving skills.',
      buyer: 'Melissa & Doug',
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
      description:
          'High-protein dog food with real chicken and natural ingredients for healthy digestion.',
      buyer: 'Purina PetCare',
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
      description:
          'Crunchy granola bars made with whole grain oats and honey for a healthy snack.',
      buyer: 'Nature Valley',
    ),
  ];

  List<Product> getFeaturedProducts() {
    return allProducts.take(6).toList();
  }

  List<Product> getBestSellers() {
    return allProducts.skip(6).take(6).toList();
  }

  List<Product> getFlashDeals() {
    final products = allProducts;
    return products.skip(12).take(4).toList();
  }

  List<Product> getBrands() {
    return allProducts.take(4).toList();
  }

  List<Product> getRecentlyViewed() {
    return [allProducts[0], allProducts[2]];
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

  Product? getProductById(String productId) {
    return allProducts.firstWhereOrNull((p) => p.id == productId);
  }
}
