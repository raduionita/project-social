import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static String routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("auth")),
    );
  }
}
