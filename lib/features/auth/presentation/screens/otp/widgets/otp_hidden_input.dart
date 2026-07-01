import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'otp_field_state.dart';

class OtpHiddenInput extends StatelessWidget {
  const OtpHiddenInput({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Positioned(
      left: -9999,
      top: -9999,
      child: SizedBox(
        width: 1,
        height: 1,
        child: TextField(
          controller: cubit.otpCodeCtrl,
          focusNode: cubit.otpFocusNode,
          keyboardType: TextInputType.number,
          maxLength: 6,
          showCursor: false,
          enableInteractiveSelection: false,
          stylusHandwritingEnabled: false,
          selectionControls: EmptyTextSelectionControls(),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration:
              const InputDecoration(border: InputBorder.none, counterText: ''),
          style: const TextStyle(color: Colors.transparent, fontSize: 1),
          cursorColor: Colors.transparent,
          onChanged: (val) {
            if (cubit.otpFieldState == OtpFieldState.error) {
              cubit.setOtpFieldState(OtpFieldState.idle);
            }
          },
        ),
      ),
    );
  }
}
