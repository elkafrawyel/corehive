import 'package:flutter/material.dart';
import '../../../../data/models/product_model.dart';
import '../../../widgets/app_text.dart';

class PropertiesSection extends StatelessWidget {
  final Product product;
  const PropertiesSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.properties == null) return SizedBox.shrink();
    return Column(
      children: product.properties!.entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  AppText(text: '${e.key}: ', fontWeight: FontWeight.bold),
                  AppText(text: e.value),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
