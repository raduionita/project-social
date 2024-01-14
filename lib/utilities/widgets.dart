import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract class CoreWidget extends HookWidget {
  CoreWidget({super.key}) {
    init();
  }

  @protected
  void init();
}
