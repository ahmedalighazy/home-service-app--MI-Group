import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/navigation_extensions.dart';
import '../../../../core/themes/colors/app_colors.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-9.w, 0), // حركه 8 ناحية اليمين
      child: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Container(
          margin: EdgeInsets.all(4.r),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: AppColors.borderInputs),
              borderRadius: BorderRadius.circular(44),
            ),
          ),
          child: Icon(Icons.arrow_back, size: 25.sp, color: AppColors.black),
        ),
      ),
    );
  }
}
