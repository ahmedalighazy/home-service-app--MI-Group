import 'dart:async';

/// Manages OTP countdown timer state and lifecycle
/// 
/// Handles timer logic separately from UI to ensure clean separation of concerns.
/// Usage:
/// ```dart
/// late OtpTimerService _timerService;
/// 
/// @override
/// void initState() {
///   _timerService = OtpTimerService();
///   _timerService.startTimer(
///     onTick: (remaining) {
///       setState(() => _timeRemaining = remaining);
///     },
///     onCanResend: () {
///       setState(() {}); // Update UI when can resend
///     },
///   );
/// }
/// 
/// @override
/// void dispose() {
///   _timerService.dispose();
///   super.dispose();
/// }
/// ```
class OtpTimerService {
  Timer? _timer;
  int _secondsRemaining = 59;
  bool _canResend = false;

  /// Callback when timer ticks
  void Function(int)? _onTick;

  /// Callback when timer completes and user can resend
  void Function()? _onCanResend;

  /// Start the countdown timer
  /// 
  /// [duration]: The duration for the timer (default: 59 seconds)
  /// [onTick]: Called each second with remaining seconds
  /// [onCanResend]: Called when timer completes
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

  /// Format time as "m:ss" string
  /// 
  /// Example: "0:59", "0:30", "0:05"
  String formatTime() {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  /// Check if user can resend the OTP code
  bool canResend() => _canResend;

  /// Get the number of seconds remaining
  int getSecondsRemaining() => _secondsRemaining;

  /// Reset timer for resend
  /// 
  /// Use this when user clicks "Resend Code"
  void reset() {
    _secondsRemaining = 59;
    _canResend = false;
    _timer?.cancel();
  }

  /// Check if timer is still running
  bool isRunning() => _timer?.isActive ?? false;

  /// Dispose and clean up resources
  /// 
  /// Call this in the State's dispose() method
  void dispose() {
    _timer?.cancel();
    _onTick = null;
    _onCanResend = null;
  }
}
