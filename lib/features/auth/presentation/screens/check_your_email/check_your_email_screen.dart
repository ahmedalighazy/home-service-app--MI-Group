import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/features/auth/presentation/screens/check_your_email/widgets/check_your_email_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:home_service_app/features/auth/presentation/states/auth_state.dart';
import '../../../../profile/presentation/widgets/custom_buttom.dart';
import 'logic/check_your_email_logic.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/features/auth/presentation/widgets/auth_back_button.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final String code;

  const VerificationScreen({
    Key? key,
    required this.email,
    required this.code,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late VerificationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VerificationController();
    if (widget.code.isNotEmpty && widget.code.length == 4) {
      for (int i = 0; i < 4; i++) {
        _controller.controllers[i].text = widget.code[i];
      }
    }
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listener: (context, state) => _controller.handleState(context, state, widget.email),
      builder: (context, state) {
        final isLoading = state is AuthLoadingState;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: EdgeInsets.all(8.w),
                child: AuthBackButton(onTap: () => GoRouter.of(context).pop()),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom -
                        kToolbarHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          verticalSpace(24.h),

                          CheckEmailHeader(email: widget.email),

                          verticalSpace(16.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(4, (index) {
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                                  child: OtpCircleField(
                                    controller: _controller.controllers[index],
                                    focusNode: _controller.focusNodes[index],
                                    onChanged: (value) => _controller.handleOtpChange(value, index),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 32),
                          verticalSpace(32.h),

                          CheckEmailResendRow(onResend: () => _controller.resendCode(context, widget.email)),

                          verticalSpace(36.h),

                          isLoading
                                 ? Center(child: CircularProgressIndicator(color: AppColors.greenPrimary))
                                 : CustomButton(
                                     backgroundColor: AppColors.greenPrimary,
                                     textColor: Colors.white,
                                     text: AppStrings.confirm ?? "تأكيد",
                                     onPressed: () => _controller.onConfirm(context, widget.email),
                                   ),
                          verticalSpace(24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}