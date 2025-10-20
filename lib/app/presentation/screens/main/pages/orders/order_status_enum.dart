enum OrderStatus {
  delivered,
  processing,
  cancelled,
  shipped,
  returned,
  refunded,
  onHold,
  awaitingPayment,
  awaitingFulfillment,
  completed,
  failed,
  partiallyShipped,
  awaitingPickup,
  awaitingShipment,
}

extension OrderStatusExtension on OrderStatus {
  // Add color property for each status
  static const Map<OrderStatus, int> _statusColors = {
    OrderStatus.delivered: 0xFF4CAF50, // Green
    OrderStatus.processing: 0xFF2196F3, // Blue
    OrderStatus.cancelled: 0xFFF44336, // Red
    OrderStatus.shipped: 0xFF3F51B5, // Indigo
    OrderStatus.returned: 0xFFFF9800, // Orange
    OrderStatus.refunded: 0xFF9C27B0, // Purple
    OrderStatus.onHold: 0xFFFFC107, // Amber
    OrderStatus.awaitingPayment: 0xFF795548, // Brown
    OrderStatus.awaitingFulfillment: 0xFF00BCD4, // Cyan
    OrderStatus.completed: 0xFF388E3C, // Dark Green
    OrderStatus.failed: 0xFFD32F2F, // Dark Red
    OrderStatus.partiallyShipped: 0xFF8BC34A, // Light Green
    OrderStatus.awaitingPickup: 0xFF607D8B, // Blue Grey
    OrderStatus.awaitingShipment: 0xFF009688, // Teal
  };

  int get color => _statusColors[this] ?? 0xFF9E9E9E; // Default: Grey

  String get label {
    switch (this) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.returned:
        return 'Returned';
      case OrderStatus.refunded:
        return 'Refunded';
      case OrderStatus.onHold:
        return 'On Hold';
      case OrderStatus.awaitingPayment:
        return 'Awaiting Payment';
      case OrderStatus.awaitingFulfillment:
        return 'Awaiting Fulfillment';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.failed:
        return 'Failed';
      case OrderStatus.partiallyShipped:
        return 'Partially Shipped';
      case OrderStatus.awaitingPickup:
        return 'Awaiting Pickup';
      case OrderStatus.awaitingShipment:
        return 'Awaiting Shipment';
    }
  }
}
