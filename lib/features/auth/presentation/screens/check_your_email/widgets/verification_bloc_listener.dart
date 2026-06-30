import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';

class VerificationBlocListener extends StatelessWidget {
  final String email;
  final Widget child;

  const VerificationBlocListener({
    super.key,
    required this.email,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        final cubit = context.read<AuthCubit>();
        if (state is ResetCodeVerifiedState) {
          context.push(
            AppRouter.setNewPassword,
            extra: <String, dynamic>{
              'email': email,
              'code': cubit.emailVerificationOtpCode,
            },
          );
        } else if (state is ResetCodeError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message), backgroundColor: const Color(0xFFE05C5C)));
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message), backgroundColor: const Color(0xFFE05C5C)));
        } else if (state is ResetCodeSentState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(LocalizationService.instance.translate('resendCodeSuccess')),
              backgroundColor: const Color(0xFF1B85A6),
            ));
        }
      },
      child: child,
    );
  }
}
