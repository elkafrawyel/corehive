import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:luma/app/config/theme/color_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/res.dart';

class AppNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final File? localFile;
  final double width;
  final double height;
  final double? radius;
  final BoxFit fit;
  final Color? borderColor;
  final double borderWidth;
  final bool isCircular;
  final String? fallbackAsset;

  const AppNetworkImage({
    super.key,
    this.imageUrl,
    this.localFile,
    this.width = 90,
    this.height = 90,
    this.radius,
    this.fit = BoxFit.cover,
    this.borderColor,
    this.borderWidth = 0,
    this.isCircular = false,
    this.fallbackAsset = Res.logo,
  });

  BoxDecoration _decoration({ImageProvider? image}) {
    return BoxDecoration(
      shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: isCircular ? null : BorderRadius.circular(radius ?? 12),
      border: borderColor != null && borderWidth > 0
          ? Border.all(color: borderColor!, width: borderWidth)
          : null,
      image: image != null ? DecorationImage(image: image, fit: fit) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (localFile == null && (imageUrl == null || imageUrl!.isEmpty)) {
      return _buildFallback();
    }

    if (localFile != null) {
      return Container(
        width: width,
        height: height,
        decoration: _decoration(image: FileImage(localFile!)),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) =>
          Container(decoration: _decoration(image: imageProvider)),
      placeholder: (context, url) => _buildShimmer(),
      errorWidget: (context, url, error) => _buildFallback(),
    );
  }

  Widget _buildFallback() {
    return Container(
      width: width,
      height: height,
      decoration: _decoration(
        image: fallbackAsset != null
            ? AssetImage(fallbackAsset!) as ImageProvider
            : null,
      ),
      child: fallbackAsset == null
          ? Icon(Icons.broken_image, size: width / 2, color: Colors.grey)
          : null,
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(width: width, height: height, decoration: _decoration()),
    );
  }
}
