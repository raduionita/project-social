import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomStateColor extends MaterialStateProperty<Color> {
  CustomStateColor({required this.color, this.disabled, this.hovered});

  Color? color;
  Color? disabled;
  Color? hovered;

  @override
  resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabled ?? color ?? Colors.purple;
    } else if (states.contains(MaterialState.dragged)) {
    } else if (states.contains(MaterialState.error)) {
    } else if (states.contains(MaterialState.focused)) {
    } else if (states.contains(MaterialState.hovered)) {
      return hovered ?? color ?? Colors.purple;
    } else if (states.contains(MaterialState.pressed)) {
    } else if (states.contains(MaterialState.selected)) {}
    return color ?? Colors.purple;
  }
}
