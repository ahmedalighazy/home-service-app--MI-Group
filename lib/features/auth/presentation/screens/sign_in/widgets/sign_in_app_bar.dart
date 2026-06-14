import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/themes/colors/app_colors.dart';
import '../../../../../../core/widgets/language_toggle.dart';

class SignInAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignInAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.dark,
        ),
        onPressed: () => context.pop(),
      ),
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
