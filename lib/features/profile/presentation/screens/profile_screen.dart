import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../setting/presentation/widgets/setting_list_item.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/setting_group_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                            onTap: () {
                              context.pushNamed(AppRouter.editProfile);
                            },
                          ),
                          SettingListItem(
                            icon: IconsPath.vectorFavorite,
                            title: AppStrings.favorites,
                            onTap: () {
                              context.pushNamed(AppRouter.favorites);
                            },
                          ),
                          SettingListItem(
                            icon: IconsPath.vectorLocation,
                            title: AppStrings.myAddresses,
                            onTap: () {
                              context.pushNamed(AppRouter.savedAddresses);
                            },
                          ),
                          SettingListItem(
                            icon: IconsPath.vectorSub,
                            title: AppStrings.mySubscriptions,
                            onTap: () {
                              context.pushNamed(AppRouter.subscriptions);
                            },
                          ),
                          SettingListItem(
                            icon: IconsPath.group,
                            title: AppStrings.paymentMethods,
                            onTap: () {
                              context.pushNamed(AppRouter.paymentMethods);
                            },
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
                            onTap: () {
                              context.pushNamed(AppRouter.setting);
                            },
                          ),
                          SettingListItem(
                            icon: IconsPath.iconLang,
                            title: AppStrings.contactUs,
                            onTap: () {
                              context.pushNamed(AppRouter.contactUs);
                            },
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
    );
  }
}
