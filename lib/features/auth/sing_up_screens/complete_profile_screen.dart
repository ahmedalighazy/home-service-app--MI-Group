import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../logic/cubits/auth_cubit.dart';
import '../logic/states/auth_state.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../../../core/themes/text/app_text.dart';
import '../../../core/utils/l10n/app_strings.dart';
import '../presentation/widgets/auth_back_button.dart';
import '../presentation/widgets/auth_form_field.dart';
import '../presentation/widgets/auth_primary_button.dart';

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
    context.read<AuthCubit>().register(
          name: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          phone: widget.phoneNumber ?? '',
          password: _passCtrl.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(state.message,
                      style:
                          AppText.ibmDescription14(color: AppColors.white)),
                  backgroundColor: AppColors.errorRed,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ));
            }
          },
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
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 16.h),

                            // ── Back button ──────────────────────────
                            Align(
                              alignment: Alignment.centerRight,
                              child: AuthBackButton(
                                onTap: () => Navigator.pop(context),
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // ── Profile avatar ───────────────────────
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 90.w,
                                    height: 90.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.light,
                                      border: Border.all(
                                        color: AppColors.borderInputs,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.person_outline_rounded,
                                      size: 48.sp,
                                      color: AppColors.gray,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: Container(
                                      width: 28.w,
                                      height: 28.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.white,
                                        border: Border.all(
                                            color: AppColors.borderInputs),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.08),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.edit_outlined,
                                        size: 14.sp,
                                        color: AppColors.greenPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // ── Title ────────────────────────────────
                            Text(
                              AppStrings.completeProfile,
                              textAlign: TextAlign.center,
                              style: AppText.ibmHeading22(
                                  color: AppColors.dark),
                            ),

                            SizedBox(height: 6.h),

                            Text(
                              AppStrings.completeProfileSubtitle,
                              textAlign: TextAlign.center,
                              style: AppText.ibmDescription14(
                                  color: AppColors.secondaryText),
                            ),

                            SizedBox(height: 28.h),

                            // ── Name ─────────────────────────────────
                            AuthFormField(
                              label: AppStrings.nameLabel,
                              hint: AppStrings.namePlaceholder,
                              controller: _nameCtrl,
                              prefixIcon: Icons.person_outline_rounded,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'الاسم مطلوب';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            // ── Email ─────────────────────────────────
                            AuthFormField(
                              label: AppStrings.emailLabel,
                              hint: AppStrings.emailPlaceholder,
                              controller: _emailCtrl,
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

                            // ── Password ──────────────────────────────
                            AuthFormField(
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
                                  return 'كلمة المرور مطلوبة';
                                }
                                if (v.length < 6) {
                                  return 'يجب أن تكون 6 أحرف على الأقل';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            // ── Confirm password ──────────────────────
                            AuthFormField(
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
                                  return 'تأكيد كلمة المرور مطلوب';
                                }
                                if (v != _passCtrl.text) {
                                  return AppStrings.errorPasswordsDoNotMatch;
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 32.h),

                            // ── Complete button ───────────────────────
                            AuthPrimaryButton(
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
            );
          },
        ),
      ),
    );
  }
}
