import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/features/auth/presentation/screens/forget_password/widgets/forget_pass_widget.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../cubits/auth_cubit.dart';
import '../../cubits/auth_state.dart';
import '../../cubits/forget_password_cubit.dart';
import 'logic/forget_pass_logic.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ForgetPasswordCubit>()),
        BlocProvider(create: (_) => getIt<AuthCubit>()),
      ],
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
            listener: (context, state) => _logic.handleForgetPasswordState(context, state),
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) => _logic.handleAuthState(context, state),
          ),
        ],
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const ForgetHeader(),

                            SizedBox(height: 32.h),

                            ForgetEmailField(
                              controller: _logic.emailController,
                              onChanged: (value) => _logic.onEmailChanged(context, value),
                            ),

                            const Spacer(),

                            SizedBox(height: 24.h),

                            ForgetSubmitButton(
                              onPressed: () => _logic.onSendResetCode(context),
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
      ),
    );
  }
}