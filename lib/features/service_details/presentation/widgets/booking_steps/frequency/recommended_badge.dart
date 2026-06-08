import 'package:flutter/material.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';


class RecommendedBadge extends StatelessWidget {
  const RecommendedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xffFFB52E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        AppStrings.most,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}

