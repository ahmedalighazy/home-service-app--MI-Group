import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/language/language_cubit.dart';
import 'package:home_service_app/core/widgets/auth_back_button.dart';
import 'package:home_service_app/core/widgets/language_toggle.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final VoidCallback? onBackTap;

  const AuthAppBar({
    Key? key,
    this.showBackButton = true,
    this.onBackTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      bloc: getIt<LanguageCubit>(),
      builder: (context, state) {
        final isArabic = state.isArabic;

        final backButtonWidget = showBackButton
            ? Padding(
                padding: EdgeInsets.all(8.w),
                child: AuthBackButton(
                  onTap: onBackTap ?? () {
                    Navigator.of(context).maybePop();
                  },
                ),
              )
            : null;

        const languageToggleWidget = LanguageToggle();

        return AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leadingWidth: 80.w,
          leading: isArabic ? backButtonWidget : languageToggleWidget,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Center(
                child: isArabic ? languageToggleWidget : backButtonWidget,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
