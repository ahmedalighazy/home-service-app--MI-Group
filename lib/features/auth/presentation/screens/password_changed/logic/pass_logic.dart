import 'package:flutter/material.dart';
import 'package:home_service_app/core/routes/app_routes.dart';

class PasswordChangedLogic {
  void onSignInPressed(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.signIn,
          (route) => false,
    );
  }
}