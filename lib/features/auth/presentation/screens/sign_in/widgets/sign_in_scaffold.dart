import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/cubit/login/login_cubit.dart';
import 'package:home_service_app/features/auth/listeners/login_bloc_listener.dart';
import 'package:home_service_app/features/auth/presentation/widgets/sign_up_app_bar.dart';
import 'sign_in_body.dart';

class SignInScaffold extends StatefulWidget {
  const SignInScaffold({super.key});

  @override
  State<SignInScaffold> createState() => _SignInScaffoldState();
}

class _SignInScaffoldState extends State<SignInScaffold> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SignUpAppBar(
        showBackButton: true,
        onPressed: () => GoRouter.of(context).go(AppRouter.signUp),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SignInBody(
              emailController: cubit.emailCtrl,
              passwordController: cubit.passwordCtrl,
              rememberMe: _rememberMe,
              onLogin: () =>
                  cubit.login(cubit.emailCtrl.text, cubit.passwordCtrl.text),
              onRememberChanged: (val) =>
                  setState(() => _rememberMe = val ?? false),
              onForgotPassword: () => context.push(AppRouter.forgetPassword),
              onGoogleSignIn: () {},
              onAppleSignIn: () {},
              onSignUp: () => context.go(AppRouter.signUp),
            ),

            const LoginBlocListener(),
          ],
        ),
      ),
    );
  }
}
