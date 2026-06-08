import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class CorporateNoteRow extends StatelessWidget {
  final String text;

  const CorporateNoteRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              text,
              style: AppText.regular12Grey.copyWith(
                color: AppColors.black,
                fontSize: 11,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.primary,
            size: 17,
          ),
        ],
      ),
    );
  }
}

