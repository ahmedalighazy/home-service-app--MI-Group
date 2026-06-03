// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/themes/colors/app_colors.dart';
// import '../../../../core/themes/text/app_text.dart';
//
// class CustomAuthButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final bool isLoading;
//
//   const CustomAuthButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.isLoading = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 56.h,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.greenPrimary,
//           disabledBackgroundColor: AppColors.greenPrimary.withValues(alpha: 0.5),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           elevation: 0,
//         ),
//         child: isLoading
//             ? SizedBox(
//                 height: 24.h,
//                 width: 24.h,
//                 child: const CircularProgressIndicator(
//                   color: AppColors.white,
//                   strokeWidth: 2,
//                 ),
//               )
//             : Text(
//                 text,
//                 style: AppText.ibmButton16(color: AppColors.white),
//               ),
//       ),
//     );
//   }
// }
