import 'package:flutter/material.dart';

import '../../features/profile/presentation/widgets/arrow_back.dart';
import '../themes/colors/app_colors.dart';
import '../themes/text/app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.onBack,
    this.bottom,
    this.backgroundColor,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget? actions;
  final VoidCallback? onBack;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: backgroundColor ?? AppColors.white,
      leading: ArrowBack(onTap: onBack),
      title:
          titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: AppText.boldIbm(color: AppColors.black, fontSize: 18),
                )
              : null),
      actions: [actions ?? const SizedBox.shrink()],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
