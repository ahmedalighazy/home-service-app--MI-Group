import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubits/auth_cubit.dart';
import '../../validators/sign_up_validator.dart';
import '../../widgets/sign_up_app_bar.dart';
import 'widgets/sign_up_body.dart';
import 'widgets/sign_up_bloc_listener.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hasError = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().resetState();
  }

  void _onEmailChanged(String _) {
    if (hasError) {
      setState(() {
        hasError = false;
        errorMessage = null;
      });
    } else {
      setState(() {});
    }
  }

  void _onSendCode() {
    final cubit = context.read<AuthCubit>();
    final email = cubit.signUpEmailCtrl.text.trim();
    final error = SignUpValidator.validateEmail(email);
    if (error != null) {
      setState(() {
        hasError = true;
        errorMessage = error;
      });
      return;
    }
    setState(() {
      hasError = false;
      errorMessage = null;
    });
    cubit.sendSmsCode(email);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: const SignUpAppBar(),
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: SignUpBody(
                    emailController: cubit.signUpEmailCtrl,
                    hasError: hasError,
                    errorMessage: errorMessage,
                    isLoading: isLoading,
                    onSendCode: _onSendCode,
                    onGoogleSignUp: () => cubit.signUpWithGoogle(),
                    onAppleSignUp: () => cubit.signUpWithApple(),
                    onGuestMode: () => cubit.loginAsGuest(),
                    onSignIn: () => context.go(AppRouter.signIn),
                    onEmailChanged: _onEmailChanged,
                  ),
                ),
                const SignUpBlocListener(),
              ],
            ),
          ),
        );
      },
    );
  }
}
