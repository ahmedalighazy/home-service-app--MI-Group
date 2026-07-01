import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';

class VerifyResetCodeHiddenInput extends StatelessWidget {
  final int length;

  const VerifyResetCodeHiddenInput({super.key, this.length = 4});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

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
        ),
      ),
    );
  }
}
