import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/auth_state.dart';
import 'sign_in_logic.dart';
import 'widgets/sign_in_app_bar.dart';
import 'widgets/sign_in_body.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SignInLogic {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const SignInAppBar(),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: handleState,
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: SignInBody(
                  emailController: emailCtrl,
                  passwordController: passwordCtrl,
                  rememberMe: rememberMe,
                  hasError: hasError,
                  isLoading: state is AuthLoading,
                  onLogin: () => onLogin(context),
                  onFieldChanged: onFieldChanged,
                  onRememberChanged: onRememberMeChanged,
                  onForgotPassword: () => onForgotPassword(context),
                  onGoogleSignIn: () => onGoogleSignIn(context),
                  onAppleSignIn: () => onAppleSignIn(context),
                  onSignUp: () => onSignUp(context),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
