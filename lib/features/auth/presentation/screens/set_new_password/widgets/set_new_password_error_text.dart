import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/language/language_cubit.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class SetNewPasswordErrorText extends StatelessWidget {
  const SetNewPasswordErrorText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment:
            context.select<LanguageCubit, bool>((c) => c.state.isArabic)
                ? Alignment.centerRight
                : Alignment.centerLeft,
        child: Text(
          context.tr('passwordMismatch'),
          style: TextStyle(color: AppColors.errorRed, fontSize: 12),
        ),
      ),
    );
  }
}
