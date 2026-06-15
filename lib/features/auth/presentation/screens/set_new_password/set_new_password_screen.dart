import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/auth_strings.dart';
import '../../../../../core/di/injection.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/states/auth_state.dart';
import 'package:home_service_app/core/routes/app_routes.dart';

import 'logic/set_new_logic.dart';
import 'widget/set_new_widgets.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email;
  final String code;

  const SetNewPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  late final SetNewPasswordLogic _logic;

  @override
  void initState() {
    super.initState();
    getIt<AuthCubit>().resetState();
    _logic = SetNewPasswordLogic(
      onStateChanged: () {
        if (mounted) setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  void _navigateToSuccessScreen() {
    GoRouter.of(context).go(AppRouter.passwordChangedSuccessfully);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listener: (context, state) => _logic.handleState(
        context: context,
        state: state,
        onSuccess: _navigateToSuccessScreen,
      ),
      builder: (context, state) {
          final isLoading = state is AuthLoadingState;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  leading: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: AuthBackButton(onTap: () => GoRouter.of(context).pop()),
                  ),
                ),
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Text(
                                  AuthStrings.setNewPasswordTitle,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  AuthStrings.setNewPasswordDescription,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                PasswordInputField(
                                  title: AuthStrings.passwordLabel,
                                  hintText: AuthStrings.passwordPlaceholder,
                                  controller: _logic.passwordController,
                                  obscureText: _logic.obscurePassword,
                                  borderColor: _logic.getBorderColor(),
                                  onObscurePressed: _logic.toggleObscurePassword,
                                ),

                                const SizedBox(height: 20),

                                PasswordInputField(
                                  title: AuthStrings.confirmPasswordLabel,
                                  hintText: AuthStrings.confirmPasswordPlaceholder,
                                  controller: _logic.confirmPasswordController,
                                  obscureText: _logic.obscureConfirmPassword,
                                  borderColor: _logic.getBorderColor(),
                                  onObscurePressed: _logic.toggleObscureConfirmPassword,
                                ),

                                if (_logic.isError) const SetNewPasswordErrorText(),

                                const Spacer(),
                                const SizedBox(height: 20),

                                SetNewPasswordButton(
                                  isSuccess: _logic.isSuccess,
                                  isLoading: isLoading,
                                  onPressed: () => _logic.onConfirm(
                                    context: context,
                                    email: widget.email,
                                    code: widget.code,
                                  ),
                                ),
                                const SizedBox(height: 20),
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
        },
      );
  }
}