import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/product_model.dart';
import '../../../widgets/app_text.dart';

class DescriptionSection extends StatelessWidget {
  final Product product;
  const DescriptionSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.description == null) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Product Description',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 4),
        AppText(
          text: product.description!,
          color: context.kHintTextColor,
          maxLines: 10,
        ),
      ],
    );
  }
}
