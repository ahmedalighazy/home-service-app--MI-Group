import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/common/auth_password_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/forget_password/password_success_dialog.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email;
  final String code;
  const SetNewPasswordScreen(
      {super.key, required this.email, required this.code});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String _password = '';
  String _confirmPassword = '';

  @override
  void initState() {
    super.initState();

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

  void _onConfirm(BuildContext context) {
    if (_password.isEmpty || _password != _confirmPassword) return;
    context.read<AuthCubit>().resetPassword(
          email: widget.email,
          code: widget.code,
          newPassword: _password,
        );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty =
        _password.isEmpty || _confirmPassword.isEmpty;
    final bool isError = !isEmpty && _password != _confirmPassword;
    final bool isSuccess = !isEmpty && _password == _confirmPassword;

    Color getBorderColor() {
      if (isError) return const Color(0xFFE05C5C);
      if (isSuccess) return const Color(0xFF3B8766);
      return const Color(0xFFE2E8F0);
    }

    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            showPasswordSuccessDialog(context, () {
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.emailLogin,
                  (route) => route.isFirst,
                );
              }
            });
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFE05C5C),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final isArabic =
              Localizations.localeOf(context).languageCode == 'ar';

          return Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isArabic ? Icons.arrow_forward : Icons.arrow_back,
                        color: Colors.black,
                        size: 18,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: isArabic
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  AppStrings.setNewPassword,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  AppStrings.setNewPasswordDescription,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                Text(
                                  AppStrings.passwordLabel,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                AuthPasswordField(
                                  controller: _passwordController,
                                  label: AppStrings.passwordLabel,
                                  hint: AppStrings.passwordPlaceholder,
                                  obscureText: _obscurePassword,
                                  onToggleObscure: () => setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  }),
                                  borderColor: getBorderColor(),
                                ),
                                const SizedBox(height: 20),

                                Text(
                                  AppStrings.confirmPasswordLabel,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                AuthPasswordField(
                                  controller: _confirmPasswordController,
                                  label: AppStrings.confirmPasswordLabel,
                                  hint: AppStrings.confirmPasswordPlaceholder,
                                  obscureText: _obscureConfirmPassword,
                                  onToggleObscure: () => setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  }),
                                  borderColor: getBorderColor(),
                                ),

                                if (isError) ...[
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: isArabic
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Text(
                                      AppStrings.errorPasswordsDoNotMatch,
                                      style: const TextStyle(
                                        color: Color(0xFFE05C5C),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],

                                const Spacer(),
                                const SizedBox(height: 20),

                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: isSuccess && !isLoading
                                        ? () => _onConfirm(context)
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isSuccess
                                          ? const Color(0xFF0F687D)
                                          : const Color(0xFFE9F0F4),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Text(
                                            isArabic ? 'تأكيد' : 'Confirm',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: isSuccess
                                                  ? Colors.white
                                                  : const Color(0xFF98A9BC),
                                            ),
                                          ),
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
      ),
    );
  }
}
