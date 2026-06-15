import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class ForgetPasswordLink extends StatelessWidget {
  const ForgetPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'نسيت كلمة المرورو؟',
              textAlign: TextAlign.center,
              style: AppText.regularIbm(
                fontSize: 14,
                color: const Color(0xFF189AB4),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Color(0xFF189AB4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
