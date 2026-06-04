import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/show_dialog.dart';
import 'package:home_service_app/core/utils/l10n/app_strings.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/core/widgets/custom_text_field.dart';

import '../widgets/custom_buttom.dart';
import '../widgets/custom_widget_delete.dart';
import '../widgets/delete_account_warning.dart';
import '../widgets/delete_rules_list.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final _confirmController = TextEditingController();
  bool _isTextCorrect = false;

  @override
  void initState() {
    super.initState();
    _confirmController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(
      () => _isTextCorrect =
          _confirmController.text == AppStrings.deleteConfirmWord,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: const CustomAppBar(title: AppStrings.deleteAccountHeader),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DeleteAccountWarning(),
            SizedBox(height: 20.h),
            const DeleteRulesList(),
            SizedBox(height: 24.h),
            const CustomWidgetDelete(),
            SizedBox(height: 8.h),
            _ConfirmTextField(
              controller: _confirmController,
              isCorrect: _isTextCorrect,
            ),
            SizedBox(height: 32.h),
            CustomButton(
              flex: 44,
              text: AppStrings.deleteConfirmBtn,
              backgroundColor: _isTextCorrect
                  ? AppColors.redDanger
                  : AppColors.red,
              textColor: AppColors.white,
              onPressed: _isTextCorrect
                  ? () => showCannotDeleteDialog(context)
                  : () {},
            ),
            SizedBox(height: 12.h),
            CustomButton(
              text: AppStrings.cancelBtn,
              backgroundColor: AppColors.gray,
              textColor: AppColors.gray,
              isOutlined: true,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isCorrect;

  const _ConfirmTextField({required this.controller, required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    final hasError = controller.text.isNotEmpty && !isCorrect;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          centerText: true,
          controller: controller,
          hintText: AppStrings.confirmDeleteHint,
          fillColor: AppColors.white,
          borderColor: hasError ? AppColors.redBorder : AppColors.borderGrey,
        ),
        if (hasError) ...[
          SizedBox(height: 4.h),
          Text(
            AppStrings.confirmFieldHint,
            style: AppText.regularIbm(color: AppColors.redDanger, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
