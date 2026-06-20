import 'package:flutter/material.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import '../../../../../core/themes/colors/app_colors.dart';

class PromoApplyButton extends StatelessWidget {
  const PromoApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.009,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)),
        elevation: 0,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(context.l10n.applyCode, style: AppText.semiBold14White),
    );
  }
}
