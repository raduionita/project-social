import 'package:flutter/widgets.dart';

const empty = Empty();

class Empty extends Widget {
  const Empty({super.key});

  @override
  Element createElement() => _EmptyElement(this);
}

class _EmptyElement extends Element {
  _EmptyElement(Empty super.widget);

  @override
  void mount(Element? parent, dynamic newSlot) {
    assert(parent is! MultiChildRenderObjectElement, 'Empty may not be needed here. Try removing it!');
    super.mount(parent, newSlot);
  }

  @override
  bool get debugDoingBuild => false;
}
