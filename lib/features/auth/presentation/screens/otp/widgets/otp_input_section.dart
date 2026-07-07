import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/cubit/register/register_cubit.dart';
import 'package:home_service_app/features/auth/cubit/register/register_state.dart';
import 'otp_input_row.dart';
import 'otp_field_state.dart';

class OtpInputSection extends StatelessWidget {
  final Animation<double> shakeAnim;

  const OtpInputSection({super.key, required this.shakeAnim});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final fieldState = context.select<RegisterCubit, OtpFieldState>(
      (c) => c.state is OtpVerifySuccess
          ? OtpFieldState.success
          : c.state is OtpVerifyFailure
              ? OtpFieldState.error
              : OtpFieldState.idle,
    );
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: cubit.otpCodeCtrl,
      builder: (context, value, _) => GestureDetector(
        onTap: () => cubit.otpFocusNode.requestFocus(),
        child: OtpInputRow(
          digits: value.text,
          length: 6,
          fieldState: fieldState,
          shakeAnimation: shakeAnim,
          onTap: () => cubit.otpFocusNode.requestFocus(),
        ),
      ),
    );
  }
}
