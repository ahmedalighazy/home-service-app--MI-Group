import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: AppColors.whitecancel);
  }
}
