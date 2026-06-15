import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

class CorporateSectionLabel extends StatelessWidget {
  final String text;

  const CorporateSectionLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppText.semiBold14Black);
  }
}
