import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:home_service_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:home_service_app/features/booking/presentation/screens/booking_screen.dart';
import 'package:home_service_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:home_service_app/features/home/presentation/pages/home_cotent.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:home_service_app/features/profile/presentation/screens/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _onTabChanged(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<HomeCubit>()..getHomeData(),
        ),
        BlocProvider(
          create: (_) => getIt<AddressCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<NotificationCubit>(),
        ),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeContent(key: ValueKey('Home-${context.locale.languageCode}')),
            BookingScreen(key: ValueKey('Booking-${context.locale.languageCode}')),
            ProfileScreen(key: ValueKey('Profile-${context.locale.languageCode}')),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabChanged,
        ),
      ),
    );
  }
}
