import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/screens/otp/widgets/otp_field_state.dart';

class VerifyResetCodeHiddenInput extends StatelessWidget {
  final int length;

  const VerifyResetCodeHiddenInput({super.key, this.length = 4});

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
          controller: cubit.resetCodeCtrl,
          focusNode: cubit.resetFocusNode,
          keyboardType: TextInputType.number,
          maxLength: length,
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
            if (cubit.resetFieldState == OtpFieldState.error) {
              cubit.setResetFieldState(OtpFieldState.idle);
            }
          },
        ),
      ),
    );
  }
}
