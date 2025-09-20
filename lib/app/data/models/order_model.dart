class OrderModel {
  final String id;
  final String date;
  final String status;
  final String total;
  final String productImage;
  final String productName;
  final int quantity;

  OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.productImage,
    required this.productName,
    required this.quantity,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      date: map['date'] as String,
      status: map['status'] as String,
      total: map['total'] as String,
      productImage: map['productImage'] as String,
      productName: map['productName'] as String,
      quantity: map['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'status': status,
      'total': total,
      'productImage': productImage,
      'productName': productName,
      'quantity': quantity,
    };
  }
}
