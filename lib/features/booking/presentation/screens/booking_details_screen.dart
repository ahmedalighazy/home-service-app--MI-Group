import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import '../widgets/booking_details_header.dart';
import '../widgets/booking_details_row.dart';
import '../../data/models/booking_model.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/constants/icons_path.dart';
import '../../../../core/utils/helpers/spacing.dart';

import '../widgets/popup_menu_button.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookingModel booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.tr(LocaleKeys.bookingDetails),
        actions: CustomPopupMenuBooking(onSelected: (MenuAction value) {}),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.r),
          margin: EdgeInsets.all(16.r),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFE5E7EB) /* border-inputs */,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Column(
            children: [
              BookingDetailsHeader(
                serviceName: booking.serviceName,
                status: booking.status,
                imageUrl: booking.imageUrl,
              ),
              verticalSpace(8),
              const Divider(height: 1),
              verticalSpace(16),
              _DetailsCard(booking: booking),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final BookingModel booking;
  const _DetailsCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BookingDetailsRow(
            value2: booking.time,
            label: context.tr(LocaleKeys.bookingDateAndTime),
            value: booking.date,
            icon: IconsPath.calendar,
            icon2: IconsPath.time,
          ),
          const Divider(height: 1),
          BookingDetailsRow(
            label: context.tr(LocaleKeys.bookingAddress),
            value: booking.address,
            icon: IconsPath.location,
          ),
          BookingDetailsRow(
            label: context.tr(LocaleKeys.bookingRating),
            value: booking.notes ?? "",
            icon: IconsPath.editGry,
          ),
          const Divider(height: 1),
          BookingDetailsRow(
            label: context.tr(LocaleKeys.bookingPaid),
            value: booking.paymentMethod ?? 'N/A',
            icon: IconsPath.paid,
          ),
          const Divider(height: 1),
          BookingDetailsRow(
            label: context.tr(LocaleKeys.bookingNumber),
            value: booking.id,
            icon: IconsPath.enlargement,
          ),
          const Divider(height: 1),
          BookingDetailsRow(
            label: context.tr(LocaleKeys.bookingTotalPrice),
            value: booking.price,
            icon: IconsPath.group,
          ),
        ],
      ),
    );
  }
}
