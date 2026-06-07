import 'package:flutter/material.dart';

import '../../../../../../core/themes/text/app_text.dart';

class SectionLabel extends StatelessWidget {
  final String label;

  const SectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.012,
      ),
      child: Text(
        label,
        style: AppText.semiBold16Black,
        textAlign: TextAlign.end,
      ),
    );
  }
}

