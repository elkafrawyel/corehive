import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/product_model.dart';
import '../../../widgets/app_network_image.dart';
import '../controller/product_details_controller.dart';

class ImageSliderSection extends StatelessWidget {
  final Product product;
  final String? heroTag;
  const ImageSliderSection({
    super.key,
    required this.product,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: product.images?.length ?? 1,
        onPageChanged: controller.selectImage,
        itemBuilder: (context, index) {
          final imageUrl = product.images != null && product.images!.isNotEmpty
              ? product.images![index]
              : product.imageUrl;
          return Hero(
            tag: heroTag??'',
            child: AppNetworkImage(imageUrl: imageUrl),
          );
        },
      ),
    );
  }
}
