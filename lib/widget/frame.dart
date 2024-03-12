import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/widget/avatar_button.dart';
import 'package:project_social/widget/custom_bar.dart';

enum FramePage {
  swipper,
  explore,
  matched,
  connect,
}

extension FramePageExtension on FramePage {
  String get name => switch (this) {
        FramePage.swipper => 'swipper',
        FramePage.explore => 'explore',
        FramePage.matched => 'matched',
        FramePage.connect => 'connect',
      };
  int get index => switch (this) {
        FramePage.swipper => 0,
        FramePage.explore => 1,
        FramePage.matched => 2,
        FramePage.connect => 3,
      };
}

class Frameful extends StatelessWidget {
  const Frameful({super.key, required this.shell});

  static const swipper = FramePage.swipper;
  static const explore = FramePage.explore;
  static const matched = FramePage.matched;
  static const connect = FramePage.connect;

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    print('Frame::build()');
    // content
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBar(
        title: Text(GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString()),
        buttons: [
          AvatarButton(
            onPressed: () => GoRouter.of(context).push('/main/account'),
          ),
        ],
        actions: [
          IconButton(
            //padding: const EdgeInsets.all(1 + kToolbarHeight / 4),
            icon: const Badge(
              label: Text('3'),
              backgroundColor: Colors.red,
              child: Icon(Icons.notifications_outlined),
            ),
            onPressed: () {
              print("Frame::AppBar::actions[0]::onPressed()");
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
        ],
      ),

      // appBar: AppBar(
      //     //toolbarHeight: kToolbarHeight,
      //     title: Text(GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString()),
      //     centerTitle: false,
      //     titleSpacing: NavigationToolbar.kMiddleSpacing - (kToolbarHeight / 4),
      //     leading: IconButton(
      //       //color: Colors.red,
      //       padding: const EdgeInsets.all(1 + kToolbarHeight / 4),
      //       icon: const Icon(Icons.account_circle_outlined),
      //       onPressed: () {
      //         print("Frame::AppBar::leading::onPressed()");
      //         // Scaffold.of(context).openDrawer();
      //         GoRouter.of(context).push('/account');
      //       },
      //     ),
      //     backgroundColor: Colors.black45, // Theme.of(context).colorScheme.background, // keep the same as sufrace
      //     surfaceTintColor: Theme.of(context).colorScheme.background, // keep the same as background
      //     //shadowColor: Theme.of(context).colorScheme.inversePrimary,
      //     forceMaterialTransparency: false,
      //     automaticallyImplyLeading: true,
      //     elevation: 0,
      //     actions: [
      //       IconButton(
      //         padding: const EdgeInsets.all(1 + kToolbarHeight / 4),
      //         icon: const Badge(
      //           label: Text('3'),
      //           backgroundColor: Colors.red,
      //           child: Icon(Icons.notifications_outlined),
      //         ),
      //         onPressed: () {
      //           print("Frame::AppBar::actions[0]::onPressed()");
      //           showModalBottomSheet(
      //               context: context,
      //               backgroundColor: Theme.of(context).colorScheme.background,
      //               showDragHandle: true,
      //               builder: (context) {
      //                 return SizedBox(
      //                   height: 200,
      //                   child: Center(
      //                     child: Column(
      //                       children: [ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('close'))],
      //                     ),
      //                   ),
      //                 );
      //               });
      //         },
      //       )
      //     ]),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(child: shell),
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
            label: 'swipper',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline),
            label: 'matched',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'chatter',
          )
        ],
        currentIndex: shell.currentIndex,
        selectedIconTheme: const IconThemeData(color: Colors.redAccent, size: 32),
        unselectedIconTheme: const IconThemeData(color: Colors.white70, size: 32),
        onTap: (int index) {
          print("Frame::BottomNavigationBar::onTap() $index");
          shell.goBranch(index); //, initialLocation: index == shell.currentIndex);
        },
      ),
    );
  }
}

class Frameless extends StatelessWidget {
  const Frameless({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: shell),
    );
  }
}
