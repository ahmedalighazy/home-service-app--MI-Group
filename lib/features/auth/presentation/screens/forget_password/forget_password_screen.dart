import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/forget_password_cubit.dart';
import '../../states/auth_state.dart';
import '../../widgets/auth_back_button.dart';
import 'logic/forget_pass_logic.dart';
import 'widget/forget_pass_widget.dart';

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
  late final ForgetScreenLogic _logic;

  @override
  void initState() {
    super.initState();
    getIt<AuthCubit>().resetState();
    _logic = ForgetScreenLogic();
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: MultiBlocListener(
        listeners: [
          BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) =>
                _logic.handleForgetPasswordState(context, state),
          ),
          BlocListener<AuthCubit, AuthState>(
            bloc: getIt<AuthCubit>(),
            listener: (context, state) =>
                _logic.handleAuthState(context, state),
          ),
        ],
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AuthBackButton(
                              onTap: () {
                                if (GoRouter.of(context).canPop()) {
                                  GoRouter.of(context).pop();
                                } else {
                                  GoRouter.of(context).go(AppRouter.signIn);
                                }
                              },
                            ),
                          ),
                          const ForgetHeader(),
                          SizedBox(height: 32.h),
                          ForgetEmailField(
                            controller: _logic.emailController,
                            onChanged: (value) =>
                                _logic.onEmailChanged(context, value),
                          ),
                          const Spacer(),
                          SizedBox(height: 24.h),
                          ForgetSubmitButton(
                            onPressed: () =>
                                _logic.onSendResetCode(context),
                          ),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
