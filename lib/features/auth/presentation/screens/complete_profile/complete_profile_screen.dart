import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/auth/presentation/screens/complete_profile/widgets/complete_profile_widget.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';

import 'logic/complete_profile_logic.dart';


class CompleteProfileScreen extends StatefulWidget {
  final String? phoneNumber;
  const CompleteProfileScreen({super.key, this.phoneNumber});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with SingleTickerProviderStateMixin {
  late final CompleteProfileLogic _logic;
  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _logic = CompleteProfileLogic(
      onStateChanged: () {
        if (mounted) setState(() {});
      },
    );

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
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) => _logic.handleState(context, state),
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: _logic.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 16.h),

                            Align(
                              alignment: Alignment.centerRight,
                              child: AuthBackButton(onTap: () => context.pop()),
                            ),

                            SizedBox(height: 20.h),

                            const ProfileAvatar(),

                            SizedBox(height: 20.h),

                            const CompleteProfileHeader(),

                            SizedBox(height: 28.h),

                            AuthFormField(
                              label: AppStrings.nameLabel,
                              hint: AppStrings.namePlaceholder,
                              controller: _logic.nameCtrl,
                              prefixIcon: Icons.person_outline_rounded,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'الاسم مطلوب';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),


                            AuthFormField(
                              label: AppStrings.emailLabel,
                              hint: AppStrings.emailPlaceholder,
                              controller: _logic.emailCtrl,
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'البريد الإلكتروني مطلوب';
                                }
                                if (!v.contains('@') || !v.contains('.')) {
                                  return 'البريد الإلكتروني غير صحيح';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            AuthFormField(
                              label: AppStrings.passwordLabel,
                              hint: AppStrings.passwordPlaceholder,
                              controller: _logic.passCtrl,
                              prefixIcon: Icons.lock_outline_rounded,
                              isPassword: true,
                              obscureText: _logic.obscurePass,
                              onToggleObscure: _logic.toggleObscurePass,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'كلمة المرور مطلوبة';
                                }
                                if (v.length < 6) {
                                  return 'يجب أن تكون 6 أحرف على الأقل';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),


                            AuthFormField(
                              label: AppStrings.confirmPasswordLabel,
                              hint: AppStrings.confirmPasswordPlaceholder,
                              controller: _logic.confirmPassCtrl,
                              prefixIcon: Icons.lock_outline_rounded,
                              isPassword: true,
                              obscureText: _logic.obscureConfirm,
                              onToggleObscure: _logic.toggleObscureConfirm,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'تأكيد كلمة المرور مطلوب';
                                }
                                if (v != _logic.passCtrl.text) {
                                  return AppStrings.errorPasswordsDoNotMatch;
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 32.h),

                            AuthPrimaryButton(
                              label: AppStrings.completeRegistration,
                              isLoading: isLoading,
                              onPressed: () => _logic.onComplete(
                                context: context,
                                phoneNumber: widget.phoneNumber ?? '',
                              ),
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
        ),
      ),
    );
  }
}