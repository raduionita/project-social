import 'package:flutter/material.dart';

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

extension ListMap<K, V> on Map<K, V> {
  List<V> toList() {
    return values.toList();
  }
}

extension AtMap<K, V> on Map<K, V> {
  V? at(final K key) {
    return this[key];
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

extension IndexOfKey<K, V> on Map<K, V> {
  int indexOfKey(K key) {
    return keys.toList().indexOf(key);
  }
}
