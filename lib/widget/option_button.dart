import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({super.key, this.onSelect, required this.selected, required this.child, this.selectedBackgroundColor, this.selectedTextColor});

  final VoidCallback? onSelect;
  final Widget child;
  final bool selected;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;

  @override
  Widget build(BuildContext context) => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: selected ? selectedBackgroundColor : null,
          foregroundColor: selected ? selectedTextColor : null,
        ),
        onPressed: onSelect,
        child: child,
      );
}
