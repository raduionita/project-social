import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/utilities/animations.dart';
import 'package:project_social/widgets/wrapper.dart';

class SwipperScreen extends HookWidget {
  const SwipperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('SwipperScreen::build()');

    final paginator = usePageController(viewportFraction: 1);
    final height = useRef(MediaQuery.of(context).size.height);
    final limit = useState(3);

    return Stack(
      children: [
        // background
        const Center(
          child: CircularProgressIndicator(),
        ),
        // forground
        ListView.builder(
          //itemCount: 10,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          controller: paginator,
          itemBuilder: (context, listIndex) {
            if (listIndex >= limit.value) return null;
            //print('ListView::itemBuilder($listIndex)');
            return Wrapper(
              width: MediaQuery.of(context).size.width,
              childBuilder: () {
                final offsetY = useState(0.0);
                final visible = useState<bool>(true);
                final stoped = useState(false);
                return GestureDetector(
                  onVerticalDragUpdate: (details) async {
                    if (stoped.value) return;
                    offsetY.value += details.delta.dy;
                    final thrsd = (height.value * 0.65) / 2; // threshold
                    bool bUp = (offsetY.value < -thrsd);
                    bool bDn = (offsetY.value > thrsd);
                    if (bDn || bUp) {
                      stoped.value = true;
                      // offsetY.value = 1000;
                      await animateTo(offsetY, (height.value * 0.9) * (bDn ? 1 : -1), const Duration(milliseconds: 250));
                      visible.value = false;
                      await animateToPage(paginator, paginator.page!.toInt() + 1, duration: const Duration(milliseconds: 250), curve: Curves.fastEaseInToSlowEaseOut);
                    }
                  },
                  onVerticalDragEnd: (details) {
                    offsetY.value = 0.0;
                    stoped.value = !stoped.value;
                  },
                  child: Visibility(
                    visible: visible.value,
                    child: Container(
                      transform: Matrix4.identity()..setTranslationRaw(0, offsetY.value, 0),
                      color: Colors.pink,
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      margin: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('item $listIndex'),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                child: const Icon(Icons.arrow_upward_outlined),
                                onPressed: () async {
                                  await animateTo(offsetY, (height.value * 0.9) * -1, const Duration(milliseconds: 250));
                                  await animateToPage(paginator, paginator.page!.toInt() + 1, duration: const Duration(milliseconds: 250), curve: Curves.fastEaseInToSlowEaseOut);
                                },
                              ),
                              const Divider(),
                              ElevatedButton(
                                child: const Icon(Icons.arrow_downward_outlined),
                                onPressed: () async {
                                  await animateTo(offsetY, (height.value * 0.9) * 1, const Duration(milliseconds: 250));
                                  await animateToPage(paginator, paginator.page!.toInt() + 1, duration: const Duration(milliseconds: 250), curve: Curves.fastEaseInToSlowEaseOut);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
