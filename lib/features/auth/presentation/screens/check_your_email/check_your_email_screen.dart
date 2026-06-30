import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'widgets/email_verification_form.dart';
import 'widgets/verification_bloc_listener.dart';

class VerificationScreen extends StatelessWidget {
  final String email;
  final String code;

  const VerificationScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthCubit>();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cubit.uiState.emailVerificationTimer == null) {
        cubit.initEmailVerification();
        if (code.isNotEmpty && code.length == 6) {
          for (int i = 0; i < 6; i++) {
            cubit.controllers.emailVerificationControllers[i].text = code[i];
          }
          cubit.checkEmailVerificationCompletion();
        }
      }
    });

    final isLoading = cubit.state is AuthLoadingState;

    return VerificationBlocListener(
      email: email,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.all(8.w),
            child: CustomBackArrowButton(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom -
                    kToolbarHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: EmailVerificationForm(
                    email: email,
                    isLoading: isLoading,
                    cubit: cubit,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
