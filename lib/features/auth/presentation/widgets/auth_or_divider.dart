import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';


class AuthOrDivider extends StatelessWidget {
  const AuthOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.borderInputs, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            context.tr('orUsing'),
            style: AppText.ibmCaption11(color: AppColors.gray),
          ),
        ),
        Expanded(child: Divider(color: AppColors.borderInputs, thickness: 1)),
      ],
    );
  }
}
