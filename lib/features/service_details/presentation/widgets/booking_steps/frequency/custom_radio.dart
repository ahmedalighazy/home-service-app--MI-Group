import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final bool isSelected;

  const CustomRadio({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff00A6C8);

    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: primaryColor, width: 1.7),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}
