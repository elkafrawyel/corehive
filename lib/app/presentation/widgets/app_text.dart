import 'package:flutter/material.dart';
import 'package:luma/app/config/theme/color_extension.dart';
import '../../config/clients/storage/storage_client.dart';
import '../../config/constants.dart';
class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final int? maxLines;
  final bool centerText;
  final double fontSize;
  final FontWeight? fontWeight;
  final bool lineThrough;
  final bool underLine;
  final double? height;
  final String? fontFamily;
  final TextOverflow overflow;
  final double? letterSpacing;
  final bool softWrap;

  const AppText({
    super.key,
    required this.text,
    this.color,
    this.maxLines,
    this.centerText = false,
    this.fontSize = kDefaultFontSize,
    this.fontWeight,
    this.lineThrough = false,
    this.underLine = false,
    this.height,
    this.fontFamily,
    this.overflow = TextOverflow.ellipsis,
    this.letterSpacing,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveFontFamily = fontFamily ??
        (StorageClient().isAr()
            ? Constants.arFontFamily
            : Constants.fontFamily);

    return Text(
      text,
      maxLines: maxLines,
      softWrap: softWrap,
      textAlign: centerText ? TextAlign.center : TextAlign.start,
      overflow: overflow,
      style: DefaultTextStyle.of(context).style.copyWith(
        color: color ?? context.kTextColor,
        fontSize: fontSize,
        fontFamily: effectiveFontFamily,
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing,
        decoration: lineThrough
            ? TextDecoration.lineThrough
            : underLine
            ? TextDecoration.underline
            : TextDecoration.none,
        decorationThickness: 1,
        decorationColor: color ?? Colors.black,
      ),
    );
  }
}
