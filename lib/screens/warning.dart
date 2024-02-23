import 'package:flutter/material.dart';

class WarningScreen extends StatelessWidget {
  final FlutterErrorDetails error;

  const WarningScreen(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    print('WarningScreen::build()');
    return Scaffold(
      body: Center(
        child: Text(error.exceptionAsString()),
      ),
    );
  }
}
