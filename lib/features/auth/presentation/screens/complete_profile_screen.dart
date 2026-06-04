import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/common/auth_back_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/common/auth_gradient_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/complete_profile/profile_avatar.dart';
import 'package:home_service_app/features/auth/presentation/widgets/complete_profile/profile_form_field.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String? phoneNumber;
  const CompleteProfileScreen({super.key, this.phoneNumber});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
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
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _onComplete(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text;
    final phone = widget.phoneNumber ?? '';
    context.read<AuthCubit>().register(
          name: name,
          email: email,
          phone: phone,
          password: password,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.home);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorRed,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';

          return Scaffold(
            backgroundColor: AppColors.white,
            body: Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: FadeTransition(
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
                            SizedBox(height: 16.h),

                            // ── Back button ────────────────────────────────
                            Align(
                              alignment: isArabic
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: AuthBackButton(
                                onTap: () => Navigator.pop(context),
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // ── Profile Avatar ─────────────────────────────
                            const ProfileAvatar(),

                            SizedBox(height: 20.h),

                            // ── Title ──────────────────────────────────────
                            Text(
                              AppStrings.completeProfile,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: AppColors.dark,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 6.h),

                            Text(
                              AppStrings.completeProfileSubtitle,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ibmPlexSansArabic(
                                color: AppColors.secondaryText,
                                fontSize: 13.sp,
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: 28.h),

                            // ── Name Field ─────────────────────────────────
                            ProfileFormField(
                              label: AppStrings.nameLabel,
                              hint: AppStrings.namePlaceholder,
                              controller: _nameCtrl,
                              prefixIcon: Icons.person_outline_rounded,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return isArabic
                                      ? 'الاسم مطلوب'
                                      : 'Full name is required';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            // ── Email Field ────────────────────────────────
                            ProfileFormField(
                              label: AppStrings.emailLabel,
                              hint: AppStrings.emailPlaceholder,
                              controller: _emailCtrl,
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return isArabic
                                      ? 'البريد الإلكتروني مطلوب'
                                      : 'Email address is required';
                                }
                                if (!v.contains('@') || !v.contains('.')) {
                                  return isArabic
                                      ? 'البريد الإلكتروني غير صحيح'
                                      : 'Invalid email address';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            // ── Password Field ─────────────────────────────
                            ProfileFormField(
                              label: AppStrings.passwordLabel,
                              hint: AppStrings.passwordPlaceholder,
                              controller: _passCtrl,
                              prefixIcon: Icons.lock_outline_rounded,
                              isPassword: true,
                              obscureText: _obscurePass,
                              onToggleObscure: () =>
                                  setState(() => _obscurePass = !_obscurePass),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return isArabic
                                      ? 'كلمة المرور مطلوبة'
                                      : 'Password is required';
                                }
                                if (v.length < 6) {
                                  return isArabic
                                      ? 'كلمة المرور يجب أن تكون 6 أحرف على الأقل'
                                      : 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            // ── Confirm Password Field ─────────────────────
                            ProfileFormField(
                              label: AppStrings.confirmPasswordLabel,
                              hint: AppStrings.confirmPasswordPlaceholder,
                              controller: _confirmPassCtrl,
                              prefixIcon: Icons.lock_outline_rounded,
                              isPassword: true,
                              obscureText: _obscureConfirm,
                              onToggleObscure: () => setState(
                                  () => _obscureConfirm = !_obscureConfirm),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return isArabic
                                      ? 'تأكيد كلمة المرور مطلوب'
                                      : 'Confirm password is required';
                                }
                                if (v != _passCtrl.text) {
                                  return AppStrings.errorPasswordsDoNotMatch;
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 32.h),

                            // ── Complete Registration Button ────────────────
                            AuthGradientButton(
                              label: AppStrings.completeRegistration,
                              isLoading: isLoading,
                              onPressed: () => _onComplete(context),
                            ),

                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
