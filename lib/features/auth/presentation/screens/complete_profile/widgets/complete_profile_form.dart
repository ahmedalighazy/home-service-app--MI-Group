import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'complete_profile_widget.dart';

class CompleteProfileForm extends StatelessWidget {
  final String? email;
  final bool isLoading;
  final AuthCubit cubit;

  const CompleteProfileForm({
    super.key,
    required this.email,
    required this.isLoading,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.completeProfileFormKey,
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
            controller: cubit.nameCtrl,
            prefixIcon: Icons.person_outline_rounded,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? context.tr('nameRequired')
                : null,
          ),
          SizedBox(height: 16.h),
          AuthFormField(
            label: context.tr('emailLabel'),
            hint: context.tr('emailPlaceholder'),
            controller: cubit.emailCtrl,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? context.tr('emailRequired')
                : null,
          ),
          SizedBox(height: 16.h),
          AuthFormField(
            label: context.tr('passwordLabel'),
            hint: context.tr('passwordPlaceholder'),
            controller: cubit.passwordCtrl,
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: true,
            obscureText: cubit.uiState.obscureCompleteProfilePass,
            onToggleObscure: cubit.toggleCompleteProfilePass,
            validator: (v) {
              if (v == null || v.isEmpty) return context.tr('passwordRequired');
              if (v.length < 6) return context.tr('passwordMinLength');
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AuthFormField(
            label: context.tr('confirmPasswordLabel'),
            hint: context.tr('confirmPasswordPlaceholder'),
            controller: cubit.confirmPasswordCtrl,
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: true,
            obscureText: cubit.uiState.obscureCompleteProfileConfirm,
            onToggleObscure: cubit.toggleCompleteProfileConfirm,
            validator: (v) {
              if (v == null || v.isEmpty)
                return context.tr('confirmPasswordRequired');
              if (v != cubit.passwordCtrl.text)
                return context.tr('errorPasswordsDoNotMatch');
              return null;
            },
          ),
          SizedBox(height: 32.h),
          AuthPrimaryButton(
            label: context.tr('completeRegistration'),
            isLoading: isLoading,
            onPressed: () {
              if (!cubit.completeProfileFormKey.currentState!.validate())
                return;
              cubit.register(
                name: cubit.nameCtrl.text.trim(),
                email: cubit.emailCtrl.text.trim().isNotEmpty
                    ? cubit.emailCtrl.text.trim()
                    : (email ?? ''),
                phone: '',
                password: cubit.passwordCtrl.text,
              );
            },
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
