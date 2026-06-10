// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/themes/colors/app_colors.dart';
// import '../../../../core/themes/text/app_text.dart';
// import '../../../../core/utils/l10n/app_strings.dart';
// import '../../../../core/utils/helpers/spacing.dart';

// class EmptyBookingsState extends StatelessWidget {
//   const EmptyBookingsState({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _EmptyIllustration(),
//             verticalSpace(24),
//             Text(
//               'لا توجد حجوزات قادمة',
//               style: AppText.ibmHeading16(),
//               textAlign: TextAlign.center,
//             ),
//             verticalSpace(8),
//             Text(
//               'احجز خدمتك الآن وحدد الموعد المناسب لك بكل سهولة.',
//               style: AppText.ibmDescription14(),
//               textAlign: TextAlign.center,
//             ),
//             verticalSpace(24),
//             _BookNowButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _EmptyIllustration extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 170.w,
//       height: 150.h,
//       decoration: BoxDecoration(
//         color: AppColors.light,
//         shape: BoxShape.circle,
//       ),
//       child: Center(
//         child: Icon(Icons.calendar_today_outlined, size: 60.r, color: AppColors.primary),
//       ),
//     );
//   }
// }

// class _BookNowButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.black,
//           padding: EdgeInsets.symmetric(vertical: 14.h),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44.r)),
//         ),
//         child: Text(AppStrings.bookNow, style: AppText.ibmButton16(color: AppColors.white)),
//       ),
//     );
//   }
// }
