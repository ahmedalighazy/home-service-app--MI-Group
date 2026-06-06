import 'package:flutter/material.dart';

class SettingGroupWidget extends StatelessWidget {
  final List<Widget> items;

  const SettingGroupWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => Padding(padding: const EdgeInsets.all(2), child: item))
          .toList(),
    );
  }
}
