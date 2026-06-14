import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_state.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routes/app_routes.dart';

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
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String _password = "";
  String _confirmPassword = "";

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
    final bool isEmpty = _password.isEmpty || _confirmPassword.isEmpty;
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
            _showSuccessDialog(context);
          } else if (state is ResetPasswordError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFE05C5C),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFE05C5C),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 18,
                      ),
                      onPressed: () => context.pop(),
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
                              horizontal: 24.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Text(
                                  "تعيين كلمة مرور جديدة",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "أنشئ كلمة مرور جديدة، وتأكد من أنها مختلفة عن كلمة المرور السابقة.",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                const Text(
                                  "كلمة المرور",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: getBorderColor(),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      hintText: "أدخل كلمة المرور",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                const Text(
                                  "تأكيد كلمة المرور",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: getBorderColor(),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _confirmPasswordController,
                                    obscureText: _obscureConfirmPassword,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      hintText: "أعد إدخال كلمة المرور",
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          _obscureConfirmPassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureConfirmPassword =
                                                !_obscureConfirmPassword;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                if (isError) ...[
                                  const SizedBox(height: 8),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "كلمتا المرور غير متطابقتين",
                                      style: TextStyle(
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
                                        borderRadius: BorderRadius.circular(15),
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
                                            "تأكيد",
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

  void _showSuccessDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  // Success icon with larger, more prominent design
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5F0),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3B8766),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 42,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    "تم تغيير كلمة المرور بنجاح",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "يمكنك الآن تسجيل الدخول بكلمة المرور الجديدة",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        if (parentContext.mounted) {
                          GoRouter.of(parentContext).go(AppRouter.signIn);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F687D),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
