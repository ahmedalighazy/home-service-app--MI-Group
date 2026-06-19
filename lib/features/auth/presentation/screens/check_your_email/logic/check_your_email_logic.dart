import 'dart:async';
import 'package:flutter/material.dart';

class VerificationController extends ChangeNotifier {
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  bool isButtonEnabled = false;

  Timer? _timer;
  int secondsRemaining = 59;
  bool isTimerActive = true;

  VerificationController() {
    for (var controller in controllers) {
      controller.addListener(_checkCompletion);
    }
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    secondsRemaining = 59;
    isTimerActive = true;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        notifyListeners();
      } else {
        isTimerActive = false;
        _timer?.cancel();
        notifyListeners();
      }
    });
  }

  String get formattedTime {
    final minutes = (secondsRemaining ~/ 60).toString();
    final seconds = (secondsRemaining % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void _checkCompletion() {
    bool completed = controllers.every(
      (controller) => controller.text.isNotEmpty,
    );
    if (completed != isButtonEnabled) {
      isButtonEnabled = completed;
      notifyListeners();
    }
  }

  String get otpCode => controllers.map((c) => c.text).join();

  void handleOtpChange(String value, int index) {
    if (value.length == 1 && index < 3) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  void resendCode() {
    if (!isTimerActive) {
      // ignore: avoid_print
      print("إعادة إرسال الكود...");
      startTimer();
    }
  }

  void verifyCode() {
    if (isButtonEnabled) {
      // ignore: avoid_print
      print("جاري التحقق من الكود: $otpCode");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
