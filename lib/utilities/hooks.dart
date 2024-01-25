import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// executes callback periodically (delay)
void useInterval(VoidCallback callback, Duration delay) {
  final ref = useRef(callback);
  // update ref on each build
  ref.value = callback;

  useEffect(() {
    final timer = Timer.periodic(delay, (_) => ref.value());
    return timer.cancel;
  }, [delay]);
}

/// excutes callback once (after delay)
void useTimeout(VoidCallback callback, Duration delay) {
  print('useTimeout()');
  useEffect(() {
    print('useTimeout()::useEffect()');
    final timer = Timer(delay, () {
      callback();
    });
    return timer.cancel;
  }, [delay]);
}

/// execute effect only once
void useEffectOnce(Dispose? Function() effect) {
  return useEffect(effect, const []);
}

/// trigger on mount
void useMount(VoidCallback callback) {
  // ignore: body_might_complete_normally_nullable
  return useEffectOnce(() {
    callback();
  });
}

/// trigger on unmount
void useUnmount(VoidCallback callback) {
  final ref = useRef(callback);
  // update ref on each build
  ref.value = callback;
  return useEffectOnce(() => () => ref.value());
}

bool useInitialMount() {
  final isInit = useRef(true);
  if (isInit.value) {
    isInit.value = false;
    return true;
  }
  return isInit.value;
}

/// runs the future just once, and caches it
/// ```dart
/// final memorized = useMemorizedFuture(() { return Future...  });
/// fetchData() {
///   return memorized.runOnce(() async {
///     await Future.delayed(Duration(seconds:2));
///     return 'remote data';
///   });
/// }
/// FutureBuilder(future: fetchData())
/// ```
Future<T> useMemorizedFuture<T>(FutureOr<T> Function() callback) {
  final completer = useRef<Completer<T>>(Completer());
  final future = useRef<Future<T>>(completer.value.future);
  if (!completer.value.isCompleted) {
    completer.value.complete(Future.sync(callback));
  }
  return future.value;
}
