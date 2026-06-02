import 'package:flutter/material.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';
import 'package:home_service_app/features/profile/widget/profile_header.dart';

import '../widget/profile_card.dart';
import '../widget/setting_list_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ProfileHeader(),

        Positioned.fill(
          top: height(context) * 0.17,
          child: Column(
            children: [
              const ProfileCard(),
              verticalSpace(10),
              _buildSettingGroup([
                SettingListItem(
                  icon: Icons.account_circle_outlined,
                  title: 'الملف الشخصي',
                  onTap: () {},
                ),
                SettingListItem(
                  icon: Icons.favorite_border_outlined,
                  title: 'المفضلات',
                  onTap: () {},
                ),
                SettingListItem(
                  icon: Icons.location_on_outlined,
                  title: 'العناوين',
                  onTap: () {},
                ),
                SettingListItem(
                  icon: Icons.subscriptions_outlined,
                  title: 'اشتراكاتي',
                  onTap: () {},
                ),
                SettingListItem(
                  icon: Icons.credit_card,
                  title: 'طرق الدفع',
                  onTap: () {},
                ),
              ]),
              verticalSpace(10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(
                  color: Color(0x1F000000),
                  thickness: 1,
                  height: 20,
                ),
              ),
              verticalSpace(10),

              _buildSettingGroup([
                SettingListItem(
                  icon: Icons.settings_outlined,
                  title: 'الاعدادات',
                  onTap: () {},
                ),
                SettingListItem(
                  icon: Icons.language,
                  title: 'تواصل معنا',
                  onTap: () {},
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  // Helper function to build groups of settings with standard spacing
  Widget _buildSettingGroup(List<Widget> items) {
    return Column(
      children: items
          .map(
            (item) => Padding(padding: const EdgeInsets.all(2.0), child: item),
          )
          .toList(),
    );
  }
}
