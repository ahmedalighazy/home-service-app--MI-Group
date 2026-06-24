import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/language/language_cubit.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';

import '../../../../../core/themes/colors/app_colors.dart';

class BookingFlowAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const BookingFlowAppBar({super.key, required this.title, this.onBack});

  @override
  Size get preferredSize => const Size.fromHeight(86);

  @override
  Widget build(BuildContext context) {
    final isArabic = context.select(
      (LanguageCubit cubit) => cubit.state.isArabic,
    );

    return Container(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xffF2F2F2), width: 1),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                title,
                style: AppText.semiBold18Black.copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: InkWell(
                  onTap: onBack,
                  borderRadius: BorderRadius.circular(19),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Icon(
                      isArabic
                          ? Icons.arrow_forward_rounded
                          : Icons.arrow_back_rounded,
                      size: 22,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
