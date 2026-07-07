import 'package:flutter/material.dart';

import 'package:home_service_app/core/themes/colors/app_colors.dart';

import 'package:home_service_app/features/auth/presentation/widgets/sign_up_app_bar.dart';
import 'sign_up_body.dart';

class SignUpScaffold extends StatelessWidget {
  const SignUpScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const SignUpAppBar(),
      body: SafeArea(child: SignUpBody()),
    );
  }
}
