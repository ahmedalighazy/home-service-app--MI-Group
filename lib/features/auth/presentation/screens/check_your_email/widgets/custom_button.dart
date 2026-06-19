import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? const Color(0xFF1B85A6)
              : const Color(0xFFEFF3F8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isEnabled
                ? Colors.white
                : const Color(0xFF90A4AE).withValues(alpha: 0.6),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
