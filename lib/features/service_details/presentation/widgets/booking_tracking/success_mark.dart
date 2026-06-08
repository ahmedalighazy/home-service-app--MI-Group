import 'package:flutter/material.dart';

class SuccessMark extends StatelessWidget {
  final double size;

  const SuccessMark({super.key, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xffEAFBF1),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Icon(
        Icons.check_circle_outline_rounded,
        color: const Color(0xff09884B),
        size: size * 0.58,
      ),
    );
  }
}

