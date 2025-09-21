import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/app_text.dart';
import '../controller/product_details_controller.dart';

class QuantitySelectorSection extends StatelessWidget {
  const QuantitySelectorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();
    return Row(
      children: [
        AppText(text: 'Quantity:', fontWeight: FontWeight.w600),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: controller.decrementQuantity,
              ),
              Obx(
                () => AppText(
                  text: controller.selectedQuantity.value.toString(),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: controller.incrementQuantity,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
