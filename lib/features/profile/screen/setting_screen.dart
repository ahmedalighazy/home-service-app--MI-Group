import 'package:flutter/material.dart';

import '../widget/arrow_back.dart';
import '../widget/setting_list_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        
        title: const Text(
    'الاعدادات',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Color(0xFF2F3E4E) /* Heading-text */,
      fontSize: 20,
      fontFamily: 'IBM Plex Sans Arabic',
      fontWeight: FontWeight.w600,
      height: 1.40,
    ),
  ),
  leading: const ArrowBack(),
  ),
      body: Column(
        children: [

          SettingListItem(
            icon: Icons.notifications_outlined,
            title: 'تغيير كلمة المرور',
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
           SettingListItem(
            icon: Icons.lock_outline,
            title: 'الخصوصية',
            onTap: () {},
          ),
            const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
           SettingListItem(
            icon: Icons.help_outline,
            title: 'المساعدة',
            onTap: () {},
          ),
            const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
        ],
      ));
  }
}