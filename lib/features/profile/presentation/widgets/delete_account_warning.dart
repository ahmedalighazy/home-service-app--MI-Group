import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

class DeleteAccountWarning extends StatelessWidget {
  const DeleteAccountWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: AppColors.redDangerBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44),
                ),
              ),
              child: SvgPicture.asset(IconsPath.delete),
            ),
            horizontalSpace(12),
            Text(
              context.l10n.deleteWarningTitle,
              style: AppText.boldIbm(
                color: AppColors.primaryText,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 34),
          child: Text(
            context.l10n.deleteWarningDesc,
            style: AppText.regularIbm(
              color: AppColors.textDarkGrey,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
