import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class ServiceCoverIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const ServiceCoverIconButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = MediaQuery.of(context).size.width * 0.1;

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Material(
        color: AppColors.white,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Icon(icon, color: iconColor, size: 20),
        ),
      ),
    );
  }
}

