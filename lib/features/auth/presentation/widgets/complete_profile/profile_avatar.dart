import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imagePath;
  final VoidCallback? onTap;

  const ProfileAvatar({
    super.key,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.light,
                border: Border.all(
                  color: AppColors.borderInputs,
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: imagePath != null
                    ? Image.file(
                        File(imagePath!),
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 100.w,
                      )
                    : Icon(
                        Icons.person_outline_rounded,
                        size: 48.sp,
                        color: AppColors.gray,
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.light,
                  border: Border.all(color: AppColors.borderInputs),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.edit_outlined,
                  size: 14.sp,
                  color: AppColors.greenPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
