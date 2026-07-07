import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/auth/cubit/login/login_cubit.dart';
import 'package:home_service_app/features/auth/cubit/login/login_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        return AuthPrimaryButton(
          label: context.tr('login'),
          // isLoading: isLoading,
          isEnabled: !isLoading,
          onPressed: onPressed,
        );
      },
    );
  }
}
