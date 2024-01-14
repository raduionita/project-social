import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_social/screens/auth.dart';
import 'package:project_social/screens/home.dart';
import 'package:project_social/screens/init.dart';
import 'package:provider/provider.dart';
import 'package:project_social/constants/environment.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
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
        routerConfig: GoRouter(routes: [
          GoRoute(path: '/', builder: (context, state) => const InitScreen()),
          GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
          GoRoute(path: '/home/:name', builder: (context, state) => HomeScreen.from(state.pathParameters['name'])),
        ]));
  }
}
