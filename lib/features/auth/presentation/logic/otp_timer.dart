import 'dart:async';

class OtpTimer {
  final int totalSeconds;
  final void Function(int secondsLeft, bool canResend) onTick;
  final void Function()? onFinished;
  Timer? _timer;
  int _secondsLeft;
  bool _canResend = false;

  OtpTimer({required this.totalSeconds, required this.onTick, this.onFinished})
    : _secondsLeft = totalSeconds;

  int get secondsLeft => _secondsLeft;
  bool get canResend => _canResend;

  void start() {
    _timer?.cancel();
    _secondsLeft = totalSeconds;
    _canResend = false;
    onTick(_secondsLeft, _canResend);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        _secondsLeft--;
        onTick(_secondsLeft, _canResend);
      } else {
        _canResend = true;
        onTick(_secondsLeft, _canResend);
        timer.cancel();
        onFinished?.call();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }
}
