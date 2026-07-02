import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/cubit/register/register_cubit.dart';
import 'package:home_service_app/features/auth/cubit/register/register_state.dart';
import 'otp_btn_data.dart';
import 'otp_confirm_button.dart';

class OtpConfirmSection extends StatelessWidget {
  final String email;

  const OtpConfirmSection({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final btnData = context.select<RegisterCubit, OtpBtnData>((c) {
      final s = c.state;
      final isError = s is OtpVerifyFailure;
      return OtpBtnData(
        isLoading: s is OtpVerifyLoading,
        isSuccess: s is OtpVerifySuccess,
        isError: isError,
      );
    });
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: cubit.otpCodeCtrl,
      builder: (context, value, _) {
        final digitsLen = value.text.length;
        return OtpConfirmButton(
          label: context.tr('confirm'),
          isLoading: btnData.isLoading,
          isSuccess: btnData.isSuccess,
          isEnabled: digitsLen == 6 && !btnData.isError,
          onPressed: digitsLen == 6
              ? () {
                  cubit.otpFocusNode.unfocus();
                  cubit.verifyOtp(phoneNumber: email, otp: value.text);
                }
              : () {},
        );
      },
    );
  }
}
