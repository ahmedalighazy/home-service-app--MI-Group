import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubits/auth_cubit.dart';
import '../../states/auth_state.dart';
import '../../widgets/sign_up_app_bar.dart';
import 'logic/sign_in_logic.dart';
import 'widgets/sign_in_body.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SignInLogic {
  @override
  void initState() {
    super.initState();
    // Reset stale auth state so old results don't trigger navigation immediately
    getIt<AuthCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SignUpAppBar(
        showBackButton: true,
        onPressed: () => GoRouter.of(context).go(AppRouter.signUp),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: getIt<AuthCubit>(),
        listener: handleState,
        child: BlocBuilder<AuthCubit, AuthState>(
          bloc: getIt<AuthCubit>(),
          builder: (context, state) {
            return SafeArea(
              child: SignInBody(
                emailController: emailCtrl,
                passwordController: passwordCtrl,
                rememberMe: rememberMe,
                hasError: hasError,
                isLoading: state is AuthLoadingState,
                onLogin: () => onLogin(context),
                onFieldChanged: onFieldChanged,
                onRememberChanged: onRememberMeChanged,
                onForgotPassword: () => onForgotPassword(context),
                onGoogleSignIn: () => onGoogleSignIn(context),
                onAppleSignIn: () => onAppleSignIn(context),
                onSignUp: () => onSignUp(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
