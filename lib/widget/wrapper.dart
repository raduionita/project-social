import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/framework/hooks.dart';

typedef WrapperOnBuildCallback = void Function();
typedef WrapperChildBuilderCallback = Widget Function();

class Wrapper extends HookWidget {
  const Wrapper({super.key, this.padding, this.width, this.color, this.onBuild, this.childBuilder, this.child});

  final EdgeInsetsGeometry? padding;
  final double? width;
  final Color? color;
  final WrapperOnBuildCallback? onBuild;
  final WrapperChildBuilderCallback? childBuilder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    useEffectOnce(() {
      if (onBuild != null) {
        onBuild!();
      }
      return null;
    });
    if (childBuilder != null) {
      return Container(
        key: key,
        padding: padding,
        width: width,
        color: color,
        child: childBuilder!(),
      );
    } else {
      return Container(
        key: key,
        padding: padding,
        width: width,
        color: color,
        child: child,
      );
    }
  }
}
