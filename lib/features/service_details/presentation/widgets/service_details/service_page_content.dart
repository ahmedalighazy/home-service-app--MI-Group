import 'package:flutter/material.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/promo_code_widget.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_details_bottom_sheet.dart';
import 'package:home_service_app/features/service_details/presentation/widgets/service_details/service_group_section.dart';

import '../../../../../core/themes/colors/app_colors.dart';
import '../../../data/models/service_page_model.dart';
import 'package:home_service_app/features/service_details/service_details_strings.dart';

class ServicePageContent extends StatelessWidget {
  final ServicePageModel data;
  final int selectedCategoryIndex;

  const ServicePageContent({
    super.key,
    required this.data,
    required this.selectedCategoryIndex,
  });

  ServicePageGroupModel? get _activeGroup {
    final inRange =
        selectedCategoryIndex >= 0 &&
        selectedCategoryIndex < data.serviceGroups.length;
    return inRange ? data.serviceGroups[selectedCategoryIndex] : null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final active = _activeGroup;
    final groups = active != null ? [active] : data.serviceGroups;

    return ColoredBox(
      color: AppColors.scaffoldBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.015,
            ),
            child: PromoCodeWidget(
              promoCode: data.promoCode,
              discount: data.promoDiscount,
            ),
          ),

          ...groups.map(
            (group) => Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.012),
              child: ServiceGroupSection(group: group),
            ),
          ),

          SizedBox(height: size.height * 0.01),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: GestureDetector(
              onTap: () {
                showServiceBottomSheet(context);
              },
              child: Text(SdStrings.showDetailsService, style: AppText.bold16Cyan),
            ),
          ),
        ],
      ),
    );
  }
}

void showServiceBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,

    backgroundColor: Colors.transparent,
    builder: (context) {
      return ServiceDetailsBottomSheet();
    },
  );
}
