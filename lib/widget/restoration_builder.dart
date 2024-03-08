import 'package:flutter/material.dart';

typedef RestorationWidgetBuilder = Widget Function(BuildContext context);

class RestorationBuilder extends StatefulWidget {
  const RestorationBuilder({super.key, this.restorationId, required this.builder});

  final String? restorationId;
  final RestorationWidgetBuilder builder;

  @override
  State<StatefulWidget> createState() => _RestorationBuilderState();
}

class _RestorationBuilderState extends State<RestorationBuilder> with RestorationMixin {
  RestorableInt value = RestorableInt(0);

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(value, "value");
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
