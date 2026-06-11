import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/auth_strings.dart';

class ProfileGenderDropdown extends StatelessWidget {
  final String? selectedGender;
  final List<String> genderOptions;
  final ValueChanged<String?> onChanged;

  const ProfileGenderDropdown({
    super.key,
    required this.selectedGender,
    required this.genderOptions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedGender,
      hint: Text(AuthStrings.genderPlaceholder),
      items: genderOptions
          .map(
            (gender) => DropdownMenuItem(
              value: gender,
              child: Text(gender),
            ),
          )
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: AuthStrings.genderLabel,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
