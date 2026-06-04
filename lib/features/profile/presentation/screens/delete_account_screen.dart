import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/show_dialog.dart';
import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../widgets/arrow_back.dart';
import '../widgets/custom_buttom.dart';
import '../widgets/custom_widget_delete.dart';
import '../widgets/delete_rule_item.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _confirmController = TextEditingController();
  bool isTextCorrect = false;

  @override
  void initState() {
    super.initState();
    _confirmController.addListener(() {
      setState(() {
        isTextCorrect = _confirmController.text == AppStrings.deleteConfirmWord;
      });
    });
  }

  @override
  dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: const ArrowBack(),

          title: Text(
            AppStrings.deleteAccountHeader,
            style: AppText.boldIbm(color: AppColors.black, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        // width: 34,
                        // height: 34,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: AppColors.redDangerBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(44),
                          ),
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: AppColors.redDanger,
                        ),
                      ),

                      horizontalSpace(12.w),

                      // SvgPicture.asset(IconsPath.delete, width: 24, height: 24),
                      Text(
                        AppStrings.deleteWarningTitle,
                        style: AppText.boldIbm(
                          color: AppColors.primaryText,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 8.h),
                  Padding(
                    padding: const EdgeInsets.only(right: 34),
                    child: Text(
                      AppStrings.deleteWarningDesc,
                      style: AppText.regularIbm(
                        color: AppColors.textDarkGrey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              Container(
                decoration: ShapeDecoration(
                  color: AppColors.bgDisabled.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Column(
                  children: [
                    DeleteRuleItem(
                      icon: Icons.warning_amber_rounded,
                      title: AppStrings.rule1Title,
                      description: AppStrings.rule1Desc,
                    ),
                    DeleteRuleItem(
                      icon: Icons.calendar_today_outlined,
                      title: AppStrings.rule2Title,
                      description: AppStrings.rule2Desc,
                    ),
                    DeleteRuleItem(
                      icon: Icons.autorenew_rounded,
                      title: AppStrings.rule3Title,
                      description: AppStrings.rule3Desc,
                    ),
                    DeleteRuleItem(
                      icon: Icons.gavel_rounded,
                      title: AppStrings.rule4Title,
                      description: AppStrings.rule4Desc,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              const CustomWidgetDelete(),
              // Text(
              //   AppStrings.confirmDeleteHint,
              //   style: AppText.mediumIbm(color: AppColors.textDarkGrey, fontSize: 14),
              // ),
              SizedBox(height: 8.h),
              CustomTextField(
                centerText: true,
                controller: _confirmController,
                hintText: AppStrings.confirmDeleteHint,
                fillColor: AppColors.white,
                borderColor:
                    _confirmController.text.isNotEmpty && !isTextCorrect
                    ? AppColors.redBorder
                    : AppColors.borderGrey,
              ),
              if (_confirmController.text.isNotEmpty && !isTextCorrect) ...[
                SizedBox(height: 4.h),
                Text(
                  AppStrings.confirmFieldHint,
                  style: AppText.regularIbm(
                    color: AppColors.redDanger,
                    fontSize: 12,
                  ),
                ),
              ],
              SizedBox(height: 32.h),
              CustomButton(
                flex: 44,
                text: AppStrings.deleteConfirmBtn,
                backgroundColor: isTextCorrect
                    ? AppColors.redDanger
                    : AppColors.red,
                textColor: AppColors.white,
                onPressed: isTextCorrect
                    ? () {
                        // تنفيذ الحذف أو إظهار الـ Pop-up إذا كانت هناك طلبات معلقة
                        showCannotDeleteDialog(context);
                      }
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
      ),
    );
  }
}
