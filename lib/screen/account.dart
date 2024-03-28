import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/app/extensions.dart';
import 'package:project_social/app/hooks.dart';
import 'package:project_social/app/session.dart';
import 'package:project_social/widget/custom_bar.dart';
import 'package:project_social/widget/widget_toggle.dart';

/// onboarding
class AccountScreen extends HookWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('AccountScreen::build()');

    final toggle = useState(false);
    useTimeout(() => toggle.value = true, const Duration(seconds: 2));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBar(
        title: const Text("account"),
        buttons: [
          CustomBack(onPressed: () => GoRouter.of(context).canPop() ? GoRouter.of(context).pop() : GoRouter.of(context).go('/')),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: WidgetToggle(
            change: toggle.value,
            first: const CircularProgressIndicator(color: Colors.white),
            other: ElevatedButton(
                onPressed: () {
                  Session.read(context).clear();
                  GoRouter.of(context).pushAndRemoveUntil('/');
                },
                child: const Text("nuke", style: TextStyle(color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
