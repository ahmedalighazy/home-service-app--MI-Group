import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class AuthAnimation implements TickerProvider {
  late final AnimationController shakeCtrl;
  late final Animation<double> shakeAnim;

  AuthAnimation() {
    shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: shakeCtrl, curve: Curves.easeInOut));
  }

  void startShake() {
    shakeCtrl.forward(from: 0.0);
  }

  void dispose() {
    shakeCtrl.dispose();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
