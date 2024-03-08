import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/framework/session.dart';
import 'package:project_social/screen/account.dart';
import 'package:project_social/widget/frame.dart';
import 'package:project_social/screen/explore.dart';
import 'package:project_social/screen/matched.dart';
import 'package:project_social/screen/profile.dart';
import 'package:project_social/screen/swipper.dart';
import 'package:project_social/screen/signing.dart';
import 'package:project_social/screen/warning.dart';
import 'package:project_social/screen/connect.dart';
import 'package:project_social/screen/ingress.dart';
import 'package:provider/provider.dart';
import 'package:project_social/framework/environment.dart';

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
        Provider(create: (context) => Environment.work),
        //ChangeNotifierProvider(create: (context) => Manager()), // Manager : ChangeNotifier = service w/ dependency graph
        ChangeNotifierProvider(create: (context) => Session()),
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
        builder: (context, state, shell) => state.uri.toString().contains('/connect?whom=') ? Frameless(shell: shell) : Frameful(shell: shell),
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
              builder: (context, state) => const ExploreScreen(),
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
      GoRoute(path: '/account', builder: (context, state) => const AccountScreen()),
      GoRoute(path: '/profile', builder: (context, state) => ProfileScreen(whom: state.uri.queryParameters['whom'])),
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
