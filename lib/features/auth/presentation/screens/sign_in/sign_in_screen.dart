import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubits/auth_cubit.dart';
import '../../widgets/sign_up_app_bar.dart';
import 'widgets/sign_in_body.dart';
import 'widgets/sign_in_bloc_listener.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool rememberMe = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().resetState();
  }

  void _onLogin() {
    final cubit = context.read<AuthCubit>();
    if (cubit.emailCtrl.text.trim().isEmpty || cubit.passwordCtrl.text.isEmpty) {
      setState(() => hasError = true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.tr('errorFieldRequired')),
            backgroundColor: AppColors.errorRed,
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }
    setState(() => hasError = false);
    cubit.login(
      identifier: cubit.emailCtrl.text.trim(),
      password: cubit.passwordCtrl.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: SignUpAppBar(
            showBackButton: true,
            onPressed: () => GoRouter.of(context).go(AppRouter.signUp),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: SignInBody(
                    emailController: cubit.emailCtrl,
                    passwordController: cubit.passwordCtrl,
                    rememberMe: rememberMe,
                    hasError: hasError,
                    isLoading: isLoading,
                    onLogin: _onLogin,
                    onFieldChanged: (_) {
                      if (hasError) setState(() => hasError = false);
                    },
                    onRememberChanged: (val) => setState(() => rememberMe = val ?? false),
                    onForgotPassword: () => context.push(AppRouter.forgetPassword),
                    onGoogleSignIn: () => cubit.signInWithGoogle(),
                    onAppleSignIn: () => cubit.signInWithApple(),
                    onSignUp: () => context.go(AppRouter.signUp),
                  ),
                ),
                // Place listener at the bottom / stack to run side effects
                const SignInBlocListener(),
              ],
            ),
          ),
        );
      },
    );
  }
}
