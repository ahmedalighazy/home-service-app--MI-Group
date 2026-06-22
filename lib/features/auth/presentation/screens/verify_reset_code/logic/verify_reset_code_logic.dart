import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/logic/otp_logic.dart';

import '../../../../../../core/routes/app_routes.dart';
import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/themes/text/app_text.dart';
import '../../../../../../core/di/injection.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class VerifyResetCodeLogic {
  final String email;
  final TickerProvider vsync;
  final VoidCallback onStateChanged;

  static const int length = 4;

  final TextEditingController ctrl = TextEditingController();
  final FocusNode focusNode = FocusNode();

  OtpFieldState fieldState = OtpFieldState.idle;

  late AnimationController shakeCtrl;
  late Animation<double> shakeAnim;

  VerifyResetCodeLogic({
    required this.email,
    required this.vsync,
    required this.onStateChanged,
  }) {
    _init();
  }

  void _init() {
    shakeCtrl = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );
    shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: shakeCtrl, curve: Curves.easeInOut));

    ctrl.addListener(() {
      final raw = ctrl.text.replaceAll(RegExp(r'\D'), '');
      final capped = raw.length > length ? raw.substring(0, length) : raw;
      if (ctrl.text != capped) {
        ctrl.value = ctrl.value.copyWith(
          text: capped,
          selection: TextSelection.collapsed(offset: capped.length),
        );
        return;
      }
      if (fieldState == OtpFieldState.error) {
        fieldState = OtpFieldState.idle;
        onStateChanged();
      } else {
        onStateChanged();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  String get digits => ctrl.text;

  void onVerify(BuildContext context) {
    if (digits.length < length) return;
    focusNode.unfocus();
    getIt<AuthCubit>().verifyResetCode(email, digits);
  }

  void onResend(BuildContext context) {
    ctrl.clear();
    fieldState = OtpFieldState.idle;
    onStateChanged();
    getIt<AuthCubit>().sendResetCode(email);
    focusNode.requestFocus();
  }

  void handleState(BuildContext context, AuthState state) {
    if (state is AuthSuccessState && state.action == 'reset_code_verified') {
      fieldState = OtpFieldState.success;
      onStateChanged();
      final router = GoRouter.of(context);
      Future.delayed(const Duration(milliseconds: 500), () {
        router.push(
          AppRouter.setNewPassword,
          extra: <String, dynamic>{'email': email, 'code': digits},
        );
      });
    } else if (state is ResetCodeError || state is AuthError) {
      fieldState = OtpFieldState.error;
      onStateChanged();
      shakeCtrl.forward(from: 0.0);
      final message = state is ResetCodeError ? state.message : (state as AuthError).message;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: AppText.ibmDescription14(color: AppColors.white),
            ),
            backgroundColor: AppColors.errorRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    } else if (state is ResetCodeSentState) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              LocalizationService.instance.translate('resendCodeSuccess'),
              style: AppText.ibmDescription14(color: AppColors.white),
            ),
            backgroundColor: AppColors.greenPrimary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    }
  }

  void dispose() {
    shakeCtrl.dispose();
    ctrl.dispose();
    focusNode.dispose();
  }
}
