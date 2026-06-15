import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;

  const AppLogo({
    super.key,
    this.size = 120,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: Size(size, size),
          painter: _LogoPainter(),
        ),
        if (showText) ...[
          const SizedBox(height: 12),
          Text(
            'Group',
            style: GoogleFonts.cinzel(
              color: AppColors.primaryText,
              fontSize: (size * 0.22),
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ],
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Paints
    final Paint darkPaint = Paint()
      ..color = AppColors.dark
      ..strokeWidth = w * 0.07
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Paint fillPaint = Paint()
      ..color = AppColors.greenPrimary
      ..strokeWidth = w * 0.05
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw the surrounding hexagon/shield
    final Path hexPath = Path();
    hexPath.moveTo(w * 0.5, h * 0.05); // Top center
    hexPath.lineTo(w * 0.88, h * 0.25); // Top right
    hexPath.lineTo(w * 0.88, h * 0.75); // Bottom right
    hexPath.lineTo(w * 0.5, h * 0.95); // Bottom center
    hexPath.lineTo(w * 0.12, h * 0.75); // Bottom left
    hexPath.lineTo(w * 0.12, h * 0.25); // Top left
    hexPath.close();

    canvas.drawPath(hexPath, darkPaint);

    // Draw stylized letter M (Left side)
    final Path mPath = Path();
    mPath.moveTo(w * 0.23, h * 0.65);
    mPath.lineTo(w * 0.23, h * 0.35);
    mPath.lineTo(w * 0.38, h * 0.55);
    mPath.lineTo(w * 0.44, h * 0.47);
    canvas.drawPath(mPath, darkPaint);

    // Draw stylized letter G (Right side)
    final Path gPath = Path();
    gPath.moveTo(w * 0.77, h * 0.4);
    gPath.lineTo(w * 0.77, h * 0.35);
    gPath.lineTo(w * 0.58, h * 0.35);
    gPath.lineTo(w * 0.58, h * 0.65);
    gPath.lineTo(w * 0.77, h * 0.65);
    gPath.lineTo(w * 0.77, h * 0.52);
    gPath.lineTo(w * 0.68, h * 0.52);
    canvas.drawPath(gPath, darkPaint);

    // Draw stylized letter I (Center - Bright Cyan)
    final Path iPath = Path();
    iPath.moveTo(w * 0.5, h * 0.3);
    iPath.lineTo(w * 0.5, h * 0.7);
    canvas.drawPath(iPath, fillPaint);

    // I dot or top/bottom crossbars
    canvas.drawCircle(Offset(w * 0.5, h * 0.23), w * 0.035, Paint()..color = AppColors.greenPrimary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
