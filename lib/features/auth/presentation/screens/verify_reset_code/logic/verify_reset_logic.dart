// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
// import 'package:home_service_app/features/auth/presentation/cubits/auth_state.dart';
// import '../../../../../../core/routes/app_routes.dart';
// import '../../../../../../core/themes/colors/app_colors.dart';
//
// // تعريف حالات حقل الـ OTP
// enum OtpFieldState { idle, error, success }
//
// class OtpScreenLogic {
//   final String phoneNumber;
//   final TickerProvider vsync;
//   final VoidCallback onStateChanged;
//
//   static const int length = 6;
//   static const int totalSeconds = 59;
//
//   final TextEditingController ctrl = TextEditingController();
//   final FocusNode focusNode = FocusNode();
//
//   OtpFieldState fieldState = OtpFieldState.idle;
//   int secondsLeft = totalSeconds;
//   bool canResend = false;
//   Timer? timer;
//
//   late AnimationController shakeCtrl;
//   late Animation<double> shakeAnim;
//
//   OtpScreenLogic({
//     required this.phoneNumber,
//     required this.vsync,
//     required this.onStateChanged,
//   }) {
//     _init();
//   }
//
//   void _init() {
//     // إعداد حركة الاهتزاز عند حدوث خطأ
//     shakeCtrl = AnimationController(
//       vsync: vsync,
//       duration: const Duration(milliseconds: 600),
//     );
//     shakeAnim = TweenSequence<double>([
//       TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
//       TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
//       TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
//       TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
//       TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
//     ]).animate(CurvedAnimation(parent: shakeCtrl, curve: Curves.easeInOut));
//
//     // تصفير حالة الخطأ عند بدء الكتابة مجدداً
//     ctrl.addListener(() {
//       if (fieldState == OtpFieldState.error) {
//         fieldState = OtpFieldState.idle;
//         onStateChanged();
//       }
//     });
//
//     startTimer();
//
//     // تفعيل الكيبورد تلقائياً عند فتح الشاشة
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       focusNode.requestFocus();
//     });
//   }
//
//   // دالة بدء العداد التنازلي
//   void startTimer() {
//     timer?.cancel();
//     secondsLeft = totalSeconds;
//     canResend = false;
//     onStateChanged();
//
//     timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (secondsLeft > 0) {
//         secondsLeft--;
//         onStateChanged();
//       } else {
//         canResend = true;
//         t.cancel();
//         onStateChanged();
//       }
//     });
//   }
//
//   // تأكيد الرمز وإرساله للسيرفر
//   void onConfirm(BuildContext context) {
//     if (ctrl.text.length < length) return;
//     focusNode.unfocus();
//     context.read<AuthCubit>().verifyOtp(phoneNumber, ctrl.text);
//   }
//
//   // إعادة إرسال الرمز
//   void onResend(BuildContext context) {
//     if (!canResend) return;
//     ctrl.clear();
//     fieldState = OtpFieldState.idle;
//     onStateChanged();
//
//     context.read<AuthCubit>().loginWithPhone(phoneNumber);
//     startTimer();
//     focusNode.requestFocus();
//   }
//
//   // معالجة ردود السيرفر وتوجيه المستخدم
//   void handleState(BuildContext context, AuthState state) {
//     if (state is OtpVerified) {
//       fieldState = OtpFieldState.success;
//       onStateChanged();
//       final router = GoRouter.of(context);
//       Future.delayed(const Duration(milliseconds: 500), () {
//         router.go(AppRouter.completeProfile, extra: phoneNumber);
//       });
//     } else if (state is OtpError || state is AuthError) {
//       fieldState = OtpFieldState.error;
//       onStateChanged();
//       shakeCtrl.forward(from: 0.0);
//       final msg = state is OtpError ? state.message : (state as AuthError).message;
//       _showSnackBar(context, msg, AppColors.errorRed);
//     } else if (state is OtpSent) {
//       _showSnackBar(context, 'تم إعادة إرسال رمز التحقق بنجاح', AppColors.greenPrimary);
//     }
//   }
//
//   void _showSnackBar(BuildContext context, String message, Color color) {
//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: color,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       );
//   }
//
//   void dispose() {
//     timer?.cancel();
//     shakeCtrl.dispose();
//     ctrl.dispose();
//     focusNode.dispose();
//   }
// }