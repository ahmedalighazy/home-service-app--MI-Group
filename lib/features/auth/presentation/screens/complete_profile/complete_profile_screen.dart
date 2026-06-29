import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'widget/complete_profile_widget.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String? email;
  const CompleteProfileScreen({super.key, this.email});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _identifierCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().resetState();

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _animCtrl.forward();

    if (widget.email != null && widget.email!.isNotEmpty) {
      _identifierCtrl.text = widget.email!;
    }
  }

  void _toggleObscurePass() {
    setState(() {
      _obscurePass = !_obscurePass;
    });
  }

  void _toggleObscureConfirm() {
    setState(() {
      _obscureConfirm = !_obscureConfirm;
    });
  }

  void _onComplete() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().register(
          name: _nameCtrl.text.trim(),
          email: _identifierCtrl.text.trim().isNotEmpty
              ? _identifierCtrl.text.trim()
              : (widget.email ?? ''),
          phone: '',
          password: _passCtrl.text,
        );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppText.ibmDescription14(color: AppColors.white),
          ),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _nameCtrl.dispose();
    _identifierCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          context.go(AppRouter.home);
        } else if (state is AuthErrorState) {
          _showSnackBar(state.message, AppColors.errorRed);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: CustomBackArrowButton(
                onPressed: () => GoRouter.of(context).go(AppRouter.signUp),
              ),
            ),
          ),
          body: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: SafeArea(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20.h),
                        const ProfileAvatar(),
                        SizedBox(height: 20.h),
                        const CompleteProfileHeader(),
                        SizedBox(height: 28.h),
                        AuthFormField(
                          label: context.tr('nameLabel'),
                          hint: context.tr('namePlaceholder'),
                          controller: _nameCtrl,
                          prefixIcon: Icons.person_outline_rounded,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return context.tr('nameRequired');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        AuthFormField(
                          label: context.tr('emailLabel'),
                          hint: context.tr('emailPlaceholder'),
                          controller: _identifierCtrl,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return context.tr('emailRequired');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        AuthFormField(
                          label: context.tr('passwordLabel'),
                          hint: context.tr('passwordPlaceholder'),
                          controller: _passCtrl,
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: true,
                          obscureText: _obscurePass,
                          onToggleObscure: _toggleObscurePass,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return context.tr('passwordRequired');
                            }
                            if (v.length < 6) {
                              return context.tr('passwordMinLength');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        AuthFormField(
                          label: context.tr('confirmPasswordLabel'),
                          hint: context.tr('confirmPasswordPlaceholder'),
                          controller: _confirmPassCtrl,
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: true,
                          obscureText: _obscureConfirm,
                          onToggleObscure: _toggleObscureConfirm,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return context.tr('confirmPasswordRequired');
                            }
                            if (v != _passCtrl.text) {
                              return context.tr('errorPasswordsDoNotMatch');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 32.h),
                        AuthPrimaryButton(
                          label: context.tr('completeRegistration'),
                          isLoading: isLoading,
                          onPressed: _onComplete,
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
