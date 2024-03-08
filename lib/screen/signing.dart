import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// ignore: must_be_immutable
class SigningScreen extends HookWidget {
  const SigningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('SigningScreen::build()');
    final rand = useRef(Random().nextInt(100));
    return Scaffold(
      appBar: AppBar(title: Text("auth ${rand.value}")),
    );
  }
}
