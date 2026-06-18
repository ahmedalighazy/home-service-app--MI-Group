import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../data/repositories/booking_repository.dart';
import '../widgets/booking_card.dart';
import '../../logic/cubit/booking_cubit.dart';
import '../../logic/cubit/booking_state.dart';

import '../../../../core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => BookingCubit(BookingRepository())..fetchBookings(),
        child: BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            if (state is BookingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BookingSuccess) {
              return const _BookingContent();
            } else if (state is BookingError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _BookingContent extends StatelessWidget {
  const _BookingContent();

  @override
  Widget build(BuildContext context) {
    final bookings =
        (context.read<BookingCubit>().state as BookingSuccess).bookings;

    return DefaultTabController(
      length: 2,
      child: SizedBox(
        height: height(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              child: Row(
                children: [
                  Text(
                    AppStrings.navBookings,
                    style: AppText.boldIbm(
                      color: AppColors.black,
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    IconsPath.notificationNew,
                    width: 23.w,
                    height: 23.h,
                  ),
                ],
              ),
            ),
            verticalSpace(10),
            TabBar(
              labelStyle: AppText.ibmHeading14(),
              unselectedLabelStyle: AppText.ibmDescription14(),
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.primaryText,
              indicatorColor: AppColors.primary,

              // automaticIndicatorColorAdjustment: false,
              indicatorSize: TabBarIndicatorSize.tab, // dividerHeight: 59,
              tabs: const [
                Tab(text: AppStrings.currentSubscriptions),
                Tab(text: AppStrings.previousSubscriptions),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  bookings.isNotEmpty
                      ? ListView.builder(
                          itemCount: bookings.length,
                          itemBuilder: (context, index) => BookingCard(
                            booking: bookings[index],
                            onViewDetails: () => context.push(
                              AppRouter.bookingDetails,
                              extra: bookings[index],
                            ),
                          ),
                        )
                      : EmptyStateWidget(
                          isscreenBooking: true,
                          iconPath: IconsPath.notBooking,
                          title: AppStrings.noUpcomingBookings,
                          subtitle: AppStrings.noUpcomingBookingsDescription,
                          onButtonPressed: () {},
                          buttonLabel: AppStrings.bookNow,
                        ),

                  bookings.isEmpty
                      ? ListView.builder(
                          itemCount: bookings.length,
                          itemBuilder: (context, index) => BookingCard(
                            booking: bookings[index],
                            onViewDetails: () => context.push(
                              AppRouter.bookingDetails,
                              extra: bookings[index],
                            ),
                          ),
                        )
                      : EmptyStateWidget(
                          isscreenBooking: true,

                          iconPath: IconsPath.notBooking,
                          title: AppStrings.noUpcomingBookings,
                          subtitle: AppStrings.noUpcomingBookingsDescription,
                          onButtonPressed: () {},
                          buttonLabel: AppStrings.bookNow,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
