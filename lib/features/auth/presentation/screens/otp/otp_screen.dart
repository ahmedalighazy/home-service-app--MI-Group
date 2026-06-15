import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_confirm_button.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_input_row.dart';
import 'logic/otp_logic.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with SingleTickerProviderStateMixin {
  static const int _length = 6;
  late OtpScreenLogic _logic;

  @override
  void initState() {
    super.initState();
    getIt<AuthCubit>().resetState();
    _logic = OtpScreenLogic(
      phoneNumber: widget.phoneNumber,
      vsync: this,
      onStateChanged: () {
        if (mounted) setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  String get _digits => _logic.ctrl.text;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listener: _logic.handleState,
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          backgroundColor: AppColors.white,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 120.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AuthBackButton(
                              onTap: () {
                                if (GoRouter.of(context).canPop()) {
                                  GoRouter.of(context).pop();
                                } else {
                                  GoRouter.of(context).go(AppRouter.signUp);
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 40.h),
                          Text(
                            context.tr('confirmCode'),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.dark, fontSize: 22.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            context.tr('enterVerificationCode'),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.secondaryText, fontSize: 13.sp, height: 1.5),
                          ),
                          SizedBox(height: 6.h),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              widget.phoneNumber,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.greenPrimary, fontSize: 14.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 48.h),
                          GestureDetector(
                            onTap: () => _logic.focusNode.requestFocus(),
                            child: OtpInputRow(
                              digits: _digits,
                              length: _length,
                              fieldState: _logic.fieldState,
                              shakeAnimation: _logic.shakeAnim,
                              onTap: () => _logic.focusNode.requestFocus(),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: !_logic.canResend
                                ? Text(
                                    '0:${_logic.secondsLeft.toString().padLeft(2, '0')}',
                                    key: const ValueKey('timer'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: AppColors.gray, fontSize: 14.sp),
                                  )
                                : const SizedBox.shrink(key: ValueKey('empty')),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: _logic.canResend ? () => _logic.onResend(context) : null,
                                child: Text(
                                  context.tr('resendCodeLink'),
                                  style: TextStyle(
                                    color: _logic.canResend ? AppColors.greenPrimary : AppColors.placeholder,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    decoration: _logic.canResend ? TextDecoration.underline : TextDecoration.none,
                                    decorationColor: AppColors.greenPrimary,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  ' ${context.tr('resendCodePrompt')}',
                                  style: TextStyle(color: AppColors.gray, fontSize: 13.sp),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          if (_logic.fieldState == OtpFieldState.error)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Text(
                                context.tr('otpCodeError'),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.errorRed, fontSize: 12.sp),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24.w,
                    right: 24.w,
                    bottom: 24.h,
                    child: OtpConfirmButton(
                      label: context.tr('confirm'),
                      isLoading: isLoading,
                      isSuccess: _logic.fieldState == OtpFieldState.success,
                      isEnabled: _digits.length == _length && _logic.fieldState != OtpFieldState.error,
                      onPressed: _digits.length == _length ? () => _logic.onConfirm(context) : () {},
                    ),
                  ),
                  Positioned(
                    left: -9999,
                    top: -9999,
                    child: SizedBox(
                      width: 1,
                      height: 1,
                      child: TextField(
                        controller: _logic.ctrl,
                        focusNode: _logic.focusNode,
                        keyboardType: TextInputType.number,
                        maxLength: _length,
                        showCursor: false,
                        enableInteractiveSelection: false,
                        scribbleEnabled: false,
                        stylusHandwritingEnabled: false,
                        selectionControls: EmptyTextSelectionControls(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(border: InputBorder.none, counterText: ''),
                        style: const TextStyle(color: Colors.transparent, fontSize: 1),
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
