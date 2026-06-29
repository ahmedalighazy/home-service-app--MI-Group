// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/di/injection.dart';
// import '../../../../core/language/language_cubit.dart';
// import '../../../../core/themes/colors/app_colors.dart';

// class AuthBackButton extends StatelessWidget {
//   final VoidCallback onTap;

//   const AuthBackButton({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final isArabic = getIt<LanguageCubit>().isArabic;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 40.w,
//         height: 40.w,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: AppColors.borderInputs),
//           color: AppColors.white,
//         ),
//         child: Icon(
//           isArabic ? Icons.arrow_forward : Icons.arrow_back,
//           size: 15.sp,
//           color: AppColors.primaryText,
//         ),
//       ),
//     );
//   }
// }
