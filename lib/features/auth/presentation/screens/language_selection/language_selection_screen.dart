import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service_app/core/routes/app_routes.dart';
import 'package:home_service_app/core/themes/colors/app_colors.dart';
import 'package:home_service_app/core/themes/image/app_assets.dart';
import 'package:home_service_app/core/utils/helpers/cache_helper.dart';
import 'package:home_service_app/core/language/language_cubit.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen>
    with TickerProviderStateMixin {
  String? _selectedLang;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    if (_selectedLang == null) return;
    await CacheHelper.saveData(key: 'language', value: _selectedLang!);
    if (!mounted) return;
    if (_selectedLang == 'ar') {
      context.read<LanguageCubit>().setArabic();
    } else {
      context.read<LanguageCubit>().setEnglish();
    }
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A434E),
              Color(0xFF189AB4),
              Color(0xFF0A434E),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Topographic background
            Positioned.fill(
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  AppAssets.topographicBg,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Decorative blobs
            Positioned(
              top: -80.h,
              right: -60.w,
              child: Container(
                width: 250.w,
                height: 250.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.greenPrimary.withValues(alpha: 0.15),
                ),
              ),
            ),
            Positioned(
              bottom: -100.h,
              left: -80.w,
              child: Container(
                width: 300.w,
                height: 300.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.dark.withValues(alpha: 0.3),
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: Column(
                      children: [
                        SizedBox(height: 60.h),

                        // Globe icon
                        Container(
                          width: 90.w,
                          height: 90.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white.withValues(alpha: 0.12),
                            border: Border.all(
                              color: AppColors.white.withValues(alpha: 0.25),
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            Icons.language_rounded,
                            size: 46.sp,
                            color: AppColors.white,
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Title
                        Text(
                          'اختر لغتك',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: AppColors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Choose Your Language',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: AppColors.white.withValues(alpha: 0.7),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        SizedBox(height: 14.h),

                        Text(
                          'يمكنك تغيير اللغة لاحقاً من الإعدادات',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ibmPlexSansArabic(
                            color: AppColors.white.withValues(alpha: 0.55),
                            fontSize: 13.sp,
                          ),
                        ),

                        SizedBox(height: 52.h),

                        // Language Options
                        _LanguageCard(
                          flag: '🇸🇦',
                          langName: 'العربية',
                          subName: 'Arabic',
                          code: 'ar',
                          isSelected: _selectedLang == 'ar',
                          onTap: () => setState(() => _selectedLang = 'ar'),
                        ),

                        SizedBox(height: 16.h),

                        _LanguageCard(
                          flag: '🇬🇧',
                          langName: 'English',
                          subName: 'الإنجليزية',
                          code: 'en',
                          isSelected: _selectedLang == 'en',
                          onTap: () => setState(() => _selectedLang = 'en'),
                        ),

                        const Spacer(),

                        // Continue Button
                        AnimatedOpacity(
                          opacity: _selectedLang != null ? 1.0 : 0.4,
                          duration: const Duration(milliseconds: 300),
                          child: GestureDetector(
                            onTap: _selectedLang != null ? _onContinue : null,
                            child: Container(
                              width: double.infinity,
                              height: 58.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.r),
                                gradient: _selectedLang != null
                                    ? const LinearGradient(
                                        colors: [
                                          Color(0xFF189AB4),
                                          Color(0xFF0A434E),
                                        ],
                                      )
                                    : null,
                                color: _selectedLang == null
                                    ? AppColors.white.withValues(alpha: 0.15)
                                    : null,
                                boxShadow: _selectedLang != null
                                    ? [
                                        BoxShadow(
                                          color: AppColors.greenPrimary
                                              .withValues(alpha: 0.4),
                                          blurRadius: 20,
                                          offset: const Offset(0, 8),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  'متابعة  ›',
                                  style: GoogleFonts.ibmPlexSansArabic(
                                    color: AppColors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 48.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String flag;
  final String langName;
  final String subName;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.flag,
    required this.langName,
    required this.subName,
    required this.code,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: double.infinity,
        height: 76.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: isSelected
              ? AppColors.white.withValues(alpha: 0.18)
              : AppColors.white.withValues(alpha: 0.07),
          border: Border.all(
            color:
                isSelected ? AppColors.white : AppColors.white.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.greenPrimary.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              // Flag emoji
              Text(flag, style: TextStyle(fontSize: 32.sp)),
              SizedBox(width: 16.w),

              // Lang names
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      langName,
                      style: GoogleFonts.ibmPlexSansArabic(
                        color: AppColors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subName,
                      style: GoogleFonts.inter(
                        color: AppColors.white.withValues(alpha: 0.6),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),

              // Check indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 26.w,
                height: 26.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? AppColors.white
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.white.withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        color: AppColors.greenPrimary,
                        size: 16.sp,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
