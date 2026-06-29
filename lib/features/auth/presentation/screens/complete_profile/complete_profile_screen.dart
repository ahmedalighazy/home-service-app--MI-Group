import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'widget/complete_profile_widget.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';

import 'logic/complete_profile_logic.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String? email;
  const CompleteProfileScreen({super.key, this.email});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with SingleTickerProviderStateMixin {
  late final CompleteProfileLogic _logic;

  @override
  void initState() {
    super.initState();
    getIt<AuthCubit>().resetState();
    _logic = CompleteProfileLogic(
      vsync: this,
      onStateChanged: () {
        if (mounted) setState(() {});
      },
    );
    if (widget.email != null && widget.email!.isNotEmpty) {
      _logic.identifierCtrl.text = widget.email!;
    }
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listener: (context, state) => _logic.handleState(context, state),
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
            opacity: _logic.fadeAnim,
            child: SlideTransition(
              position: _logic.slideAnim,
              child: SafeArea(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _logic.formKey,
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
                          controller: _logic.nameCtrl,
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
                          controller: _logic.identifierCtrl,
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
                          controller: _logic.passCtrl,
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: true,
                          obscureText: _logic.obscurePass,
                          onToggleObscure: _logic.toggleObscurePass,
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
                          controller: _logic.confirmPassCtrl,
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: true,
                          obscureText: _logic.obscureConfirm,
                          onToggleObscure: _logic.toggleObscureConfirm,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return context.tr('confirmPasswordRequired');
                            }
                            if (v != _logic.passCtrl.text) {
                              return context.tr('errorPasswordsDoNotMatch');
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 32.h),

                        AuthPrimaryButton(
                          label: context.tr('completeRegistration'),
                          isLoading: isLoading,
                          onPressed: () => _logic.onComplete(context: context),
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
