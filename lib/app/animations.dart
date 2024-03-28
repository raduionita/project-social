import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

TickerFuture? animateTo(ValueNotifier<double> target, double end, Duration duration) {
  Ticker? ticker;
  final neg = end < 0;
  final ini = target.value;
  final gap = end - ini; // -900 - - 300 = -600
  ticker = Ticker((Duration els) {
    if (els.inMilliseconds == 0) return;
    final dif = (duration - els).inMilliseconds; // 250 - 050 = 200 | 250 - 100 = 150 | 100 | 50...
    final rpr = dif / duration.inMilliseconds; // 0.8 | 0.6 | 0.4 | 0.2...
    final one = Curves.easeInOut.transform(1.0 - rpr.abs()); // 0.2 | 0.4 | 0.6...
    final out = ini + (one * gap);

    target.value = out;
    if ((neg && (out <= (ini + gap))) || (!neg && (out >= (ini + gap)))) {
      target.value = out;
      ticker?.stop();
    }
  });

  return ticker.start();
}

Future<void> animateToPage(PageController controller, int page, {required Duration duration, required Curve curve}) {
  return controller.animateToPage(page, duration: duration, curve: curve);
}
