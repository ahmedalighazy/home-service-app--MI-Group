import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'otp_field_state.dart';

class OtpHiddenInput extends StatelessWidget {
  final AuthCubit cubit;

  const OtpHiddenInput({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -9999, top: -9999,
      child: SizedBox(
        width: 1, height: 1,
        child: TextField(
          controller: cubit.otpCodeCtrl,
          focusNode: cubit.controllers.otpFocusNode,
          keyboardType: TextInputType.number,
          maxLength: 6,
          showCursor: false,
          enableInteractiveSelection: false,
          stylusHandwritingEnabled: false,
          selectionControls: EmptyTextSelectionControls(),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(border: InputBorder.none, counterText: ''),
          style: const TextStyle(color: Colors.transparent, fontSize: 1),
          cursorColor: Colors.transparent,
          onChanged: (val) {
            if (cubit.uiState.otpFieldState == OtpFieldState.error) {
              cubit.setOtpFieldState(OtpFieldState.idle);
            }
          },
        ),
      ),
    );
  }
}
