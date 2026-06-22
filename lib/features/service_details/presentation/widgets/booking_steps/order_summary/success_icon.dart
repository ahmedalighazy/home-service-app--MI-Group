import 'package:flutter/material.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xffEAFBF1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Icon(
        Icons.check_circle_outline_rounded,
        color: Color(0xff09884B),
        size: 34,
      ),
    );
  }
}
