import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';

class VerificationBlocListener extends StatelessWidget {
  final String email;
  final String code;
  final Widget child;

  const VerificationBlocListener({
    super.key,
    required this.email,
    required this.code,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.emailVerificationTimer == null) {
        cubit.initEmailVerification();
        if (code.isNotEmpty && code.length == 6) {
          for (int i = 0; i < 6; i++) {
            cubit.emailVerificationControllers[i].text = code[i];
          }
          cubit.checkEmailVerificationCompletion();
        }
      }
    });

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetCodeVerifySuccess) {
          context.push(
            AppRouter.setNewPassword,
            extra: <String, dynamic>{
              'email': email,
              'code': cubit.emailVerificationOtpCode,
            },
          );
        } else if (state is ResetCodeVerifyFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message), backgroundColor: const Color(0xFFE05C5C)));
        } else if (state is ResetCodeSendSuccess) {
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
