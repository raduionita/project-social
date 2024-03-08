import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/widget/custom_bar.dart';

/// onboarding
class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key, required this.whom});

  final String? whom;

  @override
  Widget build(BuildContext context) {
    print('ProfileScreen::build()');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBar(
        title: Text("chatter:$whom"),
        buttons: [
          CustomBack(onPressed: () => GoRouter.of(context).pop()),
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
