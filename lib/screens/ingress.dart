import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/utilities/hooks.dart';

/// onboarding // boot (=bootstrap) // init
class IngressScreen extends HookWidget {
  static String routeName = '/init';

  const IngressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('IngressScreen::build()');

    useTimeout(() {
      print('IngressScreen::build()::useTimeout()');
      GoRouter.of(context).go('/swipper', extra: "extra");

      // .pushNamedAndRemoveUntil
    }, const Duration(seconds: 2));

    return const Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Text('ingress'),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    ));
  }
}
