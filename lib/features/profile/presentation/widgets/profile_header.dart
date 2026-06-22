import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/features/home/presentation/widgets/notification_bell.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart';

import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/buttom_curve_clipper.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final unreadCount = context
        .watch<NotificationCubit>()
        .state
        .notifications
        .where((notification) => !notification.isRead)
        .length;
    return Column(
      children: [
        ClipPath(
          clipper: BottomCurveClipper(),
          child: Container(
            height:
                height(context) * 0.28,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.greenPrimary, AppColors.white],
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.h, left: 20, right: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      context.tr(LocaleKeys.profileAccount),
                      textAlign: TextAlign.center,
                      style: AppText.semiBoldIbm(
                        color: AppColors.headingText,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),

                    NotificationBell(
                      onTap: () => context.push(AppRouter.notification),
                      count: unreadCount,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
