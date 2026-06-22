import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/language/language_cubit.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

import '../../../../core/themes/text/app_text.dart';

class LanguageTrailingText extends StatelessWidget {
  const LanguageTrailingText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      bloc: getIt<LanguageCubit>(),
      builder: (context, state) {
        final currentLanguage = state.isArabic ? 'العربية' : 'English';
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentLanguage,
              style: AppText.ibmDescription14().copyWith(
                color: AppColors.textLightGrey,
                fontSize: 15,
              ),
            ),
            Icon(
              state.isArabic ? Icons.chevron_left : Icons.chevron_right,
              color: AppColors.textLightGrey,
            ),
          ],
        );
      },
    );
  }
}
