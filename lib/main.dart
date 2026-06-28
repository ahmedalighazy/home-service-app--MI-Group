import 'dart:ui' as ui;

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/utils/helpers/observer.dart';

import 'core/di/injection.dart';
import 'core/language/language_cubit.dart';
import 'core/routes/app_routes.dart';
import 'core/themes/theming/app_theme.dart';
import 'core/utils/helpers/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await setupGetIt();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        supportedLocales: const [Locale('ar'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        child: BlocProvider<LanguageCubit>.value(
          value: getIt<LanguageCubit>(),
          child: const HomeServiceApp(),
        ),
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
          listener: (ctx, languageState) {},
          builder: (ctx, languageState) {
            return MaterialApp.router(
              title: 'Home Service App',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              routerConfig: AppRouter.router,
              locale: languageState.isArabic
                  ? const Locale('ar')
                  : const Locale('en'),
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
