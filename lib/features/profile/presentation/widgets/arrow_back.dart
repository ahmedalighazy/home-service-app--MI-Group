import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

import '../../../../core/utils/l10n/localization_extension.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      // الإزاحة الآن ستكون دقيقة لأن الاتجاه مفروض من الـ builder في main.dart
      offset: Offset(context.isRtl ? -15.w : 15.w, 0),
      child: GestureDetector(
        onTap: onTap ?? () => context.pop(),
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: ShapeDecoration(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColors.borderInputs),
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          child: Icon(
            // في RTL (AR) السهم يشير لليمين (Icons.arrow_forward)
            // في LTR (EN) السهم يشير لليسار (Icons.arrow_back)
            Icons.arrow_back,
            size: 22.sp,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
