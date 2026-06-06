import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/auth/logic/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/logic/states/auth_state.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:home_service_app/features/auth/presentation/widgets/complete_profile/profile_avatar.dart';
import 'package:home_service_app/features/auth/presentation/widgets/complete_profile/profile_form_field.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

class CompleteProfileUnifiedScreen extends StatefulWidget {
  final String phoneNumber;

  const CompleteProfileUnifiedScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<CompleteProfileUnifiedScreen> createState() =>
      _CompleteProfileUnifiedScreenState();
}

class _CompleteProfileUnifiedScreenState
    extends State<CompleteProfileUnifiedScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  late final AuthCubit _authCubit;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  bool _isFormValid() {
    return _nameCtrl.text.trim().isNotEmpty &&
        _emailCtrl.text.trim().isNotEmpty &&
        _isValidEmail(_emailCtrl.text.trim()) &&
        _passwordCtrl.text.length >= 6 &&
        _passwordCtrl.text == _confirmPasswordCtrl.text;
  }

  Future<void> _handleSelectImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (pickedFile != null) {
      setState(() => _profileImagePath = pickedFile.path);
    }
  }

  void _handleCompleteRegistration() {
    if (!_isFormValid()) {
      _showErrorSnackBar('يرجى إكمال جميع الحقول بشكل صحيح');
      return;
    }

    _authCubit.completeProfile(
          phoneNumber: widget.phoneNumber,
          name: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          gender: 'not_specified',
        );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorRed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.greenPrimary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = AppStrings.isArabic;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocProvider.value(
            value: _authCubit,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is ProfileCompletionSuccess) {
                  _showSuccessMessage('تم إكمال التسجيل بنجاح');
                  Future.delayed(const Duration(seconds: 1), () {
                    if (!context.mounted) return;
                    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                  });
                } else if (state is ProfileCompletionError) {
                  _showErrorSnackBar(state.message);
                } else if (state is AuthError) {
                  _showErrorSnackBar(state.message);
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: isArabic
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            'assets/images/Frame 2147225973.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        AppStrings.completeProfile,
                        style: AppText.ibmHeading22(
                          color: AppColors.primaryText,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        AppStrings.completeProfileSubtitle,
                        style: AppText.ibmDescription14(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      ProfileAvatar(
                        imagePath: _profileImagePath,
                        onTap: _handleSelectImage,
                      ),
                      SizedBox(height: 32.h),
                      ProfileFormField(
                        label: AppStrings.nameLabel,
                        hint: AppStrings.namePlaceholder,
                        controller: _nameCtrl,
                        prefixIcon: Icons.person_outline_rounded,
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(height: 16.h),
                      ProfileFormField(
                        label: AppStrings.emailLabel,
                        hint: AppStrings.emailPlaceholder,
                        controller: _emailCtrl,
                        prefixIcon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(height: 16.h),
                      ProfileFormField(
                        label: AppStrings.passwordLabel,
                        hint: AppStrings.passwordPlaceholder,
                        controller: _passwordCtrl,
                        isPassword: true,
                        obscureText: !_passwordVisible,
                        onToggleObscure: () => setState(
                          () => _passwordVisible = !_passwordVisible,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(height: 16.h),
                      ProfileFormField(
                        label: AppStrings.confirmPasswordLabel,
                        hint: AppStrings.confirmPasswordPlaceholder,
                        controller: _confirmPasswordCtrl,
                        isPassword: true,
                        obscureText: !_confirmPasswordVisible,
                        onToggleObscure: () => setState(
                          () => _confirmPasswordVisible =
                              !_confirmPasswordVisible,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      SizedBox(height: 32.h),
                      AuthPrimaryButton(
                        label: AppStrings.completeRegistration,
                        isLoading: state is AuthLoading,
                        isEnabled: _isFormValid(),
                        onPressed: _handleCompleteRegistration,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
