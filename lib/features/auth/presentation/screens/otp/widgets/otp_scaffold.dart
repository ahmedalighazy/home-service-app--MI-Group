import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/cubit/register/register_cubit.dart';
import 'package:home_service_app/features/auth/cubit/register/register_state.dart';
import 'otp_header_section.dart';
import 'otp_input_section.dart';
import 'otp_confirm_section.dart';
import 'otp_timer_section.dart';
import 'otp_hidden_input.dart';

class OtpScaffold extends StatefulWidget {
  final String email;

  const OtpScaffold({super.key, required this.email});

  @override
  State<OtpScaffold> createState() => _OtpScaffoldState();
}

class _OtpScaffoldState extends State<OtpScaffold>
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
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          current is OtpVerifyFailure && previous is! OtpVerifyFailure,
      listener: (context, state) {
        _shakeCtrl.forward(from: 0.0);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 120.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomBackArrowButton(),
                      ),
                      SizedBox(height: 40.h),
                      OtpHeaderSection(email: widget.email),
                      SizedBox(height: 48.h),
                      OtpInputSection(shakeAnim: _shakeAnim),
                      SizedBox(height: 20.h),
                      OtpTimerSection(email: widget.email),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 24.w,
                right: 24.w,
                bottom: 24.h,
                child: OtpConfirmSection(email: widget.email),
              ),
              OtpHiddenInput(email: widget.email),
            ],
          ),
        ),
      ),
    );
  }
}
