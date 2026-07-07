import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:home_service_app/features/auth/listeners/forgot_password_bloc_listener.dart';
import 'forget_pass_widget.dart';

class ForgetScreenContent extends StatelessWidget {
  const ForgetScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: CustomBackArrowButton(),
                        ),
                        const ForgetHeader(),
                        SizedBox(height: 32.h),
                        ForgetEmailField(controller: cubit.emailCtrl),
                        const Spacer(),
                        SizedBox(height: 24.h),
                        ForgetSubmitButton(
                          onPressed: () {
                            // context.push(
                            //   AppRouter.verifyResetCode,
                            //   extra: 'mjad',
                            // );

                            cubit.forgotPassword(cubit.emailCtrl.text.trim());
                          },
                        ),
                        SizedBox(height: 32.h),
                        const ForgotPasswordBlocListener(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
