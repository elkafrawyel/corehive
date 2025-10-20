import 'package:flutter/material.dart';

import '../../../../data/models/product_model.dart';
import '../../../widgets/app_text.dart';

class BuyerSection extends StatelessWidget {
  final Product product;
  const BuyerSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: 'Sold by: ${product.buyer ?? 'Amazon LLC'}',
      fontSize: 16,
      color: Colors.blue,
      fontWeight: FontWeight.w500,
    );
  }
}
