import 'package:flutter/material.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_service.dart';
import 'package:home_service_app/core/widgets/custom_back_arrow_button.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key, required this.controller, this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Row(
        children: [
          CustomBackArrowButton(),

          SizedBox(width: AppSizes.spacingMedium),

          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                final bool hasText = value.text.isNotEmpty;

                return TextField(
                  controller: controller,
                  autofocus: true,
                  cursorColor: AppColors.borderFocus,
                  textInputAction: TextInputAction.search,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: context.tr(LocaleKeys.searchServiceOrProblem),

                    hintStyle: AppText.ibmDescription14(
                      color: AppColors.placeholder,
                    ),

                    prefixIcon: hasText
                        ? null
                        : const Icon(
                            Icons.search,
                            color: AppColors.placeholder,
                          ),

                    suffixIcon: hasText
                        ? IconButton(
                            onPressed: () {
                              controller.clear();
                              onChanged?.call('');
                            },
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.placeholder,
                            ),
                          )
                        : null,

                    enabledBorder: _buildBorder(
                      hasText ? AppColors.borderInputs : AppColors.borderFocus,
                    ),

                    focusedBorder: _buildBorder(
                      hasText ? AppColors.borderInputs : AppColors.borderFocus,
                    ),

                    border: _buildBorder(
                      hasText ? AppColors.borderInputs : AppColors.borderFocus,
                    ),

                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSizes.padding,
                      vertical: AppSizes.paddingMedium,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
      borderSide: BorderSide(color: color),
    );
  }
}
