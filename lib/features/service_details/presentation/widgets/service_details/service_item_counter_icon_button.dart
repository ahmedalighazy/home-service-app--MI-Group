import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class ServiceItemCounterIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ServiceItemCounterIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: AppColors.white, size: 18),
    );
  }
}

