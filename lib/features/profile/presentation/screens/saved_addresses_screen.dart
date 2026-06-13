import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/features/address/presentation/widgets/custom_add_buttom_sheet.dart';
import 'package:home_service_app/features/profile/data/models/address_model.dart';

import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/themes/text/app_text.dart';
import '../../../../core/utils/helpers/show_dialog.dart';
import '../../../../core/utils/helpers/spacing.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../widgets/add_address_dashed_button.dart';
import '../widgets/address_card_widget.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  final List<AddressModel> _addresses = [
    AddressModel(
      id: '1',
      label: 'المنزل',
      details: 'شارع اللؤلؤة، فيلا رقم 42، الدوحة، قطر',
      isDefault: true,
      iconPath: IconsPath.iconHome,
    ),
    AddressModel(
      id: '2',
      label: 'العمل',
      details: 'برج المرقاب . الطابق الثامن',
      isDefault: false,
      iconPath: IconsPath.work,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'العناوين'),
      body: _addresses.isEmpty
          ? EmptyStateWidget(
              iconPath: IconsPath.union,
              title: 'لا توجد عناوين أخرى',
              subtitle: 'أضف عناوينك المفضلة للوصول السريع إليها أثناء الحجز.',
              buttonLabel: "اضافة عنوان",
              onButtonPressed: () {},
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.paddingM.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(16),

                  Text(
                    'عناويني المحفوظة',
                    style: AppText.ibmHeading16(color: AppColors.black),
                  ),
                  verticalSpace(16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _addresses.length,
                    separatorBuilder: (_, _) => verticalSpace(12),
                    itemBuilder: (context, index) {
                      return AddressCardWidget(
                        address: _addresses[index],
                        onEdit: () {},
                        onDelete: () {
                          showCannotDeleteDialogred(
                            context,
                            "حذف العنوان",
                            "هل أنت متأكد أنك تريد حذف هذا العنوان؟",
                          );
                        },
                      );
                    },
                  ),
                  verticalSpace(24),
                  CustomAddButtomSheet(isProfileScreen: true),
                  // AddAddressDashedButton(
                  //   label: 'اضافة عنوان جديد',
                  //   onTap: () {},
                  // ),
                ],
              ),
            ),
    );
  }
}
