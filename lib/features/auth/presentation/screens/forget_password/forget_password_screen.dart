import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/forget_password_cubit.dart';
import 'widget/forget_pass_widget.dart';
import 'widget/forget_password_bloc_listener.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ForgetPasswordCubit>(),
      child: const _ForgetScreenContent(),
    );
  }
}

class _ForgetScreenContent extends StatefulWidget {
  const _ForgetScreenContent();

  @override
  State<_ForgetScreenContent> createState() => _ForgetScreenContentState();
}

class _ForgetScreenContentState extends State<_ForgetScreenContent> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().resetState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onEmailChanged(BuildContext context, String value) {
    context.read<ForgetPasswordCubit>().updateEmail(value);
  }

  void _onSendResetCode(BuildContext context) {
    context.read<ForgetPasswordCubit>().onSendResetCode();
  }

  @override
  Widget build(BuildContext context) {
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: CustomBackArrowButton(),
                        ),
                        const ForgetHeader(),
                        SizedBox(height: 32.h),
                        ForgetEmailField(
                          controller: _emailController,
                          onChanged: (value) => _onEmailChanged(context, value),
                        ),
                        const Spacer(),
                        SizedBox(height: 24.h),
                        ForgetSubmitButton(
                          onPressed: () => _onSendResetCode(context),
                        ),
                        SizedBox(height: 32.h),
                        const ForgetPasswordBlocListener(),
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
