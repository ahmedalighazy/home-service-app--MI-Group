import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_up_app_bar.dart';
import 'sign_in_body.dart';
import 'sign_in_bloc_listener.dart';

class SignInScaffold extends StatelessWidget {
  const SignInScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    final isLoading = cubit.state is AuthLoadingState;

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
                rememberMe: cubit.rememberMe,
                hasError: cubit.hasSignInError,
                isLoading: isLoading,
                onLogin: () => cubit.login(
                  identifier: cubit.emailCtrl.text,
                  password: cubit.passwordCtrl.text,
                ),
                onFieldChanged: (_) {
                  if (cubit.hasSignInError) cubit.setSignInError(false);
                },
                onRememberChanged: (val) => cubit.toggleRememberMe(val ?? false),
                onForgotPassword: () => context.push(AppRouter.forgetPassword),
                onGoogleSignIn: () => cubit.signInWithGoogle(),
                onAppleSignIn: () => cubit.signInWithApple(),
                onSignUp: () => context.go(AppRouter.signUp),
              ),
            ),
            const SignInBlocListener(),
          ],
        ),
      ),
    );
  }
}
