import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/auth_state.dart';
import 'sign_up_logic.dart';
import 'widgets/sign_up_app_bar.dart';
import 'widgets/sign_up_body.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SignUpLogic {
  @override
  void initState() {
    super.initState();
    phoneCtrl.addListener(onPhoneChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const SignUpAppBar(),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: handleState,
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: SignUpBody(
                  phoneController: phoneCtrl,
                  hasError: hasError,
                  errorMessage: errorMessage,
                  isLoading: state is AuthLoading,
                  onSendCode: () => onSendCode(context),
                  onGoogleSignUp: () => onGoogleSignUp(context),
                  onAppleSignUp: () => onAppleSignUp(context),
                  onGuestMode: () => onGuestMode(context),
                  onSignIn: () => onSignIn(context),
                  onPhoneChanged: (_) => setState(() {}),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
