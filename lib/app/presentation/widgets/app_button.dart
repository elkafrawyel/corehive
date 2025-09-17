import 'package:flutter/material.dart';
import 'package:luma/app/config/theme/color_extension.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final double? radius;
  final double? width;
  final double? fontSize;
  final bool isLoading;
  final Widget? icon;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.elevation,
    this.radius,
    this.width,
    this.fontSize,
    this.isLoading = false,
    this.icon,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final btnChild = isLoading
        ? SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: textColor ?? context.kColorOnPrimary,
        strokeWidth: 2,
      ),
    )
        : Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        AppText(
          text: text,
          color: textColor ?? context.kColorOnPrimary,
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.w700,
        ),
      ],
    );

    return SizedBox(
      width: fullWidth ? (width ?? MediaQuery.sizeOf(context).width) : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0.0,
          disabledBackgroundColor: context.kHintTextColor,
          disabledForegroundColor: Colors.white70,
          backgroundColor: backgroundColor ?? context.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 12),
          ),
          padding: padding ?? const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
        ),
        onPressed: isLoading ? null : onPressed,
        child: btnChild,
      ),
    );
  }
}
