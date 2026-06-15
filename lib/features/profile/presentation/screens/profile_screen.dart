import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../setting/presentation/widgets/setting_list_item.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/setting_group_widget.dart';
import 'profile_logic.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with ProfileLogic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: height(context),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const ProfileHeader(),
                  Positioned(
                    top: height(context) * 0.17,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ProfileCard(),
                        verticalSpace(10),
                        SettingGroupWidget(
                          items: [
                            SettingListItem(
                              icon: IconsPath.vectorPerson,
                              title: AppStrings.editProfile,
                              onTap: () => onEditProfileTap(context),
                            ),
                            SettingListItem(
                              icon: IconsPath.vectorFavorite,
                              title: AppStrings.favorites,
                              onTap: () => onFavoritesTap(context),
                            ),
                            SettingListItem(
                              icon: IconsPath.vectorLocation,
                              title: AppStrings.myAddresses,
                              onTap: () => onSavedAddressesTap(context),
                            ),
                            SettingListItem(
                              icon: IconsPath.vectorSub,
                              title: AppStrings.mySubscriptions,
                              onTap: () => onSubscriptionsTap(context),
                            ),
                            SettingListItem(
                              icon: IconsPath.group,
                              title: AppStrings.paymentMethods,
                              onTap: () => onPaymentMethodsTap(context),
                            ),
                          ],
                        ),
                        verticalSpace(7),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            color: AppColors.borderGrey,
                            thickness: 1,
                          ),
                        ),
                        verticalSpace(7),
                        SettingGroupWidget(
                          items: [
                            SettingListItem(
                              icon: IconsPath.vectorSetting,
                              title: AppStrings.settings,
                              onTap: () => onSettingsTap(context),
                            ),
                            SettingListItem(
                              icon: IconsPath.iconLang,
                              title: AppStrings.contactUs,
                              onTap: () => onContactUsTap(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
