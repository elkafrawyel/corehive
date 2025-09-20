import 'package:flutter/material.dart';
import '../../../../data/models/shipping_address_model.dart';

class ShippingAddressView extends StatelessWidget {
  final ShippingAddress address;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;

  const ShippingAddressView({
    required this.address,
    required this.onEdit,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(
          address.isPrimary ? Icons.home : Icons.location_on,
          color: address.isPrimary ? Colors.green : Colors.grey,
        ),
        title: Text(address.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(address.address), Text(address.phone)],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(onPressed: onEdit, child: const Text('Edit')),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
