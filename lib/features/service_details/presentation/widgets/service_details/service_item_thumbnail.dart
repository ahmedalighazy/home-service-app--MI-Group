import 'package:flutter/material.dart';

class ServiceItemThumbnail extends StatelessWidget {
  final String image;

  const ServiceItemThumbnail({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size.width * 0.18;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        image,
        width: dimension,
        height: dimension,
        fit: BoxFit.cover,
      ),
    );
  }
}

