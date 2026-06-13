// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/themes/colors/app_colors.dart';
// import '../../../../core/themes/text/app_text.dart';
//
// class CustomTextField extends StatefulWidget {
//   final String hintText;
//   final String labelText;
//   final bool isPassword;
//   final TextEditingController? controller;
//   final TextInputType keyboardType;
//
//   const CustomTextField({
//     super.key,
//     required this.hintText,
//     required this.labelText,
//     this.isPassword = false,
//     this.controller,
//     this.keyboardType = TextInputType.text,
//   });
//
//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField> {
//   bool _obscureText = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _obscureText = widget.isPassword;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.labelText,
//           style: AppText.ibmFieldLabel14(color: AppColors.headingText),
//         ),
//         SizedBox(height: 8.h),
//         TextFormField(
//           controller: widget.controller,
//           obscureText: _obscureText,
//           keyboardType: widget.keyboardType,
//           style: AppText.ibmFieldLabel14(color: AppColors.primaryText),
//           decoration: InputDecoration(
//             hintText: widget.hintText,
//             hintStyle: AppText.ibmPlaceholder14(color: AppColors.placeholder),
//             filled: true,
//             fillColor: AppColors.bgPrimary,
//             contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: AppColors.borderInputs),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: AppColors.borderInputs),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: const BorderSide(color: AppColors.greenPrimary, width: 1.5),
//             ),
//             suffixIcon: widget.isPassword
//                 ? IconButton(
//                     icon: Icon(
//                       _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//                       color: AppColors.secondaryText,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscureText = !_obscureText;
//                       });
//                     },
//                   )
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }
