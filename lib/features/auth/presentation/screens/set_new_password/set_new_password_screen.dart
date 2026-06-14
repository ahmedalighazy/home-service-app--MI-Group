import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/screens/set_new_password/widgets/set_new_widgets.dart';

import '../../../../../core/di/injection.dart';
import 'logic/set_new_logic.dart';

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

  void _triggerSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return SetNewPasswordSuccessDialog(parentContext: context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) => _logic.handleState(
          context: context,
          state: state,
          onSuccess: _triggerSuccessDialog,
        ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
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

                                PasswordInputField(
                                  title: "كلمة المرور",
                                  hintText: "أدخل كلمة المرور",
                                  controller: _logic.passwordController,
                                  obscureText: _logic.obscurePassword,
                                  borderColor: _logic.getBorderColor(),
                                  onObscurePressed: _logic.toggleObscurePassword,
                                ),

                                const SizedBox(height: 20),

                                PasswordInputField(
                                  title: "تأكيد كلمة المرور",
                                  hintText: "أعد إدخال كلمة المرور",
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
      ),
    );
  }
}