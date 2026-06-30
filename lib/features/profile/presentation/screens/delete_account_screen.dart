import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/utils/helpers/show_dialog.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/utils/l10n/locale_keys.dart';
import 'package:home_service_app/core/utils/l10n/localization_extension.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';

import '../cubit/profile_cubit.dart';
import '../widgets/custom_buttom.dart';
import '../widgets/custom_widget_delete.dart';
import '../widgets/delete_account_warning.dart';
import '../widgets/delete_confirm_text_field.dart';
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
          _confirmController.text.trim().toLowerCase() ==
          context.tr(LocaleKeys.profileDeleteConfirmWord).toLowerCase(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.tr(LocaleKeys.profileDeleteAccountHeader),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is DeleteAccountSuccess) {
              context.go(AppRouter.signUp);
            } else if (state is DeleteAccountError) {
              showCannotDeleteDialog(
                context,
                "خطأ",
                state.message,
              );
            }
          },
          builder: (context, state) {
            if (state is DeleteAccountLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DeleteAccountWarning(),
                  verticalSpace(20),
                  const DeleteRulesList(),
                  verticalSpace(24),
                  const CustomWidgetDelete(),
                  verticalSpace(8),
                  DeleteConfirmTextField(controller: _confirmController),
                  verticalSpace(32),
                  CustomButton(
                    text: context.tr(LocaleKeys.profileDeleteConfirmBtn),
                    backgroundColor: _isTextCorrect
                        ? AppColors.redDanger
                        : AppColors.borderGrey,
                    textColor: AppColors.white,
                    onPressed: _isTextCorrect
                        ? () => context.read<ProfileCubit>().deleteAccount()
                        : () {},
                  ),
                  verticalSpace(12),
                  CustomButton(
                    text: context.tr(LocaleKeys.profileDeleteCancelBtn),
                    backgroundColor: AppColors.white,
                    textColor: AppColors.primaryText,
                    isOutlined: true,
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
