import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/booking_tracking/star_rating.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class RatingInputCard extends StatelessWidget {
  final String title;
  final String question;
  final int rating;
  final TextEditingController controller;
  final ValueChanged<int> onRatingChanged;
  final ValueChanged<String>? onCommentChanged;

  const RatingInputCard({
    super.key,
    required this.title,
    required this.question,
    required this.rating,
    required this.controller,
    required this.onRatingChanged,
    this.onCommentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffEAFBFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffD7F3F8)),
      ),
      child: Column(
        children: [
          Text(title, style: AppText.semiBold14Black),
          const SizedBox(height: 8),
          Text(
            question,
            textAlign: TextAlign.center,
            style: AppText.regular12Grey.copyWith(height: 1.3),
          ),
          const SizedBox(height: 8),
          StarRating(value: rating, onChanged: onRatingChanged),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            onChanged: onCommentChanged,
            minLines: 3,
            maxLines: 3,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: SdStrings.addHere,
              hintStyle: AppText.regular12Grey,
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.all(12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
