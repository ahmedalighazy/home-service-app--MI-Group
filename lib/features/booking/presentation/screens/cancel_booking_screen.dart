import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import '../../../../core/utils/helpers/spacing.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../profile/presentation/widgets/custom_buttom.dart';
import '../widgets/custom_text_cancel_booking.dart';

class CancelBookingScreen extends StatelessWidget {
  const CancelBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.tr(LocaleKeys.bookingCancel)),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(40),

              _CancelIcon(),
              verticalSpace(24),
              _WarningSection(),
              verticalSpace(32),
              _ReasonField(),
              verticalSpace(40),

              _ActionButtons(context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class _CancelIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(44),
      decoration: ShapeDecoration(
        color: const Color(0xFFFEF2F2) /* bg-error */,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      child: SvgPicture.asset(
        IconsPath.delete,
        width: 50.w,
        height: 50.h,
        colorFilter: ColorFilter.mode(AppColors.redDanger, BlendMode.srcIn),
      ),
    );
  }
}

class _WarningSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.tr(LocaleKeys.bookingAreYouSureCancel),
          style: AppText.ibmHeading20(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        verticalSpace(8),
        Text(
          context.tr(LocaleKeys.bookingCancelWarning),
          style: AppText.ibmDescription14(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ReasonField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextCancelBooking(),
        verticalSpace(12),
        CustomTextField(
          hintText: context.tr(LocaleKeys.bookingMentionCancelReason),
          fillColor: AppColors.bgSecondary,
          borderColor: AppColors.borderGrey,
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final BuildContext context;
  const _ActionButtons({required this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CustomButton(
          flex: 44,
          text: context.tr(LocaleKeys.bookingConfirmCancel),
          backgroundColor: AppColors.red,

          textColor: AppColors.white,
          onPressed: () {},
        ),
        CustomButton(
          flex: 44,
          text: context.tr(LocaleKeys.bookingGoBack),
          backgroundColor: AppColors.white,

          textColor: AppColors.primaryGrey,
          onPressed: () {},
        ),
        verticalSpace(5),
      ],
    );
  }
}
