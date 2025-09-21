import 'package:flutter/material.dart';

import '../../../../data/models/product_model.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_text.dart';

class ReviewsSection extends StatelessWidget {
  final Product product;
  const ReviewsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(text: 'Reviews', fontSize: 18, fontWeight: FontWeight.bold),
        if (product.reviews != null && product.reviews!.isNotEmpty)
          ...product.reviews!.map(
            (review) => AppCard(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: review.user, fontWeight: FontWeight.bold),
                    AppText(text: review.comment),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          Icons.star,
                          color: i < review.rating ? Colors.amber : Colors.grey,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          AppText(text: 'No reviews yet.'),
      ],
    );
  }
}
