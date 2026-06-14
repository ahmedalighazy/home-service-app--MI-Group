// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../../../core/themes/colors/app_colors.dart';
// import '../../../../../../core/utils/l10n/app_strings.dart';
// import 'package:home_service_app/features/auth/presentation/widgets/auth_back_button.dart';
// import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_confirm_button.dart';
// import '../../otp/logic/otp_logic.dart';
//
//
// class OtpHeader extends StatelessWidget {
//   final String phoneNumber;
//   const OtpHeader({super.key, required this.phoneNumber});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         SizedBox(height: 16.h),
//         Align(
//           alignment: Alignment.centerRight,
//           child: AuthBackButton(onTap: () => context.pop()),
//         ),
//         SizedBox(height: 40.h),
//         Text(
//           AppStrings.confirmCode,
//           textAlign: TextAlign.center,
//           style: GoogleFonts.ibmPlexSansArabic(
//             color: AppColors.dark,
//             fontSize: 22.sp,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 10.h),
//         Text(
//           AppStrings.enterVerificationCode,
//           textAlign: TextAlign.center,
//           style: GoogleFonts.ibmPlexSansArabic(
//             color: AppColors.secondaryText,
//             fontSize: 13.sp,
//             height: 1.5,
//           ),
//         ),
//         SizedBox(height: 4.h),
//         Directionality(
//           textDirection: TextDirection.ltr,
//           child: Text(
//             phoneNumber,
//             textAlign: TextAlign.center,
//             style: GoogleFonts.ibmPlexSansArabic(
//               color: AppColors.greenPrimary,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
// class OtpTimerAndResend extends StatelessWidget {
//   final int secondsLeft;
//   final bool canResend;
//   final VoidCallback onResendPressed;
//
//   const OtpTimerAndResend({
//     super.key,
//     required this.secondsLeft,
//     required this.canResend,
//     required this.onResendPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           child: !canResend
//               ? Text(
//             '0:${secondsLeft.toString().padLeft(2, '0')}',
//             key: const ValueKey('timer'),
//             textAlign: TextAlign.center,
//             style: GoogleFonts.ibmPlexSansArabic(
//               color: AppColors.gray,
//               fontSize: 14.sp,
//             ),
//           )
//               : const SizedBox.shrink(key: ValueKey('empty')),
//         ),
//         SizedBox(height: 10.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: onResendPressed,
//               child: Text(
//                 AppStrings.resendCodeLink,
//                 style: GoogleFonts.ibmPlexSansArabic(
//                   color: canResend ? AppColors.greenPrimary : AppColors.placeholder,
//                   fontSize: 13.sp,
//                   fontWeight: FontWeight.bold,
//                   decoration: canResend ? TextDecoration.underline : TextDecoration.none,
//                   decorationColor: AppColors.greenPrimary,
//                 ),
//               ),
//             ),
//             Text(
//               ' ${AppStrings.resendCodePrompt}',
//               style: GoogleFonts.ibmPlexSansArabic(
//                 color: AppColors.gray,
//                 fontSize: 13.sp,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
//
// class OtpConfirmSection extends StatelessWidget {
//   final OtpFieldState fieldState;
//   final String digits;
//   final int length;
//   final bool isLoading;
//   final VoidCallback onConfirmPressed;
//
//   const OtpConfirmSection({
//     super.key,
//     required this.fieldState,
//     required this.digits,
//     required this.length,
//     required this.isLoading,
//     required this.onConfirmPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (fieldState == OtpFieldState.error)
//           Padding(
//             padding: EdgeInsets.only(bottom: 12.h),
//             child: Text(
//               'الرمز غير صحيح، يرجى المحاولة مرة أخرى',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.ibmPlexSansArabic(
//                 color: AppColors.errorRed,
//                 fontSize: 12.sp,
//               ),
//             ),
//           ),
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           child: digits.length == length
//               ? OtpConfirmButton(
//             key: const ValueKey('btn'),
//             label: AppStrings.confirm,
//             isLoading: isLoading,
//             isSuccess: fieldState == OtpFieldState.success,
//             isEnabled: fieldState != OtpFieldState.error,
//             onPressed: onConfirmPressed,
//           )
//               : SizedBox(
//             height: 54.h,
//             key: const ValueKey('empty'),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
// class OtpHiddenInput extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final int maxLength;
//
//   const OtpHiddenInput({
//     super.key,
//     required this.controller,
//     required this.focusNode,
//     required this.maxLength,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 1,
//       height: 1,
//       child: Opacity(
//         opacity: 0,
//         child: TextField(
//           controller: controller,
//           focusNode: focusNode,
//           keyboardType: TextInputType.number,
//           maxLength: maxLength,
//           showCursor: false,
//           enableInteractiveSelection: false,
//           inputFormatters: [
//             FilteringTextInputFormatter.digitsOnly,
//           ],
//           decoration: const InputDecoration(
//             border: InputBorder.none,
//             counterText: '',
//           ),
//           style: const TextStyle(
//             color: Colors.transparent,
//             fontSize: 0,
//           ),
//           cursorColor: Colors.transparent,
//         ),
//       ),
//     );
//   }
// }