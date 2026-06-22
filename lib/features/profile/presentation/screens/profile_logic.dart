import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';

mixin ProfileLogic<T extends StatefulWidget> on State<T> {
  void onEditProfileTap(BuildContext context) {
    context.push(AppRouter.editProfile);
  }

  void onFavoritesTap(BuildContext context) {
    context.push(AppRouter.favorites);
  }

  void onSavedAddressesTap(BuildContext context) {
    context.push(AppRouter.savedAddresses);
  }

  void onSubscriptionsTap(BuildContext context) {
    context.push(AppRouter.subscriptions);
  }

  void onPaymentMethodsTap(BuildContext context) {
    context.push(AppRouter.paymentMethods);
  }

  void onSettingsTap(BuildContext context) {
    context.push(AppRouter.setting);
  }

  void onContactUsTap(BuildContext context) {
    context.push(AppRouter.contactUs);
  }
}
