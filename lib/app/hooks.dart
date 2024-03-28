import 'dart:async';
import 'package:flutter/material.dart';
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

/// Flutter state hook that tracks a Set.
SetAction<E> useSet<E>(Set<E> initialSet) {
  final set = useState(initialSet);

  final value = useCallback<Set<E> Function()>(() {
    return set.value;
  }, const []);

  final contains = useCallback<bool Function(E element)>((element) {
    return set.value.contains(element);
  }, const []);

  final add = useCallback<void Function(E element)>((element) {
    set.value = {
      ...set.value,
      ...{element}
    };
  }, const []);

  final addAll = useCallback<void Function(Set<E>)>((value) {
    set.value = {...set.value, ...value};
  }, const []);

  final replace = useCallback<void Function(Set<E>)>((newMap) {
    set.value = newMap;
  }, const []);

  final remove = useCallback<void Function(E element)>((element) {
    final removedSet = {...set.value};
    removedSet.remove(element);
    set.value = removedSet;
  }, const []);

  final reset = useCallback<VoidCallback>(() {
    set.value = initialSet;
  }, const []);

  final toggle = useCallback<void Function(E element)>((element) {
    final toggleSet = {...set.value};
    toggleSet.contains(element) ? toggleSet.remove(element) : toggleSet.add(element);
    set.value = toggleSet;
  }, const []);

  final toList = useCallback<List<E> Function()>(() {
    return set.value.toList();
  }, const []);

  final state = useRef(SetAction<E>(value, contains, add, addAll, replace, toggle, remove, reset, toList));
  return state.value;
}

class SetAction<E> {
  const SetAction(
    this._set,
    this.contains,
    this.add,
    this.addAll,
    this.replace,
    this.toggle,
    this.remove,
    this.reset,
    this.toList,
  );

  final bool Function(E element) contains;
  final void Function(E element) add;
  final void Function(Set<E>) addAll;
  final void Function(Set<E>) replace;
  final void Function(E element) toggle;
  final void Function(E element) remove;
  final List<E> Function() toList;
  final VoidCallback reset;
  final Set<E> Function() _set;

  Set<E> get set => _set();
}
