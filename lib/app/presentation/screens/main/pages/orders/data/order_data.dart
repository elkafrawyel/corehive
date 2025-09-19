import '../order_model.dart';

final List<OrderModel> ordersData = [
  OrderModel(
    id: 'ORD-1001',
    date: '2025-09-10',
    status: 'Delivered',
    total: '250.00',
    productImage:
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
    productName: 'iPhone 14 Pro Max',
    quantity: 2,
  ),
  OrderModel(
    id: 'ORD-1002',
    date: '2025-09-15',
    status: 'Processing',
    total: '120.00',
    productImage:
        'https://images.unsplash.com/photo-1510557880182-3d4d3cba35f3',
    productName: 'Samsung Galaxy S23 Ultra',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1003',
    date: '2025-09-18',
    status: 'Cancelled',
    total: '180.00',
    productImage:
        'https://images.unsplash.com/photo-1598327105666-5b89351aff97',
    productName: 'Google Pixel 7 Pro',
    quantity: 3,
  ),
  OrderModel(
    id: 'ORD-1004',
    date: '2024-12-22',
    status: 'Shipped',
    total: '99.99',
    productImage:
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    productName: 'Kitchen Mixer',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1005',
    date: '2023-07-05',
    status: 'Returned',
    total: '45.00',
    productImage:
        'https://images.unsplash.com/photo-1512820790803-83ca734da794',
    productName: 'Book: Flutter in Action',
    quantity: 2,
  ),
  OrderModel(
    id: 'ORD-1006',
    date: '2022-03-14',
    status: 'Refunded',
    total: '320.00',
    productImage:
        'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    productName: 'Mountain Bike',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1007',
    date: '2021-11-30',
    status: 'On Hold',
    total: '60.00',
    productImage:
        'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    productName: 'Board Game: Catan',
    quantity: 4,
  ),
  OrderModel(
    id: 'ORD-1008',
    date: '2020-05-18',
    status: 'Awaiting Payment',
    total: '15.00',
    productImage:
        'https://images.unsplash.com/photo-1518717758536-85ae29035b6d',
    productName: 'Dog Toy',
    quantity: 2,
  ),
  OrderModel(
    id: 'ORD-1009',
    date: '2025-08-01',
    status: 'Awaiting Fulfillment',
    total: '210.00',
    productImage:
        'https://images.unsplash.com/photo-1504198453319-5ce911bafcde',
    productName: 'Health Supplement',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1010',
    date: '2024-02-14',
    status: 'Completed',
    total: '75.00',
    productImage:
        'https://images.unsplash.com/photo-1511918984145-48de785d4c4e',
    productName: 'Car Care Kit',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1011',
    date: '2023-10-10',
    status: 'Failed',
    total: '55.00',
    productImage:
        'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
    productName: 'T-shirt',
    quantity: 2,
  ),
  OrderModel(
    id: 'ORD-1012',
    date: '2022-06-21',
    status: 'Partially Shipped',
    total: '130.00',
    productImage:
        'https://images.unsplash.com/photo-1510557880182-3d4d3cba35f3',
    productName: 'Shoes',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1013',
    date: '2021-03-15',
    status: 'Awaiting Pickup',
    total: '80.00',
    productImage:
        'https://images.unsplash.com/photo-1512820790803-83ca734da794',
    productName: 'Book: Dart Cookbook',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1014',
    date: '2020-09-09',
    status: 'Awaiting Shipment',
    total: '99.00',
    productImage:
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    productName: 'Blender',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1015',
    date: '2025-07-21',
    status: 'Delivered',
    total: '199.99',
    productImage:
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
    productName: 'Wireless Headphones',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1016',
    date: '2024-11-11',
    status: 'Processing',
    total: '89.99',
    productImage:
        'https://images.unsplash.com/photo-1510557880182-3d4d3cba35f3',
    productName: 'Smart Watch',
    quantity: 2,
  ),
  OrderModel(
    id: 'ORD-1017',
    date: '2023-05-30',
    status: 'Cancelled',
    total: '49.99',
    productImage:
        'https://images.unsplash.com/photo-1598327105666-5b89351aff97',
    productName: 'Bluetooth Speaker',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1018',
    date: '2022-08-19',
    status: 'Shipped',
    total: '299.99',
    productImage:
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
    productName: 'Gaming Console',
    quantity: 1,
  ),
  OrderModel(
    id: 'ORD-1019',
    date: '2021-12-25',
    status: 'Returned',
    total: '59.99',
    productImage:
        'https://images.unsplash.com/photo-1512820790803-83ca734da794',
    productName: 'Cookbook',
    quantity: 2,
  ),
  OrderModel(
    id: 'ORD-1020',
    date: '2020-03-10',
    status: 'Refunded',
    total: '399.99',
    productImage:
        'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    productName: 'Road Bike',
    quantity: 1,
  ),
];
