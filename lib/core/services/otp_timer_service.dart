import 'dart:async';

class OtpTimerService {
  Timer? _timer;
  int _secondsRemaining = 59;
  bool _canResend = false;

  void Function(int)? _onTick;

  void Function()? _onCanResend;

  void startTimer({
    Duration duration = const Duration(seconds: 59),
    void Function(int)? onTick,
    void Function()? onCanResend,
  }) {
    _secondsRemaining = duration.inSeconds;
    _canResend = false;
    _onTick = onTick;
    _onCanResend = onCanResend;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        _canResend = true;
        _timer?.cancel();
        _onCanResend?.call();
      } else {
        _secondsRemaining--;
        _onTick?.call(_secondsRemaining);
      }
    });
  }

  String formatTime() {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  bool canResend() => _canResend;

  int getSecondsRemaining() => _secondsRemaining;

  void reset() {
    _secondsRemaining = 59;
    _canResend = false;
    _timer?.cancel();
  }

  bool isRunning() => _timer?.isActive ?? false;

  void dispose() {
    _timer?.cancel();
    _onTick = null;
    _onCanResend = null;
  }
}
