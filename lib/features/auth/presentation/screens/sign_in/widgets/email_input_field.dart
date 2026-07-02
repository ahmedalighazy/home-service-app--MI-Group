import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

import '../../../../cubit/login/login_cubit.dart';
import '../../../../cubit/login/login_state.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const EmailInputField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, bool>(
      selector: (state) => state is LoginFailure,
      builder: (context, hasError) => AuthTextField(
        label: context.tr('emailLabel'),
        hint: context.tr('emailPlaceholder'),
        controller: controller,
        hasError: hasError,

        prefixIcon: Icons.mail_outline_rounded,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
      ),
    );
  }
}
