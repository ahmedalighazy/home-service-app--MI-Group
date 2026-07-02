import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/repos/auth_repo.dart';
import '../../features/profile/data/repo/profile_repo.dart';
import '../language/language_cubit.dart';
import '../network/api_service.dart';
import '../network/dio_client.dart';
import '../routes/app_routes.dart';
import '../token/refresh_token_handler.dart';
import '../token/token_manager.dart';
import '../utils/helpers/cache_helper.dart';
import '../utils/l10n/localization_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // ── Infrastructure ─────────────────────────────────────────

  await CacheHelper.init();

  if (!getIt.isRegistered<SharedPreferences>()) {
    getIt.registerSingleton<SharedPreferences>(CacheHelper.sharedPreferences);
  }

  if (!getIt.isRegistered<GoRouter>()) {
    getIt.registerLazySingleton<GoRouter>(() => AppRouter.router);
  }

  // ── Auth ────────────────────────────────────────────────────

  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt<ApiService>()));
  }

  // ── Profile ─────────────────────────────────────────────────

  if (!getIt.isRegistered<ProfileRepo>()) {
    getIt.registerLazySingleton<ProfileRepo>(
      () => ProfileRepo(getIt<ApiService>()),
    );
  }

  // ── Core ────────────────────────────────────────────────────

  if (!getIt.isRegistered<LocalizationService>()) {
    getIt.registerSingleton<LocalizationService>(LocalizationService.instance);
  }

  if (!getIt.isRegistered<LanguageCubit>()) {
    getIt.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  }

  // ── Network ────────────────────────────────────────────────

  // 3️⃣ تسجيل TokenManager (يعتمد على CacheHelper)
  if (!getIt.isRegistered<TokenManager>()) {
    getIt.registerLazySingleton<TokenManager>(() => TokenManager());
  }

  final dio = DioClient.getDio(tokenManager: getIt<TokenManager>());

  if (!getIt.isRegistered<ApiService>()) {
    getIt.registerLazySingleton<ApiService>(() => ApiService(dio));
  }

  // 4️⃣ تسجيل RefreshTokenHandler (يعتمد على Dio, TokenManager, GoRouter)

  // // 5️⃣ تسجيل ApiInterceptor (يعتمد على TokenManager, RefreshTokenHandler)
  // if (!getIt.isRegistered<ApiInterceptor>()) {
  //   getIt.registerLazySingleton<ApiInterceptor>(
  //     () => ApiInterceptor(
  //       tokenManager: getIt<TokenManager>(),
  //       refreshHandler: getIt<RefreshTokenHandler>(),
  //     ),
  //   );
  // }
}
