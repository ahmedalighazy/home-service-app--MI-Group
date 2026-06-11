import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../logic/validators/profile_validator.dart';
import '../../cubits/auth_cubit_v2.dart';
import '../../states/auth_state.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

import '../../widgets/profile_name_field.dart';
import '../../widgets/profile_email_field.dart';
import '../../widgets/profile_gender_dropdown.dart';
import '../../widgets/profile_address_field.dart';
import '../../widgets/auth_primary_button.dart';

/// Complete Profile Screen - Presentation Layer
class CompleteProfileScreen extends StatefulWidget {
  final String phoneNumber;

  const CompleteProfileScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();

  late final AuthCubitV2 _authCubit;

  String? _selectedGender;
  final List<String> _genderOptions = [
    AuthStrings.genderMale,
    AuthStrings.genderFemale,
  ];

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubitV2>();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    if (_selectedGender == null) return false;
    return ProfileValidator.isFormValid(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      gender: _selectedGender!,
    );
  }

  void _handleCompleteProfile() {
    final errors = ProfileValidator.validateForm(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      gender: _selectedGender ?? '',
    );

    if (errors['name'] != null) {
      _showError(errors['name']!);
      return;
    }

    if (errors['email'] != null) {
      _showError(errors['email']!);
      return;
    }

    if (errors['gender'] != null) {
      _showError(errors['gender']!);
      return;
    }

    if (_selectedGender == null) {
      _showError(AuthStrings.genderSelectError);
      return;
    }

    _authCubit.completeProfile(
      phoneNumber: widget.phoneNumber,
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      gender: _selectedGender!,
      address: _addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim(),
      bio: _bioCtrl.text.trim().isEmpty ? null : _bioCtrl.text.trim(),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorRed,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.greenPrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          AuthStrings.completeProfileTitle,
          style: AppText.ibmHeading22(color: AppColors.dark),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.dark),
      ),
      body: BlocListener<AuthCubitV2, AuthState>(
        listenWhen: (previous, current) =>
            current is AuthAuthenticated ||
            current is AuthErrorState,
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            _showSuccess(AuthStrings.profileCompletionSuccess);
            // Navigate to home (update with your actual home route)
            context.go('/');
          } else if (state is AuthErrorState) {
            _showError(state.message);
          }
        },
        child: BlocBuilder<AuthCubitV2, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoadingState;

            return SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),
                  _buildTitle(context),
                  SizedBox(height: 8.h),
                  _buildSubtitle(context),
                  SizedBox(height: 32.h),
                  ProfileNameField(
                    controller: _nameCtrl,
                    onChanged: () => setState(() {}),
                  ),
                  SizedBox(height: 16.h),
                  ProfileEmailField(
                    controller: _emailCtrl,
                    onChanged: () => setState(() {}),
                  ),
                  SizedBox(height: 16.h),
                  ProfileGenderDropdown(
                    selectedGender: _selectedGender,
                    genderOptions: _genderOptions,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.h),
                  ProfileAddressField(
                    controller: _addressCtrl,
                  ),
                  SizedBox(height: 16.h),
                  _buildBioField(),
                  SizedBox(height: 32.h),
                  AuthPrimaryButton(
                    label: AuthStrings.completeRegistration,
                    isLoading: isLoading,
                    isEnabled: _isFormValid(),
                    onPressed: _handleCompleteProfile,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      AuthStrings.completeProfileTitle,
      style: AppText.ibmHeading22(color: AppColors.dark).copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      AuthStrings.completeProfileSubtitle,
      style: AppText.ibmDescription14(color: AppColors.secondaryText),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBioField() {
    return TextFormField(
      controller: _bioCtrl,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      maxLength: 150,
      style: AppText.ibmDescription14(color: AppColors.primaryText),
      decoration: InputDecoration(
        labelText: AuthStrings.bioLabel,
        labelStyle: AppText.ibmFieldLabel14(color: AppColors.dark),
        hintText: AuthStrings.bioHint,
        hintStyle: AppText.ibmPlaceholder14(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.borderInputs, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.greenPrimary, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.white,
      ),
    );
  }
}
