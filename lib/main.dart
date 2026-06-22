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

  final languageCubit = getIt<LanguageCubit>();
  final initialLocale =
      languageCubit.state.isArabic ? const Locale('ar') : const Locale('en');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: initialLocale,
      child: BlocProvider<LanguageCubit>.value(
        value: getIt<LanguageCubit>(),
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
      builder: (ctx, child) {
        return BlocConsumer<LanguageCubit, LanguageState>(
          bloc: getIt<LanguageCubit>(),
          // Listener fires as a side-effect, NOT during build — safe to call setLocale here
          listener: (ctx, languageState) {
            final newLocale = languageState.isArabic
                ? const Locale('ar')
                : const Locale('en');
            if (ctx.locale != newLocale) {
              ctx.setLocale(newLocale);
            }
          },
          builder: (ctx, languageState) {
            final locale = languageState.isArabic
                ? const Locale('ar')
                : const Locale('en');

            return MaterialApp.router(
              key: ValueKey(locale.languageCode),
              title: 'Home Service App',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              routerConfig: AppRouter.router,
              locale: locale,
              supportedLocales: ctx.supportedLocales,
              localizationsDelegates: ctx.localizationDelegates,
              builder: (context, child) => Directionality(
                textDirection: languageState.isArabic
                    ? ui.TextDirection.rtl
                    : ui.TextDirection.ltr,
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}
