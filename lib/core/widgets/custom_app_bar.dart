import 'package:flutter/material.dart';

import '../../features/profile/presentation/widgets/arrow_back.dart';
import '../themes/colors/app_colors.dart';
import '../themes/text/app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,

      backgroundColor: AppColors.white,
      leading: const ArrowBack(),
      title: Text(
        title,
        style: AppText.boldIbm(color: AppColors.black, fontSize: 18),
      ),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // ✅ Required override
}
