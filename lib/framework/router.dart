import 'package:go_router/go_router.dart';

class CustomRoute extends GoRoute {
  CustomRoute({required super.path});
}



















// import 'package:flutter/material.dart';

// class Route {
//   late final List<Route> routes;
// }

// class Configuration {}

// class RoutingParser extends RouteInformationParser<Configuration> {}

// class RoutingProvider extends RouteInformationProvider with ChangeNotifier {
//   @override
//   void addListener(VoidCallback listener) {
//     // TODO: implement addListener
//   }

//   @override
//   void removeListener(VoidCallback listener) {
//     // TODO: implement removeListener
//   }

//   @override
//   // TODO: implement value
//   RouteInformation get value => throw UnimplementedError();
// }

// class Shell extends StatelessWidget {
//   const Shell({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'home'),
//         ],
//       ),
//     );
//   }
// }

// class RoutingDelegate extends RouterDelegate<Configuration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<Configuration> {
//   @override
//   final GlobalKey<NavigatorState> navigatorKey;

//   RoutingDelegate() : navigatorKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       pages: const [MaterialPage(child: Shell())],
//       onPopPage: (route, result) {
//         if (!route.didPop(result)) {
//           return false;
//         }

//         // todo: if state.selected != null ...

//         // 404 = false
//         notifyListeners();
//         return true;
//       },
//     );
//   }

//   @override
//   Future<void> setNewRoutePath(Configuration configuration) async {
//     print('RoutingDelegate.setNewRoutePath');
//     // todo: if path is SomeWidgetPath
//     // state.selected = 1;
//   }

//   @override
//   Configuration? get currentConfiguration => null; // todo: switch (state.selected) return SomeWidgetPath;
// }

// class RoutingSetup {
//   final GlobalKey<NavigatorState> navigatorKey;

//   RoutingSetup({
//     required this.navigatorKey,
//   });
// }

// class RoutingBackButtonDispatcher extends BackButtonDispatcher with WidgetsBindingObserver {}

// class Routing extends RouterConfig<Configuration> {
//   late final List<Route> routes;

//   @override
//   final BackButtonDispatcher backButtonDispatcher;
//   @override
//   late final RoutingParser? routeInformationParser;
//   @override
//   late final RoutingProvider? routeInformationProvider;
//   @override
//   late final RoutingDelegate routerDelegate;

//   late final RoutingSetup routingSetup;

//   factory Routing({
//     required List<Route> routes,
//     GlobalKey<NavigatorState>? navigatorKey,
//   }) {
//     return Routing.routingConfig(
//       routes: routes,
//       navigatorKey: navigatorKey,
//     );
//   }

//   Routing.routingConfig({
//     required this.routes,
//     GlobalKey<NavigatorState>? navigatorKey,
//   })  : backButtonDispatcher = RoutingBackButtonDispatcher(),
//         super(routerDelegate: null) {
//     WidgetsFlutterBinding.ensureInitialized();

//     navigatorKey ??= GlobalKey<NavigatorState>();

//     routingSetup = RoutingSetup(navigatorKey: navigatorKey);

//     routeInformationParser = RoutingParser();

//     routerDelegate = RoutingDelegate();
//   }
// }
