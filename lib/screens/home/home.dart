import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/screens/home/explore.dart';
import 'package:project_social/screens/home/chatter.dart';
import 'package:project_social/screens/home/favorit.dart';
import 'package:project_social/screens/home/swipper.dart';

enum HomePage {
  swipper,
  explore,
  favorit,
  chatter,
}

extension HomePageExtension on HomePage {
  String get name => switch (this) {
        HomePage.swipper => 'swipper',
        HomePage.explore => 'explore',
        HomePage.favorit => 'favorit',
        HomePage.chatter => 'chatter',
      };
  int get index => switch (this) {
        HomePage.swipper => 0,
        HomePage.explore => 1,
        HomePage.favorit => 2,
        HomePage.chatter => 3,
      };
}

class HomeScreen extends HookWidget {
  static String routeName = '/home';

  static const String swipper = 'swipper';
  static const String explore = 'explore';
  static const String favorit = 'favorit';
  static const String chatter = 'chatter';
  static const List<String> pages = ['swipper', 'explore', 'favorit', 'chatter'];

  final HomePage page;

  const HomeScreen(this.page, {super.key});

  factory HomeScreen.from(String? page) => switch (page) {
        HomeScreen.swipper => const HomeScreen(HomePage.swipper),
        HomeScreen.explore => const HomeScreen(HomePage.explore),
        HomeScreen.favorit => const HomeScreen(HomePage.favorit),
        HomeScreen.chatter => const HomeScreen(HomePage.chatter),
        _ => const HomeScreen(HomePage.swipper),
      };

  @override
  Widget build(BuildContext context) {
    print('HomeScreen::build()');
    print(ModalRoute.of(context)?.settings.arguments);

    // state
    final page = useState<int>(this.page.index);
    // content
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          //toolbarHeight: kToolbarHeight,
          title: const Text("home"),
          centerTitle: false,
          titleSpacing: NavigationToolbar.kMiddleSpacing - (kToolbarHeight / 4),
          leading: Builder(
            builder: (context) => IconButton(
              //color: Colors.red,
              padding: const EdgeInsets.all(1 + kToolbarHeight / 4),
              icon: const Icon(Icons.account_circle_outlined),
              onPressed: () {
                print("HomeScreen::AppBar::leading::onPressed()");
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          //forceMaterialTransparency: true,
          automaticallyImplyLeading: true,
          elevation: 0,
          actions: [
            IconButton(
              padding: const EdgeInsets.all(1 + kToolbarHeight / 4),
              icon: const Badge(
                label: Text('3'),
                backgroundColor: Colors.red,
                child: Icon(Icons.notifications_outlined),
              ),
              onPressed: () {
                print("HomeScreen::AppBar::actions[0]::onPressed()");
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    showDragHandle: true,
                    builder: (context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            children: [ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('close'))],
                          ),
                        ),
                      );
                    });
              },
            )
          ]),
      drawer: NavigationDrawer(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.background,
        onDestinationSelected: (value) => {print("HomeScreen::NavigationDrawer::onDestinationSelected() $value")},
        elevation: 10,
        children: const [
          Padding(padding: EdgeInsets.fromLTRB(16, 16, 16, 16)),
          NavigationDrawerDestination(icon: Icon(Icons.account_circle_outlined), label: Text('<profile name>')),
          Padding(padding: EdgeInsets.only(top: 0), child: Divider(thickness: 1)),
          NavigationDrawerDestination(icon: Icon(Icons.settings_outlined), label: Text('Settings')),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: IndexedStack(
          index: page.value,
          children: const [
            SwipperScreen(),
            ExploreScreen(),
            FavoritScreen(),
            ChatterScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
            icon: Icon(Icons.star_outline),
            label: 'favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'profile',
          )
        ],
        currentIndex: page.value,
        selectedIconTheme: const IconThemeData(color: Colors.redAccent, size: 32),
        unselectedIconTheme: const IconThemeData(color: Colors.white70, size: 32),
        onTap: (int index) {
          page.value = index;
        },
      ),
    );
  }
}
