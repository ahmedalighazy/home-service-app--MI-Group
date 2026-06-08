import 'package:flutter/material.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class ServiceItemAddButton extends StatelessWidget {
  final VoidCallback onTap;

  const ServiceItemAddButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final buttonSize = MediaQuery.of(context).size.width * 0.09;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add, color: AppColors.white, size: 22),
      ),
    );
  }
}

