import 'package:flutter/material.dart';
import 'package:home_service_app/core/utils/helpers/spacing.dart';

import '../../../core/extensions/extention_navigator.dart';
import '../widget/profile_card.dart';
import '../widget/profile_header.dart';
import '../widget/setting_list_item.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: height(context) ,
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
                          title: 'الملف الشخصي',
                          onTap: () {

                            context.pushName('/edit-profile');
                          },
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
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(
                          color: Color(0x1F000000),
                          thickness: 1,
                        ),
                      ),

                      verticalSpace(10),

                      _buildSettingGroup([
                        SettingListItem(
                          icon: Icons.settings_outlined,
                          title: 'الاعدادات',
                          onTap: () {

                            context.pushName('/setting');
                          },
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
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingGroup(List<Widget> items) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.all(2),
              child: item,
            ),
          )
          .toList(),
    );
  }
}
