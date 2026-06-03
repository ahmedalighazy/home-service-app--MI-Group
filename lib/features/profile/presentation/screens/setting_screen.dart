import 'package:flutter/material.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../widgets/arrow_back.dart';
import '../widgets/setting_list_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,

        title: Text(
          AppStrings.settings,
          textAlign: TextAlign.center,
          style: AppText.ibmHeading20(color: AppColors.headingText),
        ),
        leading: const ArrowBack(),
      ),
      body: Column(
        children: [
          SettingListItem(
            icon: Icons.notifications_outlined,
            title: AppStrings.changePassword,
            onTap: () {},
          ),
          const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
          SettingListItem(
            icon: Icons.lock_outline,
            title: AppStrings.privacy,
            onTap: () {},
          ),
          const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
          SettingListItem(
            icon: Icons.help_outline,
            title: AppStrings.help,
            onTap: () {},
          ),
          const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
        ],
      ),
    );
  }
}
