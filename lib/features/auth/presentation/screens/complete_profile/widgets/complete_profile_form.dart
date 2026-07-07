import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/features/auth/cubit/register/register_cubit.dart';
import 'package:home_service_app/features/auth/cubit/register/register_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'complete_profile_widget.dart';

class CompleteProfileForm extends StatefulWidget {
  final String? email;

  const CompleteProfileForm({super.key, required this.email});

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePass = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            label: context.tr('phoneNumber'),
            hint: context.tr('phonePlaceholder'),
            controller: cubit.phoneCtrl,
            prefixIcon: Icons.phone_android,
            keyboardType: TextInputType.phone,
            validator: (v) => (v == null || v.trim().isEmpty)
                ? context.tr('phoneRequired')
                : null,
          ),
          SizedBox(height: 16.h),
          AuthFormField(
            label: context.tr('passwordLabel'),
            hint: context.tr('passwordPlaceholder'),
            controller: cubit.newPasswordCtrl,
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: true,
            obscureText: _obscurePass,
            onToggleObscure: () => setState(() => _obscurePass = !_obscurePass),
            validator: (v) {
              if (v == null || v.isEmpty) return context.tr('passwordRequired');
              if (v.length < 6) return context.tr('passwordMinLength');
              return null;
            },
          ),
          SizedBox(height: 16.h),

          SizedBox(height: 32.h),
          _CompleteProfileSubmitButton(
            phone: cubit.phoneCtrl,
            email: widget.email,
            formKey: _formKey,
            nameCtrl: cubit.nameCtrl,
            emailCtrl: cubit.emailCtrl,
            newPasswordCtrl: cubit.newPasswordCtrl,
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}

class _CompleteProfileSubmitButton extends StatelessWidget {
  final String? email;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phone;

  final TextEditingController newPasswordCtrl;

  const _CompleteProfileSubmitButton({
    required this.email,
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.newPasswordCtrl,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, bool>(
      selector: (state) => state is CompleteProfileLoading,
      builder: (context, isLoading) => AuthPrimaryButton(
        label: context.tr('completeRegistration'),
        isLoading: isLoading,
        onPressed: () {
          if (!formKey.currentState!.validate()) return;
          context.read<RegisterCubit>().completeRegistration(
            email: emailCtrl.text.trim().isNotEmpty
                ? emailCtrl.text.trim()
                : (email ?? ''),
            name: nameCtrl.text.trim(),
            phone: phone.text,
            password: newPasswordCtrl.text,
          );
        },
      ),
    );
  }
}
