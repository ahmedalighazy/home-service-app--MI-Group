import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/language/language_cubit.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/utils/helpers/cache_helper.dart';
import 'package:home_service_app/core/utils/helpers/show_dialog.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';

mixin SettingsLogic<T extends StatefulWidget> on State<T> {
  bool notificationsEnabled = true;

  void onNotificationsToggled(bool value) {
    setState(() => notificationsEnabled = value);

  }

  void onChangePasswordTap(BuildContext context) {
    context.push(AppRouter.updatePassword);
  }

  void onHelpCenterTap(BuildContext context) {
    context.push(AppRouter.helpCenter);
  }

  void onLegalAndPoliciesTap(BuildContext context) {
    context.push(AppRouter.legalAndPolicies);
  }

  void onLanguageTap(BuildContext context) {
    getIt<LanguageCubit>().toggleLanguage();
  }

  void onLogoutTap(BuildContext context) {
    showCannotDeleteDialogred(
      context,
      AppStrings.logout,
      AppStrings.logoutContent,
      AppStrings.logout,
      true,
    );
  }

  Future<void> performLogout(BuildContext context) async {
    await CacheHelper.removeData(key: 'email');
    if (!context.mounted) return;
    context.go(AppRouter.signIn);
  }
}
