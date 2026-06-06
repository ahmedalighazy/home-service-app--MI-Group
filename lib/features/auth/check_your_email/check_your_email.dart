import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';

class CheckYourEmail extends StatelessWidget {
  const CheckYourEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
      ),
        body: Container(
          padding:EdgeInsets.symmetric(horizontal:20,vertical: 10 ) ,),
    );
  }
}
