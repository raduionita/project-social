import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/widget/mapped_stack.dart';
import 'package:project_social/screen/chatter.dart';

class ConnectScreen extends HookWidget {
  const ConnectScreen({super.key, this.whom});

  final String? whom;

  @override
  Widget build(BuildContext context) {
    print('ConnectScreen::build($whom)');
    final widgets = useState<Map<String, Widget>>(whom == null ? {} : {whom as String: ChatterScreen(whom: whom!)}); // {"9":Widget, "1":Widget, "6":Widget}
    final current = useState<String?>(whom); // current = "1"

    // selector
    return IndexedStack(
      index: whom == null ? 0 : 1,
      children: [
        // list view
        SizedBox.expand(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => ElevatedButton(
              onPressed: () {
                print('ConnectScreen.ListView.ElevatedButton.onPressed($index)');
                final curr = index.toString();
                widgets.value.putIfAbsent(curr, () => ChatterScreen(whom: curr));
                current.value = curr;
                GoRouter.of(context).go('/main/connect?whom=$index');
              },
              child: Text('to connect::$index'),
            ),
          ),
        ),
        // chat view
        MappedStack(
          active: current.value,
          children: widgets.value,
        )
      ],
    );
  }
}
