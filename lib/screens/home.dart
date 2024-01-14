import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/screens/explore.dart';
import 'package:project_social/screens/profile.dart';
import 'package:project_social/screens/swipper.dart';

enum Page { swipper, explore, profile }

class HomeScreen extends HookWidget {
  static String routeName = '/home';

  static const String swipper = 'swipper';
  static const String explore = 'explore';
  static const String profile = 'profile';

  final int page;

  const HomeScreen(this.page, {super.key});

  factory HomeScreen.from(String? page) => switch (page) {
        HomeScreen.swipper => const HomeScreen(0),
        HomeScreen.explore => const HomeScreen(1),
        HomeScreen.profile => const HomeScreen(2),
        _ => const HomeScreen(0),
      };

  @override
  Widget build(BuildContext context) {
    print('HomeScreen::build()');
    print(ModalRoute.of(context)?.settings.arguments);

    // state
    final page = useState<int>(this.page);
    // content
    return Scaffold(
        appBar: AppBar(
          title: const Text("home"),
          backgroundColor: Theme.of(context).colorScheme.background,
          automaticallyImplyLeading: false,
          elevation: 4,
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () => {print("HomeScreen::build()::IconButton::onPressed()")},
                  icon: const Icon(Icons.notifications_outlined),
                ),
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                    constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                    child: const Text(
                      '2',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background.withAlpha(250),
        body: IndexedStack(
          index: page.value,
          children: const [
            SwipperScreen(),
            ExploreScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 4.0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.swipe_outlined),
              label: 'swiper',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: 'explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'profile',
            )
          ],
          currentIndex: page.value,
          selectedIconTheme: const IconThemeData(color: Colors.redAccent, size: 40),
          selectedItemColor: Colors.red[500],
          onTap: (int index) => {page.value = index},
        ));
  }
}
