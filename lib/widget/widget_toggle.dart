import 'package:flutter/widgets.dart';

class WidgetToggle extends StatelessWidget {
  const WidgetToggle({super.key, required this.first, required this.other, this.change});

  final Widget first;
  final Widget other;

  final bool? change;

  @override
  Widget build(BuildContext context) {
    return change != null && change == true ? other : first;
  }
}
