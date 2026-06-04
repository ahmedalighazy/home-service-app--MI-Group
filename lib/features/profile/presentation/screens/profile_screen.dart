import 'package:flutter/material.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

import '../../../../core/extensions/extention_navigator.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/colors/app_colors.dart';
import '../../../../core/utils/l10n/app_strings.dart';
import '../../../setting/presentation/widgets/setting_list_item.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_header.dart';

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

                      _buildSettingGroup([
                        SettingListItem(
                          icon: Icons.account_circle_outlined,
                          title: AppStrings.editProfile,
                          onTap: () {
                            context.pushName(AppRoutes.editProfile);
                          },
                        ),
                        SettingListItem(
                          icon: Icons.favorite_border_outlined,
                          title: AppStrings.favorites,
                          onTap: () {
                            context.pushName(AppRoutes.favorites);
                          },
                        ),
                        SettingListItem(
                          icon: Icons.location_on_outlined,
                          title: AppStrings.myAddresses,
                          onTap: () {
                            context.pushName(AppRoutes.savedAddresses);
                          },
                        ),
                        SettingListItem(
                          icon: Icons.subscriptions_outlined,
                          title: AppStrings.mySubscriptions,
                          onTap: () {
                            context.pushName(AppRoutes.subscriptions);
                          },
                        ),
                        SettingListItem(
                          icon: Icons.credit_card,
                          title: AppStrings.paymentMethods,
                          onTap: () {
                            context.pushName(AppRoutes.paymentMethods);
                          },
                        ),
                      ]),

                      verticalSpace(10),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(
                          color: AppColors.borderGrey,
                          thickness: 1,
                        ),
                      ),

                      verticalSpace(10),

                      _buildSettingGroup([
                        SettingListItem(
                          icon: Icons.settings_outlined,
                          title: AppStrings.settings,
                          onTap: () {
                            context.pushName(AppRoutes.setting);
                          },
                        ),
                        SettingListItem(
                          icon: Icons.language,
                          title: AppStrings.contactUs,
                          onTap: () {
                            context.pushName(AppRoutes.contactUs);
                          },
                        ),
                      ]),
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

  Widget _buildSettingGroup(List<Widget> items) {
    return Column(
      children: items
          .map((item) => Padding(padding: const EdgeInsets.all(2), child: item))
          .toList(),
    );
  }
}
