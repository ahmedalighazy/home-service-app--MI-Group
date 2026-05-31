// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection.dart';
import '../logic/cubits/auth_cubit.dart';
import '../logic/states/auth_state.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../../../core/utils/l10n/app_strings.dart';

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

          return Scaffold(
            backgroundColor: AppColors.white,
            body: Directionality(
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

                      // ── Back button ────────────────────────────────
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.borderInputs),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16.sp,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // ── Profile Avatar ─────────────────────────────
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
                                    color: AppColors.borderInputs,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
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
                      _ProfileField(
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

                      // ── Email Field ────────────────────────────────
                      _ProfileField(
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

                      // ── Password Field ─────────────────────────────
                      _ProfileField(
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
                            return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),

                      // ── Confirm Password Field ─────────────────────
                      _ProfileField(
                        label: AppStrings.confirmPasswordLabel,
                        hint: AppStrings.confirmPasswordPlaceholder,
                        controller: _confirmPassCtrl,
                        prefixIcon: Icons.lock_outline_rounded,
                        isPassword: true,
                        obscureText: _obscureConfirm,
                        onToggleObscure: () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
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

                      // ── Complete Registration Button ────────────────
                      _CompleteButton(
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

// ─────────────────────────────────────────────────────────────
//  Profile Form Field
// ─────────────────────────────────────────────────────────────
class _ProfileField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData prefixIcon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _ProfileField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleObscure,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<_ProfileField> createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<_ProfileField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.ibmPlexSansArabic(
            color: AppColors.headingText,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Focus(
          onFocusChange: (v) => setState(() => _isFocused = v),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword ? widget.obscureText : false,
            keyboardType: widget.keyboardType,
            textDirection: TextDirection.rtl,
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: GoogleFonts.ibmPlexSansArabic(
              color: AppColors.primaryText,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: GoogleFonts.ibmPlexSansArabic(
                color: AppColors.placeholder,
                fontSize: 13.sp,
              ),
              prefixIcon: Icon(
                widget.prefixIcon,
                size: 20.sp,
                color: _isFocused ? AppColors.greenPrimary : AppColors.gray,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        widget.obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                        color: AppColors.gray,
                      ),
                      onPressed: widget.onToggleObscure,
                    )
                  : null,
              filled: true,
              fillColor: AppColors.bgPrimary,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColors.borderInputs),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    const BorderSide(color: AppColors.greenPrimary, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColors.errorRed),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    const BorderSide(color: AppColors.errorRed, width: 1.5),
              ),
              errorStyle: GoogleFonts.ibmPlexSansArabic(
                fontSize: 11.sp,
                color: AppColors.errorRed,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Complete Registration Button
// ─────────────────────────────────────────────────────────────
class _CompleteButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _CompleteButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: 54.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          gradient: const LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Color(0xFF0A434E), Color(0xFF189AB4)],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.greenPrimary.withOpacity(0.3),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 22.w,
                  height: 22.w,
                  child: const CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  AppStrings.completeRegistration,
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: AppColors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}