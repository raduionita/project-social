import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// onboarding
class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('ProfileScreen::build()');

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
