import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/widget/custom_bar.dart';

/// onboarding
class AccountScreen extends HookWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('AccountScreen::build()');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBar(
        title: const Text("account"),
        buttons: [
          CustomBack(onPressed: () => GoRouter.of(context).canPop() ? GoRouter.of(context).pop() : GoRouter.of(context).go('/')),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
