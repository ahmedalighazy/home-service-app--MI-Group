import 'package:flutter/material.dart';
import '../../logic/services/otp_timer_service.dart';

class OtpTimerWidget extends StatelessWidget {
  final OtpTimerService timerService;

  const OtpTimerWidget({
    super.key,
    required this.timerService,
  });

  @override
  Widget build(BuildContext context) {
    final remainingSeconds = timerService.remainingSeconds;
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return Text(
      '$minutes:${seconds.toString().padLeft(2, '0')}',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: remainingSeconds < 30 ? Colors.red : Colors.black,
          ),
    );
  }
}
