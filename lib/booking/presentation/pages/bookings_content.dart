import 'package:flutter/material.dart';

class BookingsContent extends StatelessWidget {
  const BookingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'حجوزاتي',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
