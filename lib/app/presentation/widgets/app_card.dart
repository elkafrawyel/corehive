import 'package:flutter/material.dart';
import 'package:luma/app/config/theme/color_extension.dart';

class AppCard extends StatefulWidget {
  final Widget child;
  final double radius;
  final double elevation;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;
  final bool enableShadowEffect; // new
  final bool enableScaleEffect; // new

  const AppCard({
    super.key,
    required this.child,
    this.radius = 12,
    this.elevation = 2,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.onTap,
    this.enableShadowEffect = true,
    this.enableScaleEffect = true,
  });

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final border = widget.borderColor != null
        ? Border.all(
      color: widget.borderColor!,
      width: widget.borderWidth,
    )
        : null;

    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? context.kBackgroundColor,
        borderRadius: BorderRadius.circular(widget.radius),
        border: border,
        boxShadow: widget.enableShadowEffect
            ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: _pressed ? 2 : widget.elevation * 4,
            offset: const Offset(0, 3),
          ),
        ]
            : null,
      ),
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(12.0),
        child: widget.child,
      ),
    );

    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: (_) {
          if (widget.enableScaleEffect) {
            setState(() => _pressed = true);
          }
        },
        onTapUp: (_) {
          if (widget.enableScaleEffect) {
            setState(() => _pressed = false);
          }
        },
        onTapCancel: () {
          if (widget.enableScaleEffect) {
            setState(() => _pressed = false);
          }
        },
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 150),
          scale: _pressed && widget.enableScaleEffect ? 0.97 : 1.0,
          child: card,
        ),
      );
    }

    return card;
  }
}
