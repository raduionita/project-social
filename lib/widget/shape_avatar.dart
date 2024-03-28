import 'package:flutter/material.dart';

class ShapeAvatar extends StatelessWidget {
  const ShapeAvatar({super.key, this.child, this.color, this.width, this.height, this.shape = BoxShape.rectangle, this.radius, this.border});

  final Widget? child;
  final Color? color;
  final double? width;
  final double? height;
  final BoxShape shape;
  final BorderRadius? radius;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape,
          color: color,
          borderRadius: radius,
          border: border,
        ),
        child: child,
      );
}
