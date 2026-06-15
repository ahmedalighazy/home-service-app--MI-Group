import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';

class PasswordChangedLogic {
  void onSignInPressed(BuildContext context) {
    // Navigate to sign-in screen so the user can log in with the new password
    GoRouter.of(context).go(AppRouter.signIn);
  }
}
