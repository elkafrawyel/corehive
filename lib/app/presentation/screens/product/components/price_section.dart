import 'package:flutter/material.dart';
import '../../../../data/models/product_model.dart';
import '../../../widgets/app_text.dart';

class PriceSection extends StatelessWidget {
  final Product product;
  final String heroTagTitle;
  const PriceSection({
    super.key,
    required this.product,
    required this.heroTagTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: heroTagTitle,
          child: AppText(
            text: product.title,
            maxLines: 5,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        AppText(
          text: '\u0024${product.price}',
          fontSize: 20,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
        if (product.originalPrice != null)
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: AppText(
              text: '\u0024${product.originalPrice}',
              fontSize: 14,
              color: Colors.grey,
              lineThrough: true,
            ),
          ),
      ],
    );
  }
}
