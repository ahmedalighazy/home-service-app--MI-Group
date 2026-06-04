import 'package:flutter/material.dart';

import '../../features/profile/presentation/widgets/arrow_back.dart';
import '../themes/colors/app_colors.dart';
import '../themes/text/app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.widget, this.onBack, this.bottom});
  final String title;
  final Widget? widget;
  final VoidCallback? onBack;
  final PreferredSizeWidget? bottom;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,

      backgroundColor: AppColors.white,
      leading: ArrowBack(onTap: onBack),

      title: Text(
        title,
        style: AppText.boldIbm(
          color: AppColors.black,
          fontSize: widget == null ? 18 : 13,
        ),
      ),
      // centerTitle: true,
      actions: [widget ?? const SizedBox.shrink()],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
