import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';

class VerifyResetCodeHiddenInput extends StatelessWidget {
  final AuthCubit cubit;
  final int length;

  const VerifyResetCodeHiddenInput({
    super.key,
    required this.cubit,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -9999, top: -9999,
      child: SizedBox(
        width: 1, height: 1,
        child: TextField(
          controller: cubit.resetCodeCtrl,
          focusNode: cubit.controllers.resetFocusNode,
          keyboardType: TextInputType.number,
          maxLength: length,
          showCursor: false,
          enableInteractiveSelection: false,
          stylusHandwritingEnabled: false,
          selectionControls: EmptyTextSelectionControls(),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(border: InputBorder.none, counterText: ''),
          style: const TextStyle(color: Colors.transparent, fontSize: 1),
          cursorColor: Colors.transparent,
          onChanged: (val) {
            final raw = val.replaceAll(RegExp(r'\D'), '');
            final capped = raw.length > length ? raw.substring(0, length) : raw;
            if (val != capped) {
              cubit.resetCodeCtrl.value = cubit.resetCodeCtrl.value.copyWith(
                text: capped,
                selection: TextSelection.collapsed(offset: capped.length),
              );
              return;
            }
            if (cubit.uiState.resetFieldState == OtpFieldState.error) {
              cubit.setResetFieldState(OtpFieldState.idle);
            }
          },
        ),
      ),
    );
  }
}
