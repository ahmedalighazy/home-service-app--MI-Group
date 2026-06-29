import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String _password = '';
  String _confirmPassword = '';

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().resetState();

    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
    _confirmPasswordController.addListener(() {
      setState(() {
        _confirmPassword = _confirmPasswordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isEmpty => _password.isEmpty || _confirmPassword.isEmpty;
  bool get _isError => !_isEmpty && _password != _confirmPassword;
  bool get _isSuccess => !_isEmpty && _password == _confirmPassword;

  Color _getBorderColor() {
    if (_isError) return AppColors.errorRed;
    if (_isSuccess) return AppColors.greenPrimary;
    return AppColors.borderInputs;
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleObscureConfirmPassword() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _onConfirm() {
    if (_password.isEmpty || _password != _confirmPassword) return;
    context.read<AuthCubit>().resetPassword(
          email: widget.email,
          code: widget.code,
          newPassword: _password,
        );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetSuccessState) {
          GoRouter.of(context).go(AppRouter.passwordChangedSuccessfully);
        } else if (state is PasswordResetErrorState) {
          _showSnackBar(state.message, AppColors.errorRed);
        } else if (state is AuthErrorState) {
          _showSnackBar(state.message, AppColors.errorRed);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Scaffold(
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              context.tr('setNewPasswordTitle'),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              context.tr('setNewPasswordDescription'),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 32),
                            PasswordInputField(
                              title: context.tr('passwordLabel'),
                              hintText: context.tr('passwordPlaceholder'),
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              borderColor: _getBorderColor(),
                              onObscurePressed: _toggleObscurePassword,
                            ),
                            const SizedBox(height: 20),
                            PasswordInputField(
                              title: context.tr('confirmPasswordLabel'),
                              hintText: context.tr('confirmPasswordPlaceholder'),
                              controller: _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              borderColor: _getBorderColor(),
                              onObscurePressed: _toggleObscureConfirmPassword,
                            ),
                            if (_isError) const SetNewPasswordErrorText(),
                            const Spacer(),
                            const SizedBox(height: 20),
                            SetNewPasswordButton(
                              isSuccess: _isSuccess,
                              isLoading: isLoading,
                              onPressed: _onConfirm,
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
        );
      },
    );
  }
}
