import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routes/app_routes.dart';
import 'core/themes/theming/app_theme.dart';
import 'core/di/injection.dart';
import 'core/utils/helpers/cache_helper.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await setupGetIt();
  runApp(
    DevicePreview(enabled: true, builder: (context) => const HomeServiceApp()),
  );
}

class HomeServiceApp extends StatelessWidget {
  const HomeServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    String appLanguage = 'ar';
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Home Service App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          home: const SplashScreen(),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          locale: Locale(appLanguage),
          supportedLocales: const [Locale('en', ''), Locale('ar', '')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            // Use device locale if supported, otherwise fallback to first supported locale
            return supportedLocales.contains(locale)
                ? locale
                : supportedLocales.first;
          },
        );
      },
    );
  }
}
