import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_up_app_bar.dart';
import 'sign_up_body.dart';
import 'sign_up_bloc_listener.dart';

class SignUpScaffold extends StatelessWidget {
  const SignUpScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    final isLoading = cubit.state is AuthLoadingState;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const SignUpAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SignUpBody(
                emailController: cubit.signUpEmailCtrl,
                hasError: cubit.signUpHasError,
                errorMessage: cubit.signUpErrorMessage,
                isLoading: isLoading,
                onSendCode: () => cubit.sendSignUpSmsCode(),
                onGoogleSignUp: () => cubit.signUpWithGoogle(),
                onAppleSignUp: () => cubit.signUpWithApple(),
                onGuestMode: () => cubit.loginAsGuest(),
                onSignIn: () => context.go(AppRouter.signIn),
                onEmailChanged: (_) {
                  if (cubit.signUpHasError) cubit.setSignUpError(false, null);
                },
              ),
            ),
            const SignUpBlocListener(),
          ],
        ),
      ),
    );
  }
}
