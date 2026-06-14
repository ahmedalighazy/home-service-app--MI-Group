import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_state.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routes/app_routes.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import '../../../../../core/themes/image/app_assets.dart';
import '../../../../../core/themes/text/app_text.dart';
import '../../../../../core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_text_field.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController _emailCtrl = TextEditingController();

  bool _hasError = false;
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    _emailCtrl.addListener(() {
      final hasInput = _emailCtrl.text.trim().isNotEmpty;
      if (hasInput != _hasInput) setState(() => _hasInput = hasInput);
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  bool get _isValid {
    final email = _emailCtrl.text.trim();
    return email.isNotEmpty && email.contains('@') && email.contains('.');
  }

  void _onSend(BuildContext context) {
    if (!_isValid) return;
    setState(() => _hasError = false);
    context.read<AuthCubit>().sendResetCode(_emailCtrl.text.trim());
  }

  void _onFieldChanged(String _) => setState(() => _hasError = false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: _handleState,
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 16.h),

                                // ── Back button ──────────────────────
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: AuthBackButton(
                                    onTap: () => context.pop(),
                                  ),
                                ),

                                SizedBox(height: 32.h),

                                // ── Illustration ─────────────────────
                                Center(
                                  child: Image.asset(
                                    AppAssets.forgot,
                                    width: 200.w,
                                    height: 200.w,
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                SizedBox(height: 32.h),

                                // ── Title ────────────────────────────
                                Text(
                                  AppStrings.resetPassword,
                                  textAlign: TextAlign.center,
                                  style: AppText.ibmHeading22(
                                    color: AppColors.dark,
                                  ),
                                ),

                                SizedBox(height: 10.h),

                                // ── Subtitle ─────────────────────────
                                Text(
                                  AppStrings.resetPasswordDescription,
                                  textAlign: TextAlign.center,
                                  style: AppText.ibmDescription14(
                                    color: AppColors.secondaryText,
                                  ),
                                ),

                                SizedBox(height: 32.h),

                                // ── Email field ──────────────────────
                                AuthTextField(
                                  label: AppStrings.emailLabel,
                                  hint: AppStrings.emailPlaceholder,
                                  controller: _emailCtrl,
                                  prefixIcon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  hasError: _hasError,
                                  errorMessage: 'يرجى إدخال بريد إلكتروني صحيح',
                                  onChanged: _onFieldChanged,
                                ),

                                const Spacer(),

                                SizedBox(height: 24.h),

                                // ── Send button ──────────────────────
                                AuthPrimaryButton(
                                  label: AppStrings.sendCode,
                                  isLoading: isLoading,
                                  isEnabled: _isValid,
                                  onPressed: () => _onSend(context),
                                ),

                                SizedBox(height: 32.h),
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
        ),
      ),
    );
  }

  void _handleState(BuildContext context, AuthState state) {
    // ── Code sent → navigate to verify screen ───────────
    if (state is ResetCodeSent) {
      context.push(AppRouter.verifyResetCode, extra: state.email);

      // ── Network / server error ───────────────────────────
    } else if (state is AuthError) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.message,
              style: AppText.ibmDescription14(color: AppColors.white),
            ),
            backgroundColor: AppColors.errorRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    }
  }
}
