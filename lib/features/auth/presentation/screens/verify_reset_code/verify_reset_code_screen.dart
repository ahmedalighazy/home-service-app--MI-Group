import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';
import '../../../../../core/utils/l10n/localization_service.dart';
import '../../../../../core/routes/app_routes.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_confirm_button.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_input_row.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';
import 'widget/verify_reset_code_widgets.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  final String email;
  const VerifyResetCodeScreen({super.key, required this.email});

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen>
    with SingleTickerProviderStateMixin {
  static const int length = 4;

  final TextEditingController _ctrl = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  OtpFieldState _fieldState = OtpFieldState.idle;

  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().resetState();

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

    _ctrl.addListener(() {
      final raw = _ctrl.text.replaceAll(RegExp(r'\D'), '');
      final capped = raw.length > length ? raw.substring(0, length) : raw;
      if (_ctrl.text != capped) {
        _ctrl.value = _ctrl.value.copyWith(
          text: capped,
          selection: TextSelection.collapsed(offset: capped.length),
        );
        return;
      }
      if (_fieldState == OtpFieldState.error) {
        setState(() {
          _fieldState = OtpFieldState.idle;
        });
      } else {
        setState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onVerify() {
    if (_ctrl.text.length < length) return;
    _focusNode.unfocus();
    context.read<AuthCubit>().verifyResetCode(widget.email, _ctrl.text);
  }

  void _onResend() {
    _ctrl.clear();
    setState(() {
      _fieldState = OtpFieldState.idle;
    });
    context.read<AuthCubit>().sendResetCode(widget.email);
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetCodeVerifiedState) {
          setState(() {
            _fieldState = OtpFieldState.success;
          });
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              context.push(
                AppRouter.setNewPassword,
                extra: <String, dynamic>{
                  'email': widget.email,
                  'code': _ctrl.text,
                },
              );
            }
          });
        } else if (state is ResetCodeError || state is AuthErrorState) {
          setState(() {
            _fieldState = OtpFieldState.error;
          });
          _shakeCtrl.forward(from: 0.0);
          final message = state is ResetCodeError
              ? state.message
              : (state as AuthErrorState).message;
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
      },
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Scaffold(
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
                              OtpInputRow(
                                digits: _ctrl.text,
                                length: length,
                                fieldState: _fieldState,
                                shakeAnimation: _shakeAnim,
                                onTap: () => _focusNode.requestFocus(),
                              ),
                              SizedBox(height: 20.h),
                              if (_fieldState == OtpFieldState.error)
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: Text(
                                    LocalizationService.instance.translate(
                                      'otpCodeError',
                                    ),
                                    textAlign: TextAlign.center,
                                    style: AppText.ibmError12(),
                                  ),
                                ),
                              SizedBox(height: 12.h),
                              VerifyResetCodeResendRow(
                                isLoading: isLoading,
                                onResend: _onResend,
                              ),
                              SizedBox(height: 32.h),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                        child: OtpConfirmButton(
                          label: context.tr('confirm'),
                          isLoading: isLoading,
                          isSuccess: _fieldState == OtpFieldState.success,
                          onPressed: _ctrl.text.length == length
                              ? _onVerify
                              : () {},
                          isEnabled: _ctrl.text.length == length,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: -9999,
                  top: -9999,
                  child: SizedBox(
                    width: 1,
                    height: 1,
                    child: TextField(
                      controller: _ctrl,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      maxLength: length,
                      showCursor: false,
                      enableInteractiveSelection: false,
                      stylusHandwritingEnabled: false,
                      selectionControls: EmptyTextSelectionControls(),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      style: const TextStyle(
                        color: Colors.transparent,
                        fontSize: 1,
                      ),
                      cursorColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
