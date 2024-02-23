import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoneTransition {}

typedef NoTransitionGoRouterPageBuilder = NoTransitionPage<dynamic> Function(BuildContext context, GoRouterState state);
NoTransitionGoRouterPageBuilder useNoTransitionPage({required Widget child}) {
  return (BuildContext context, GoRouterState state) => NoTransitionPage(
        key: state.pageKey,
        child: child,
      );
}
