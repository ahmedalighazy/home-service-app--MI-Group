import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_service_app/core/utils/l10n/app_localizations.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart';

import 'core/routes/app_routes.dart';
import 'core/themes/theming/app_theme.dart';
import 'core/di/injection.dart';
import 'core/utils/helpers/cache_helper.dart';
import 'core/utils/helpers/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  configureDependencies();
  runApp(
    DevicePreview(enabled: true, builder: (context) => const HomeServiceApp()),
  );
  // runApp(const HomeServiceApp());
}

class HomeServiceApp extends StatelessWidget {
  const HomeServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appLanguage = 'ar';

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (_) => getIt<NotificationCubit>())],
          child: MaterialApp.router(
            title: 'Home Service App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light,
            routerConfig: AppRouter.router,
            locale: const Locale(appLanguage),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        );
      },
    );
  }
}
