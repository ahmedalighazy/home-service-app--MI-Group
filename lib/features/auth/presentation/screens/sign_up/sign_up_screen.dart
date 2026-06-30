import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubits/auth_cubit.dart';
import '../../widgets/sign_up_app_bar.dart';
import 'widgets/sign_up_body.dart';
import 'widgets/sign_up_bloc_listener.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                  if (cubit.signUpHasError) {
                    cubit.setSignUpError(false, null);
                  }
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
