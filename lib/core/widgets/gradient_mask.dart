import 'package:flutter/material.dart';

class GradientMask extends StatelessWidget {
  const GradientMask({super.key, required this.child, required this.gradient});
  final List<Color> gradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: gradient,

        ).createShader(bounds);
      },
      child: child,
    );
  }
}
