import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/app/hooks.dart';

typedef WrapperOnBuildCallback = void Function();
typedef WrapperChildBuilderCallback = Widget Function();

class Wrapper extends HookWidget {
  const Wrapper({super.key, this.padding, this.width, this.color, this.onBuild, required this.builder, this.child});

  final EdgeInsetsGeometry? padding;
  final double? width;
  final Color? color;
  final WrapperOnBuildCallback? onBuild;
  final WrapperChildBuilderCallback builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    onBuild != null
        ? useEffectOnce(() {
            (() async => await Future.delayed(const Duration(milliseconds: 1), () => onBuild!()))();
            return;
          })
        : null;
    return Container(
      key: key,
      padding: padding,
      width: width,
      color: color,
      child: builder(),
    );
  }
}
