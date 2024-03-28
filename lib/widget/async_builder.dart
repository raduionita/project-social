import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:project_social/app/hooks.dart';

class AsyncBuilder<T> extends HookWidget {
  const AsyncBuilder({super.key, required this.future, this.builder});

  final Future<T> future;
  final Widget? Function(BuildContext context, T item)? builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none || ConnectionState.waiting || ConnectionState.active:
              return const CircularProgressIndicator();
            case ConnectionState.done:
              if (builder != null && snapshot.hasData) {
                return builder!(context, snapshot.requireData) ?? const SizedBox.shrink();
              }
          }
          return const SizedBox.shrink();
        });
  }
}
