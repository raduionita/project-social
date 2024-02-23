import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/widgets/future_list.dart';

class ExploreScreen extends HookWidget {
  const ExploreScreen({super.key});

  Future<List<String>> getStringList() {
    print('ExploreScreen::getStringList()');
    try {
      return Future.delayed(const Duration(seconds: 2)).then((value) {
        return ['zero', 'one', 'two', 'three', 'four', UniqueKey().toString()];
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('ExploreScreen::build()');

    final counter = useState(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // row 0
        const Center(child: Text("explore", style: TextStyle(color: Colors.white))),
        // row 1
        FutureList(
          futureCaller: getStringList,
          itemBuilder: (context, index, item) {
            return Text(item!);
          },
        ),
        // row 2 // button
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FloatingActionButton(
              shape: const CircleBorder(),
              child: const Icon(Icons.plus_one_outlined),
              onPressed: () {
                counter.value++;
                print('ExploreScreen::FloatingActionButton::onPressed()');
              },
            ),
          ),
        ),
      ],
    );
  }
}
