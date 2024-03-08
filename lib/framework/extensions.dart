import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

extension AtMap<K, V> on Map<K, V> {
  V? at(final K key) {
    return this[key];
  }
}

extension IndexList on List<Widget> {
  Map<int, Widget> each(Widget Function(int index, Widget widget) callback) {
    final map = asMap();
    Map<int, Widget> out = <int, Widget>{};
    map.forEach((key, value) {
      out[key] = callback(key, value);
    });

    return out;
  }
}

extension IndexOfKey<K, V> on Map<K, V> {
  int indexOfKey(K key) {
    return keys.toList().indexOf(key);
  }
}

extension ListMap<K, V> on Map<K, V> {
  List<V> toList() {
    return values.toList();
  }
}

extension PutIfAbsetList<V> on List<V> {
  bool insertIfAbsent(int index, V Function() inserter) {
    // TODO: what if [0,1] but putIfAbsent(9,...) ?!
    if (index >= length) {
      insert(index, inserter());
      return true;
    }
    return false;
  }
}

extension StringReverse on String {
  String reverse() {
    String output = "";
    for (int i = length - 1; i > 0; i--) {
      output += this[i];
    }
    return output;
  }
}

/// pushAndRemoveUntil
/// while (router.canPop())
/// router.pop()
/// router.pushReplacement(path)
extension GoPushAndRemoveUntil on GoRouter {
  void pushAndRemoveUntil(String location) {
    inspect(this);
    while (canPop()) {
      pop();
    }
    go(location);
  }
}
