import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/screens/check_your_email/widgets/check_your_email_widgets.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final String code;

  const VerificationScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isButtonEnabled = false;

  Timer? _timer;
  int _secondsRemaining = 59;
  bool _isTimerActive = true;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().resetState();

    for (var controller in _controllers) {
      controller.addListener(_checkCompletion);
    }

    if (widget.code.isNotEmpty && widget.code.length == 6) {
      for (int i = 0; i < 6; i++) {
        _controllers[i].text = widget.code[i];
      }
    }

    _startTimer();
  }

  // ── Timer ──────────────────────────────────────────────────────────────────

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 59;
      _isTimerActive = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isTimerActive = false;
        });
        _timer?.cancel();
      }
    });
  }

  void _checkCompletion() {
    final completed =
        _controllers.every((controller) => controller.text.isNotEmpty);
    if (completed != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = completed;
      });
    }
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  void _handleOtpChange(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _resendCode() {
    if (_isTimerActive) return;
    context.read<AuthCubit>().sendResetCode(widget.email);
    _startTimer();
  }

  void _onConfirm() {
    if (!_isButtonEnabled) return;
    context.read<AuthCubit>().verifyResetCode(widget.email, _otpCode);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetCodeVerifiedState) {
          GoRouter.of(context).push(
            AppRouter.setNewPassword,
            extra: <String, dynamic>{'email': widget.email, 'code': _otpCode},
          );
        } else if (state is ResetCodeError) {
          _showSnackBar(state.message, const Color(0xFFE05C5C));
        } else if (state is AuthErrorState) {
          _showSnackBar(state.message, const Color(0xFFE05C5C));
        } else if (state is ResetCodeSentState) {
          _showSnackBar(
            LocalizationService.instance.translate('resendCodeSuccess'),
            const Color(0xFF1B85A6),
          );
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoadingState;

          return Scaffold(
            backgroundColor: Colors.white,
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
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom -
                        kToolbarHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          verticalSpace(24.h),
                          CheckEmailHeader(email: widget.email),
                          verticalSpace(16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                                  child: OtpCircleField(
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    onChanged: (value) =>
                                        _handleOtpChange(value, index),
                                  ),
                                ),
                              );
                            }),
                          ),
                          verticalSpace(32.h),
                          CheckEmailResendRow(
                            onResend: _resendCode,
                          ),
                          verticalSpace(36.h),
                          isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.greenPrimary,
                                  ),
                                )
                              : AuthPrimaryButton(
                                  label: context.tr('confirm'),
                                  isEnabled: _isButtonEnabled,
                                  onPressed: _onConfirm,
                                ),
                          verticalSpace(24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
