import 'package:flutter/material.dart';

import '../../../../../../core/themes/colors/app_colors.dart';

class CardBrandLogo extends StatelessWidget {
  final String brand;

  const CardBrandLogo({super.key, required this.brand});

  static const Map<String, Color> _brandColors = {
    'VISA': Color(0xff1A1F71),
    'MC': Color(0xffEB001B),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _brandColors[brand] ?? AppColors.body,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        brand,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

