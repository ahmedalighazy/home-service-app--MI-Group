import 'package:flutter/material.dart';

class DiscountBadge extends StatelessWidget {
  final String text;

  const DiscountBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xffDDF3F7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: Color(0xff198DA3),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

