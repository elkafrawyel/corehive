import 'dart:math';
import 'package:flutter/material.dart';

/// Base class with AnimationController
abstract class AnimationControllerState<T extends StatefulWidget>
    extends State<T>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

/// Custom Shake Widget
class CustomShakeWidget extends StatefulWidget {
  const CustomShakeWidget({
    required this.child,
    this.shakeCount = 3,
    this.shakeOffset = 10,
    super.key,
  });

  final Widget child;
  final double shakeOffset;
  final int shakeCount;

  @override
  State<CustomShakeWidget> createState() => CustomShakeWidgetState();
}

class CustomShakeWidgetState
    extends AnimationControllerState<CustomShakeWidget> {
  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (context, child) {
        final sineValue = sin(
          widget.shakeCount * 2 * pi * animationController.value,
        );
        return Transform.translate(
          offset: Offset(sineValue * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }

  /// Call this to trigger the shake
  void shake() {
    animationController.forward();
  }
}
