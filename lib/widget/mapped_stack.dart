import 'package:flutter/widgets.dart';
import 'package:project_social/app/extensions.dart';

class MappedStack<K> extends StatelessWidget {
  /// key-value (`Map<String,Widget>`) `IndexedStack` \
  /// where `.active` child is a key in the map
  const MappedStack({super.key, this.active, required this.children});

  final K? active;
  final Map<K, Widget> children;

  @override
  Widget build(BuildContext context) {
    final int? index = active == null ? null : children.indexOfKey(active as K);
    return IndexedStack(
      index: index,
      children: children.values.toList(),
    );
  }
}
