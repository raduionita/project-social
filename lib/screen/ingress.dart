import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/widget/custom_logo.dart';

/// onboarding // boot (=bootstrap) // init
class IngressScreen extends HookWidget {
  const IngressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('IngressScreen::build()');

    // useTimeout(() {
    //   print('IngressScreen::build()::useTimeout()');
    //   // GoRouter.of(context).go('/swipper', extra: "extra");

    //   GoRouter.of(context).pushAndRemoveUntil('/swipper');

    //   // Navigator.of(context).pushNamedAndRemoveUntil('swipper', (route) => false);
    // }, const Duration(seconds: 2));

    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(flex: 2),
          Flexible(flex: 1, child: Center(child: CustomLogo())),
          Flexible(
              flex: 2,
              child: Column(
                children: [
                  Flexible(flex: 1, child: CircularProgressIndicator(color: Colors.white)),
                  Spacer(flex: 2),
                ],
              ))
        ],
      ),
    );
  }
}
