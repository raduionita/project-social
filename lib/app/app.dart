// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:go_router/go_router.dart';
// core
import 'package:project_social/app/session.dart';
import 'package:project_social/app/extensions.dart';
// screens
import 'package:project_social/screen/account.dart';
import 'package:project_social/screen/explore.dart';
import 'package:project_social/screen/matched.dart';
import 'package:project_social/screen/profile.dart';
import 'package:project_social/screen/swipper.dart';
import 'package:project_social/screen/signing.dart';
import 'package:project_social/screen/warning.dart';
import 'package:project_social/screen/connect.dart';
import 'package:project_social/screen/ingress.dart';
// widgets
import 'package:project_social/widget/frame.dart';

class App extends StatelessWidget {
  // constructor
  const App({super.key});
  // router
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => !Session.of(context).isOnboard ? null : '/sign',
        builder: (context, state) => const IngressScreen(),
      ),
      GoRoute(
        path: '/sign',
        redirect: (context, state) => !Session.of(context).isAuth ? null : '/main',
        builder: (context, state) => const SigningScreen(),
      ),
      GoRoute(
        path: '/main',
        redirect: (context, state) => !Session.of(context).isAuth ? '/' : state.defaultOrNull('/main/swipper'),
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, shell) => state.uri.toString().contains('connect?whom=') ? Frameless(shell: shell) : Frameful(shell: shell),
            branches: [
              StatefulShellBranch(routes: [
                GoRoute(
                  path: 'swipper',
                  builder: (context, state) => const SwipperScreen(),
                ),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: 'explore',
                  builder: (context, state) => const ExploreScreen(),
                ), // frame
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: 'matched',
                  builder: (context, state) => const MatchedScreen(),
                ), // frame
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: 'connect',
                  builder: (context, state) => ConnectScreen(key: const Key('connect'), whom: state.uri.queryParameters['whom']),
                ),
              ]),
            ],
          ),
          GoRoute(path: 'account', builder: (context, state) => const AccountScreen()),
          GoRoute(path: 'profile', builder: (context, state) => ProfileScreen(whom: state.uri.queryParameters['whom'])),
        ],
      ),
    ],
    errorBuilder: (context, state) => WarningScreen(FlutterErrorDetails(exception: Exception(state.error?.message))),
  );
  // begin
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Social Prototype',
      theme: ThemeData.dark().copyWith(
          // colorScheme: ColorScheme.dark(
          //   primary: Colors.red,
          //   secondary: Colors.blue,
          // ),
          ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('en', '')],
    );
  }
}
