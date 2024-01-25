import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/utilities/hooks.dart';

/// onboarding
class InitScreen extends HookWidget {
  static String routeName = '/init';

  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('InitScreen::build()');

    useTimeout(() {
      print('InitScreen::build()::useTimeout()');
      context.go('/home/chatter', extra: "extra");
      // .pushNamedAndRemoveUntil
    }, const Duration(seconds: 5));

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
