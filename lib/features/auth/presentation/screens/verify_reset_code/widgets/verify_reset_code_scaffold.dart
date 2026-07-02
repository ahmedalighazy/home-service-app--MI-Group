import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';
import 'verify_reset_code_widgets.dart';
import 'verify_reset_code_hidden_input.dart';
import 'reset_code_input_section.dart';
import 'reset_code_error_text.dart';
import 'reset_code_timer_section.dart';
import 'reset_code_confirm_button.dart';

class VerifyResetCodeScaffold extends StatefulWidget {
  final String email;
  static const int length = 6;

  const VerifyResetCodeScaffold({super.key, required this.email});

  @override
  State<VerifyResetCodeScaffold> createState() =>
      _VerifyResetCodeScaffoldState();
}

class _VerifyResetCodeScaffoldState extends State<VerifyResetCodeScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          current is ResetCodeVerifyFailure &&
          previous is! ResetCodeVerifyFailure,
      listener: (context, state) {
        _shakeCtrl.forward(from: 0.0);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.all(8.w),
            child: CustomBackArrowButton(),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 16.h),
                            VerifyResetCodeHeader(email: widget.email),
                            SizedBox(height: 36.h),
                            ResetCodeInputSection(shakeAnim: _shakeAnim),
                            SizedBox(height: 20.h),
                            const ResetCodeErrorText(),
                            SizedBox(height: 12.h),
                            ResetCodeTimerSection(email: widget.email),
                            SizedBox(height: 32.h),
                          ],
                        ),
                      ),
                    ),
                    ResetCodeConfirmButton(email: widget.email),
                  ],
                ),
              ),
              VerifyResetCodeHiddenInput(
                length: VerifyResetCodeScaffold.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
