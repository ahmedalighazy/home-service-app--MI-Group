import 'package:flutter/material.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';

class ResendCodeTimer extends StatelessWidget {
  final int secondsRemaining;
  final bool canResend;
  final VoidCallback onResend;

  const ResendCodeTimer({
    super.key,
    required this.secondsRemaining,
    required this.canResend,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'لم تتلقى الكود بعد ؟  ',
          style: AppText.ibmDescription14(color: AppColors.secondaryText),
        ),
        GestureDetector(
          onTap: canResend ? onResend : null,
          child: Text(
            canResend
                ? 'أعد إرسال الكود'
                : '0:${secondsRemaining.toString().padLeft(2, '0')}',
            style: AppText.ibmLink13(
              color: canResend ? AppColors.greenPrimary : AppColors.gray,
            ),
          ),
        ),
      ],
    );
  }
}
