import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/product_model.dart';
import '../controller/product_details_controller.dart';

class ImageIndicatorsSection extends StatelessWidget {
  final Product product;
  const ImageIndicatorsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();
    if (product.images == null || product.images!.length <= 1) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            product.images!.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: controller.selectedImageIndex.value == index ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: controller.selectedImageIndex.value == index
                    ? context.kPrimaryColor
                    : context.kColorOnPrimary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
