import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/cubit/login/login_cubit.dart';
import 'package:home_service_app/features/auth/cubit/login/login_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const PasswordInputField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, bool>(
      selector: (state) => state is LoginFailure,
      builder: (context, hasError) => AuthTextField(
        label: context.tr('passwordLabel'),
        hint: context.tr('passwordPlaceholder'),
        controller: controller,
        prefixIcon: Icons.lock_outline_rounded,
        isPassword: true,
        hasError: hasError,
        errorMessage: context.tr('errorIncorrectPassword'),
        onChanged: onChanged,
      ),
    );
  }
}
