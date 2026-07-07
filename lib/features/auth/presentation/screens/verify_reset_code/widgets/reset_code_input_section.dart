import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_state.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_input_row.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';
import 'verify_reset_code_scaffold.dart';

class ResetCodeInputSection extends StatelessWidget {
  final Animation<double> shakeAnim;

  const ResetCodeInputSection({super.key, required this.shakeAnim});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    final fieldState = context.select<ForgotPasswordCubit, OtpFieldState>(
      (c) => c.state is ResetCodeVerifySuccess
          ? OtpFieldState.success
          : c.state is ResetCodeVerifyFailure
              ? OtpFieldState.error
              : OtpFieldState.idle,
    );
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: cubit.resetCodeCtrl,
      builder: (context, value, _) {
        final digits = value.text;
        return GestureDetector(
          onTap: () => cubit.resetFocusNode.requestFocus(),
          child: AnimatedBuilder(
            animation: shakeAnim,
            builder: (context, _) => OtpInputRow(
              digits: digits,
              length: VerifyResetCodeScaffold.length,
              fieldState: fieldState,
              shakeAnimation: shakeAnim,
              onTap: () => cubit.resetFocusNode.requestFocus(),
            ),
          ),
        );
      },
    );
  }
}
