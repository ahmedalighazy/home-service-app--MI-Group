import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/auth/presentation/widgets/fade_slide_transition.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'complete_profile_form.dart';

class CompleteProfileScaffold extends StatelessWidget {
  final String? email;

  const CompleteProfileScaffold({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CustomBackArrowButton(
            onPressed: () => GoRouter.of(context).go(AppRouter.signUp),
          ),
        ),
      ),
      body: FadeSlideTransition(
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CompleteProfileForm(email: email),
          ),
        ),
      ),
    );
  }
}
