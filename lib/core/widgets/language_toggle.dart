import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import '../themes/colors/app_colors.dart';
import '../utils/helpers/cache_helper.dart';

class LanguageToggle extends StatefulWidget {
  final Function(String)? onLanguageChanged;

  const LanguageToggle({super.key, this.onLanguageChanged});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  bool isArabic = true;

  @override
  void initState() {
    super.initState();
    final savedLang = CacheHelper.getData(key: 'language') ?? 'ar';
    isArabic = savedLang == 'ar';
  }

  void _onToggle(bool value) async {
    setState(() => isArabic = value);
    final newLang = value ? 'ar' : 'en';
    await CacheHelper.saveData(key: 'language', value: newLang);
    widget.onLanguageChanged?.call(newLang);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(5),
      child: AnimatedToggleSwitch<bool>.dual(
        current: isArabic,
        first: false, // EN
        second: true, // AR
        onChanged: _onToggle,
        style: ToggleStyle(
          backgroundColor: const Color(0xFFEEEEEE),
          borderColor: const Color(0xFFDDDDDD),
          indicatorColor: AppColors.greenPrimary,
          borderRadius: BorderRadius.circular(16),
        ),
        styleBuilder: (value) =>
            ToggleStyle(indicatorColor: AppColors.greenPrimary),
        iconBuilder: (value) => Text(
          value ? 'ع' : 'EN',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        textBuilder: (value) => Center(
          child: Text(
            value ? 'EN' : 'ع',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF555555),
            ),
          ),
        ),
        height: 32,
        spacing: 4,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOutCubic,
      ),
    );
  }
}
