import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/booking/data/models/booking_model.dart';
import 'package:home_service_app/core/routes/app_routes.dart';

mixin BookingLogic<T extends StatefulWidget> on State<T> {
  int bookingTabIndex = 0;

  void onTabChanged(int index) {
    setState(() => bookingTabIndex = index);
  }

  void onViewBookingDetails(BuildContext context, BookingModel booking) {
    context.push(AppRouter.bookingDetails, extra: booking);
  }

  void onRescheduleBooking(BuildContext context) {
    context.push(AppRouter.rescheduleBooking);
  }

  void onCancelBooking(BuildContext context) {
    context.push(AppRouter.cancelBooking);
  }

  void onBookNow(BuildContext context) {
    context.go(AppRouter.home);
  }
}
