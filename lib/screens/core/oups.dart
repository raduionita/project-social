import 'package:flutter/material.dart';

class OupsScreen extends StatelessWidget {
  final FlutterErrorDetails error;

  const OupsScreen(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(error.exceptionAsString()),
      ),
    );
  }
}
