import 'dart:developer';
import 'dart:ui' as ui;
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/language/language_cubit.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      bloc: getIt<LanguageCubit>(),
      builder: (context, state) {
        final isArabic = state.isArabic;
        log(isArabic.toString());
        return Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: AnimatedToggleSwitch<bool>.dual(
              current: isArabic,
              first: false, // English
              second: true, // Arabic
              onChanged: (value) async {
                final cubit = getIt<LanguageCubit>();
                if (value) {
                  await cubit.setArabic();
                  if (context.mounted) {
                    await context.setLocale(const Locale('ar'));
                  }
                } else {
                  await cubit.setEnglish();
                  if (context.mounted) {
                    await context.setLocale(const Locale('en'));
                  }
                }
              },
              style: ToggleStyle(
                backgroundColor: const Color(0xFFEEEEEE),
                borderColor: const Color(0xFFDDDDDD),
                indicatorColor: AppColors.greenPrimary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              styleBuilder: (value) =>
                  const ToggleStyle(indicatorColor: AppColors.greenPrimary),

              iconBuilder: (value) => Text(
                value ? 'ع' : 'EN',
                textDirection: ui.TextDirection.ltr,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              textBuilder: (value) => Center(
                child: Text(
                  value
                      ? 'EN'
                      : 'AR', // Fixed labels to show the selected language
                  textDirection: ui.TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF555555),
                  ),
                ),
              ),
              height: 32.h,
              spacing: 4.w,
              animationDuration: const Duration(milliseconds: 300),
              animationCurve: Curves.easeInOutCubic,
            ),
          ),
        );
      },
    );
  }
}
