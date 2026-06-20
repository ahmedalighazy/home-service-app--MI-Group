import 'package:flutter/material.dart';
import 'package:home_service_app/core/constants/icons_path.dart';
import 'package:home_service_app/core/extensions/context_extensions.dart';
import 'package:home_service_app/core/routes/navigation_extensions.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
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
                            title: context.l10n.editProfile,
                            onTap: () {
                              context.pushNamed(AppRouter.editProfile);
                            },
                          ),
                          SettingListItem(
                            icon: IconsPath.vectorFavorite,
                            title: context.l10n.favorites,
                            onTap: () {
                              context.pushNamed(AppRouter.favorites);
                            },
                          ),
                          SettingListItem(
                            icon: IconsPath.vectorLocation,
                            title: context.l10n.myAddresses,
                            onTap: () {
                              context.pushNamed(AppRouter.savedAddresses);
                            },
                          ),
                          SettingListItem(
                            icon: IconsPath.vectorSub,
                            title: context.l10n.mySubscriptions,
                            onTap: () {
                              context.pushNamed(AppRouter.subscriptions);
                            },
                          ),
                          SettingListItem(
                            icon: IconsPath.group,
                            title: context.l10n.paymentMethods,
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
                            title: context.l10n.settings,
                            onTap: () {
                              context.pushNamed(AppRouter.setting);
                            },
                          ),
                          SettingListItem(
                            icon: IconsPath.iconLang,
                            title: context.l10n.contactUs,
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
