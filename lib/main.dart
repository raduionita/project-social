import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/widgets/frame.dart';
import 'package:project_social/screens/explore.dart';
import 'package:project_social/screens/matched.dart';
import 'package:project_social/screens/profile.dart';
import 'package:project_social/screens/swipper.dart';
import 'package:project_social/screens/signing.dart';
import 'package:project_social/screens/warning.dart';
import 'package:project_social/screens/connect.dart';
import 'package:project_social/screens/ingress.dart';
import 'package:provider/provider.dart';
import 'package:project_social/constants/environment.dart';

void main() {
  // setup
  WidgetsFlutterBinding.ensureInitialized();
  // chrome
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // error
  // FlutterError.onError = (details) {
  //   print("FlutterError.onError()");
  //   FlutterError.dumpErrorToConsole(details);
  //   runApp(MaterialApp(home: OupsScreen(details)));
  // };
  // ErrorWidget.builder = (details) {
  //   print("ErrorWidget.builder()");
  //   FlutterError.dumpErrorToConsole(details);
  //   return MaterialApp(home: OupsScreen(details));
  // };
  // start
  runApp(
    MultiProvider(
      providers: [
        Provider<Environment>.value(value: Environment.work),
      ],
      child: const App(key: Key('App')),
    ),
  );
}

class App extends StatelessWidget {
  // constructor
  const App({super.key});
  // router
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const IngressScreen(),
      ),
      GoRoute(
        path: '/signing',
        builder: (context, state) => const SigningScreen(),
      ),
      StatefulShellRoute.indexedStack(
        // builder: (context, state, shell) => state.uri.toString().contains('/connect?whom=') ? Frameless(shell: shell) : Frameful(shell: shell),
        pageBuilder: (context, state, shell) => CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(seconds: 3),
            child: state.uri.toString().contains('/connect?whom=') ? Frameless(shell: shell) : Frameful(shell: shell),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              print('StatefulShellRoute.pageBuilder.transitionsBuilder()');
              return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation), child: child);
            }),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/swipper',
              builder: (context, state) => const SwipperScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/explore',
              // builder: (context, state) => const ExploreScreen(),
              pageBuilder: (context, state) {
                print('GoRoute.pageBuilder()');
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const ExploreScreen(),
                  transitionDuration: const Duration(seconds: 3),
                  transitionsBuilder: (context, animation, _, child) {
                    print('GoRoute.pageBuilder.transitionsBuilder()');
                    return SlideTransition(position: Tween(begin: const Offset(1, 0), end: Offset.zero).animate(animation), child: child);
                  },
                );
              },
            ), // frame
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/matched',
              builder: (context, state) => const MatchedScreen(),
            ), // frame
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/connect',
              builder: (context, state) => ConnectScreen(key: const Key('connect'), whom: state.uri.queryParameters['whom']),
            ),
          ]),
        ],
      ),
      GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
    ],
    // redirect: (context, state) {
    //   print('App::router::redirect ${state.fullPath}');
    //   // if bInited => go to home or auth
    //   return null;
    // },
    errorBuilder: (context, state) => WarningScreen(FlutterErrorDetails(exception: Exception(state.error?.message))),
  );
  // begin
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Social Prototype',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', ''),
      ],
    );
  }
}
