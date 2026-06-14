import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/widgets/language_toggle.dart';

class SignUpAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignUpAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
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
