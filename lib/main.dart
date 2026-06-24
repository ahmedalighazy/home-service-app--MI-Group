import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/di/injection.dart';
import 'core/language/language_cubit.dart';
import 'core/routes/app_routes.dart';
import 'core/themes/theming/app_theme.dart';
import 'core/utils/helpers/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  await CacheHelper.init();
  await setupGetIt();

  runApp(
    BlocProvider<LanguageCubit>.value(
      value: getIt<LanguageCubit>(),
      child: EasyLocalization(
        supportedLocales: const [Locale('ar'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        saveLocale: true,
        useOnlyLangCode: true,
        child: const HomeServiceApp(),
      ),
    ),
  );
}

class HomeServiceApp extends StatelessWidget {
  const HomeServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp.router(
              key: ValueKey(context.locale.languageCode),
              title: 'Home Service App',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              routerConfig: AppRouter.router,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              builder: (finalCtx, child) => Directionality(
                textDirection:
                    state.isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}
