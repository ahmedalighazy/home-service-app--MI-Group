import 'package:flutter/material.dart';
import 'package:home_service_app/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:home_service_app/features/booking/presentation/pages/bookings_content.dart';
import 'package:home_service_app/features/home/presentation/pages/home_cotent.dart';
import 'package:home_service_app/features/profile/screen/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const BookingsContent(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
