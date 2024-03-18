import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/framework/extensions.dart';
import 'package:project_social/framework/hooks.dart';
import 'package:project_social/framework/session.dart';
import 'package:project_social/widget/custom_logo.dart';
import 'package:project_social/widget/widget_toggle.dart';

/// onboarding // boot (=bootstrap) // init
class IngressScreen extends HookWidget {
  const IngressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('IngressScreen::build()');

    final toggle = useState(false);
    useTimeout(() => toggle.value = true, const Duration(seconds: 2));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          const Flexible(flex: 1, child: Center(child: CustomLogo())),
          Flexible(
              flex: 2,
              child: Column(
                children: [
                  Flexible(
                      flex: 1,
                      child: WidgetToggle(
                        change: toggle.value,
                        first: const CircularProgressIndicator(color: Colors.white),
                        other: ElevatedButton(
                            onPressed: () {
                              Session.read(context).onOnBoard();
                              GoRouter.of(context).pushAndRemoveUntil('/');
                            },
                            child: const Text("sign", style: TextStyle(color: Colors.white))),
                      )),
                  const Spacer(flex: 2),
                ],
              )),
        ],
      ),
    );
  }
}
