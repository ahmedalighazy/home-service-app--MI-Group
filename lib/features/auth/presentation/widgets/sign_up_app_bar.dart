import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/widgets/language_toggle.dart';
import 'auth_back_button.dart';

class SignUpAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  const SignUpAppBar({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? Padding(
              padding: EdgeInsets.all(8.w),
              child: AuthBackButton(onTap: () => GoRouter.of(context).pop()),
            )
          : null,
      actions: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: const LanguageToggle(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
