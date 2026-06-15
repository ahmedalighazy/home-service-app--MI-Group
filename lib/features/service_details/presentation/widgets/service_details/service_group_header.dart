import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class ServiceGroupHeader extends StatelessWidget {
  final String title;

  const ServiceGroupHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.012,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Text(title, style: AppText.semiBold18Black)],
      ),
    );
  }
}
