import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/cubit/login/login_cubit.dart';
import 'package:home_service_app/features/auth/cubit/register/register_cubit.dart';
import 'package:home_service_app/features/auth/listeners/login_bloc_listener.dart';
import 'package:home_service_app/features/auth/listeners/register_bloc_listener.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_up_app_bar.dart';
import 'sign_up_body.dart';

class SignUpScaffold extends StatelessWidget {
  const SignUpScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();
    final loginCubit = context.read<LoginCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const SignUpAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SignUpBody(
                emailController: registerCubit.signUpEmailCtrl,
                onSendCode: () => registerCubit.sendSignUpSmsCode(),
                onGoogleSignUp: () => loginCubit.signInWithGoogle(),
                onAppleSignUp: () => loginCubit.signInWithApple(),
                onGuestMode: () => loginCubit.loginAsGuest(),
                onSignIn: () => context.go(AppRouter.signIn),
              ),
            ),
            const RegisterBlocListener(),
            const LoginBlocListener(),
          ],
        ),
      ),
    );
  }
}
