import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';
import '../../../../../core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_confirm_button.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_input_row.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/logic/otp_logic.dart';
import 'logic/verify_reset_code_logic.dart';
import 'widget/verify_reset_code_widgets.dart';

class VerifyResetCodeScreen extends StatefulWidget {
  final String email;
  const VerifyResetCodeScreen({super.key, required this.email});

  @override
  State<VerifyResetCodeScreen> createState() => _VerifyResetCodeScreenState();
}

class _VerifyResetCodeScreenState extends State<VerifyResetCodeScreen>
    with SingleTickerProviderStateMixin {
  late final VerifyResetCodeLogic _logic;

  @override
  void initState() {
    super.initState();
    getIt<AuthCubit>().resetState();
    _logic = VerifyResetCodeLogic(
      email: widget.email,
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listener: (context, state) => _logic.handleState(context, state),
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
              child: AuthBackButton(
                onTap: () {
                  if (GoRouter.of(context).canPop()) {
                    context.pop();
                  } else {
                    context.go(AppRouter.forgetPassword);
                  }
                },
              ),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 16.h),
                              VerifyResetCodeHeader(email: widget.email),
                              SizedBox(height: 36.h),
                              OtpInputRow(
                                digits: _logic.digits,
                                length: VerifyResetCodeLogic.length,
                                fieldState: _logic.fieldState,
                                shakeAnimation: _logic.shakeAnim,
                                onTap: () =>
                                    _logic.focusNode.requestFocus(),
                              ),
                              SizedBox(height: 20.h),
                              if (_logic.fieldState == OtpFieldState.error)
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 8.h),
                                  child: Text(
                                    LocalizationService.instance
                                        .translate('otpCodeError'),
                                    textAlign: TextAlign.center,
                                    style: AppText.ibmError12(),
                                  ),
                                ),
                              SizedBox(height: 12.h),
                              VerifyResetCodeResendRow(
                                isLoading: isLoading,
                                onResend: () =>
                                    _logic.onResend(context),
                              ),
                              SizedBox(height: 32.h),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            24.w, 0, 24.w, 24.h),
                        child: OtpConfirmButton(
                          label: context.tr('confirm'),
                          isLoading: isLoading,
                          isSuccess:
                              _logic.fieldState == OtpFieldState.success,
                          onPressed: _logic.digits.length ==
                                  VerifyResetCodeLogic.length
                              ? () => _logic.onVerify(context)
                              : () {},
                          isEnabled: _logic.digits.length ==
                              VerifyResetCodeLogic.length,
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
                      controller: _logic.ctrl,
                      focusNode: _logic.focusNode,
                      keyboardType: TextInputType.number,
                      maxLength: VerifyResetCodeLogic.length,
                      showCursor: false,
                      enableInteractiveSelection: false,
                      stylusHandwritingEnabled: false,
                      selectionControls: EmptyTextSelectionControls(),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
