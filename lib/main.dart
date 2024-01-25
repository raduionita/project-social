import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/screens/auth/auth.dart';
import 'package:project_social/screens/core/oups.dart';
import 'package:project_social/screens/home/home.dart';
import 'package:project_social/screens/init/init.dart';
import 'package:provider/provider.dart';
import 'package:project_social/constants/environment.dart';

void main() {
  // setup
  WidgetsFlutterBinding.ensureInitialized();
  ////SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
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
  const App({super.key});

  static GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const InitScreen()),
      GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
      GoRoute(path: '/home', redirect: (context, state) => '/home/swipper'),
      GoRoute(path: '/home/:name', builder: (context, state) => HomeScreen.from(state.pathParameters['name'])),
    ],
    redirect: (context, state) {
      print('App::router::redirect ${state.fullPath}');
      // if bInited => go to home or auth

      return null;
    },
    errorBuilder: (context, state) => OupsScreen(FlutterErrorDetails(exception: Exception(state.error?.message))),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Social Prototype',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          })),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', ''),
      ],
      routerConfig: router,
    );
  }
}
