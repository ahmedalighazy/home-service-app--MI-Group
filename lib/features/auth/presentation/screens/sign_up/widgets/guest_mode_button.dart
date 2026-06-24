import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/language/language_cubit.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';

class GuestModeButton extends StatelessWidget {
  final VoidCallback onTap;

  const GuestModeButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      bloc: getIt<LanguageCubit>(),
      builder: (context, state) {
        return TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            AppStrings.continueAsGuest,
            style: AppText.ibmLink13(color: AppColors.greenPrimary).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.greenPrimary,
            ),
          ),
        );
      },
    );
  }
}
