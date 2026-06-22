import 'package:flutter/material.dart';

class FailureIcon extends StatelessWidget {
  const FailureIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xffFDECEC),
        borderRadius: BorderRadius.circular(35),
      ),
      child: const Icon(
        Icons.info_outline_rounded,
        color: Color(0xffD94A38),
        size: 36,
      ),
    );
  }
}
