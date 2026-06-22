import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/empty_state_widget.dart';
import 'package:home_service_app/features/booking/logic/cubit/booking_state.dart';
import 'package:home_service_app/features/booking/logic/cubit/booking_cubit.dart';
import 'package:home_service_app/features/booking/presentation/widgets/booking_card.dart';
import 'package:home_service_app/features/booking/presentation/screens/widgets/booking_tabs_header.dart';
import 'package:home_service_app/features/booking/presentation/screens/widgets/booking_tab_bar.dart';
import 'package:home_service_app/core/routes/app_routes.dart';

class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state is BookingLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BookingError) {
          return Center(child: Text(state.message));
        }

        if (state is BookingSuccess) {
          return _BookingLoaded(bookings: state.bookings);
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _BookingLoaded extends StatelessWidget {
  final List bookings;

  const _BookingLoaded({required this.bookings});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const BookingTabsHeader(),
          verticalSpace(10),
          const BookingTabBar(),
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
                        title: AppStrings.notFindbooking,
                        subtitle: AppStrings.bookdesc,
                        onButtonPressed: () => context.go(AppRouter.home),
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
                        title: AppStrings.notFindbooking,
                        subtitle: AppStrings.bookdesc,
                        onButtonPressed: () => context.go(AppRouter.home),
                        buttonLabel: AppStrings.bookNow,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
