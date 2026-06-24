// import 'package:flutter/material.dart';
// import 'package:home_service_app/core/widgets/custom_bottom_navigation_bar.dart';
// import 'package:home_service_app/features/home/presentation/pages/home_cotent.dart';

// import '../../../booking/presentation/screens/booking_screen.dart';
// import '../../../profile/presentation/screens/profile_screen.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: const [
//           HomeContent(),
//           BookingScreen(),
//           ProfileScreen(),
//         ],
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
