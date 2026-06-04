import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/constants/app_sizes.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/text/app_text.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/core/widgets/custom_app_bar.dart';
import 'package:home_service_app/features/profile/data/models/address_model.dart';
import 'package:home_service_app/features/profile/presentation/widgets/add_address_dashed_button.dart';
import 'package:home_service_app/features/profile/presentation/widgets/address_card_widget.dart';

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
      iconPath: IconsPath.house,
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
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: const CustomAppBar(title: 'العناوين'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingM.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
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
                  onDelete: () {},
                );
              },
            ),
            verticalSpace(24),
            AddAddressDashedButton(
              label: 'اضافة عنوان جديد',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
